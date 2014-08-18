#!/usr/bin/env runhaskell

import Data.Complex
import System.Environment

import Escape

usage :: IO ()
usage = do
    progName <- getProgName
    putStrLn $ "usage: " ++ progName ++ " <fractal type> <args>"
    putStrLn $ "  fractal type: mandelbrot"
    putStrLn $ "                julia x y (x y contructs a complex number x+yi)"
    putStrLn $ "                ship"
    putStrLn $ "                nova p r (f(z) = z^p - 1, z' = z - r*f(z)/f'(z))"

main = do
    (op:args) <- fmap (++ [""] ++ [""]) getArgs -- make sure it matches pattern (_:_)
    case op of
        "help"       -> usage
        "mandelbrot" -> mandelbrot
        "julia"      -> do
            let x = read $ args !! 0 :: Double
            let y = read $ args !! 1 :: Double
            julia (x :+ y)
        "ship"       -> burningShip
        "nova"       -> do
            let p = read $ args !! 0 :: Int
            let r = read $ args !! 1 :: Double
            nova p r
        _            -> usage
