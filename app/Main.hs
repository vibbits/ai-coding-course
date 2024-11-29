{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

{-| A "small language model"
Build a 2-gram distribution from an input text. Then, with a single-word prompt,
generate @maxTokens@ tokens.
-}

module Main (main) where

import Prelude (
      IO
    , Int
    , String
    , Bool
    , Maybe (Just, Nothing)
    , putStr
    , readFile
    , foldr
    , drop
    , zip
    , ($), (.), (>>=), (<>)
    , (+), (-), (<=), (>=)
    , reverse
    , elem
    , otherwise
    , not
    , sum
    , fst
    , snd
    , putStrLn
    , show
    , length)
import Control.Monad (forM_)
import Data.Map.Strict (
      Map
    , empty
    , alter
    , singleton
    , insertWith
    , elems
    , toList
    , lookup)
import qualified Data.Text as T
import System.Environment (getArgs)
import System.Random (uniformR, initStdGen, StdGen)

type Distribution = Map T.Text Int
type Model = Map T.Text Distribution

maxTokens :: Int
maxTokens = 100

{-| Convert some text into a list of tokens
    Punctuation (e.g. '.', ':', ',') should be a single token

    >>> tokenize "Hello, world!"
    ["Hello", ",", "world", "!"]
-}
tokenize :: T.Text -> [T.Text]
tokenize = go [] . T.replace "“" "\"" . T.replace "”" "\"" . T.replace "‘" "'" . T.replace "’" "'" . T.replace "\r" ""
    where
        zeroSpacedToken :: T.Text -> Bool
        zeroSpacedToken x = x `elem`
            [".", "?", "!", "-", "[", "]", "(", ")", "/", ";", ",",
             "<", ">", "=", ":", "#", "\"", "'"]

        go :: [T.Text] -> T.Text -> [T.Text]
        go acc t
            | T.null t = reverse acc
            | T.head t `elem` [' ', '\t', '\n'] =
                go acc (T.dropWhile (`elem` [' ', '\t', '\n']) t)
            | zeroSpacedToken (T.take 1 t) =
                go (T.take 1 t : acc) (T.drop 1 t)
            | otherwise =
                let (word, rest) = T.span (not . (`elem` [' ', '\t', '\n'])) t
                in go (word : acc) rest

{-| Find token bi-gram frequencies. -}
createModel :: String -> Model
createModel text = foldr updateModel empty $ zip tokens $ drop 1 tokens
    where
        tokens :: [T.Text]
        tokens = tokenize $ T.pack text

        updateModel :: (T.Text, T.Text) -> Model -> Model
        updateModel (first, second) =
            alter (Just . updateDistribution second) first

        updateDistribution :: T.Text -> Maybe (Map T.Text Int) -> Map T.Text Int
        updateDistribution word Nothing = singleton word 1
        updateDistribution word (Just dist) =
            insertWith (+) word 1 dist

{-| Pick a word from the distribution, weighted by its frequency. -}
weightedChoice :: StdGen -> Distribution -> Maybe (T.Text, StdGen)
weightedChoice gen distribution =
    let
        totalWeight :: Int
        totalWeight = sum (elems distribution)

        unifrm :: (Int, StdGen)
        unifrm = uniformR (1, totalWeight) gen

        go :: [(T.Text, Int)] -> Int -> Maybe (T.Text, StdGen)
        go [] _ = Nothing
        go ((word, weight):xs) remaining
            | remaining <= weight = Just (word, snd unifrm)
            | otherwise = go xs (remaining - weight)
    in
    go (toList distribution) $ fst unifrm

{-| Generate text from the model. -}
generateText :: StdGen -> Model -> T.Text -> [T.Text]
generateText gen model first = go gen first 1 [first]
    where
        go :: StdGen -> T.Text -> Int -> [T.Text] -> [T.Text]
        go gen' current count acc
            | count >= maxTokens = reverse acc
            | otherwise = 
                case lookup current model >>= weightedChoice gen' of
                    Just (next, nGen) -> go nGen next (count + 1) (next : acc)
                    Nothing -> reverse acc

{-| Add a space between words, except for punctuation. -}
wordSpacing :: (T.Text, T.Text) -> T.Text
wordSpacing words@(a, b) =
    if b `elem` ["\"", "?", ".", ";", ",", ")", "!", "'", ":"] then
        a
    else case words of
        ("'", "s") -> a
        ("'", "t") -> a
        ("'", "v") -> a
        ("'", _) -> a <> " "
        _ -> a <> " "

{-| Parse command line arguments and generate text. -}
main :: IO ()
main = do
    args <- getArgs
    case args of
        [filename, firstWord] -> do
            gen <- initStdGen
            text <- readFile filename
            let model = createModel text
            let generatedTokens = generateText gen model $ T.pack firstWord
            forM_ (zip generatedTokens $ drop 1 generatedTokens) (putStr . T.unpack . wordSpacing)
            putStrLn $ "\n" <> show (length generatedTokens) <> " tokens generated."
        _ -> putStr "Usage: <filename> <first word>\n"