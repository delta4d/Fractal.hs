-- Draw fractal by escape time method

module Escape where

import Graphics.GD
import Data.Complex

import Draw

type C = Complex Double


-- maxTime            ->
-- maxRadius          ->
-- iteration function ->
-- initial value      ->
-- time to escape
escape :: Int -> Double -> (C -> C) -> C -> Int
escape maxTime maxRadius f x = length $ takeWhile (\z -> magnitude z < maxRadius) $ take (maxTime + 1) $ iterate f x

-- exit by difference
escape' :: Int -> Double -> (C -> C) -> C -> Int
escape' maxTime minDiff f x = length $ takeWhile (\(a, b) -> abs (a - b) > minDiff) st where
    a  = map magnitude $ take (maxTime + 2) $ iterate f x
    st = zip a (tail a)

-- f z = z^2 + c, z0 = 0
mandelbrot :: IO ()
mandelbrot = drawFractal "mandelbrot.png" imageSize coorRange colorMagic where
    imageSize = (1000, 1000)
    coorRange = (-2.0, 1.0, -1.5, 1.5)
    colorMagic (x, y)
        | t > maxTime   = rgb 0 0 0
        | otherwise     = color
        where maxTime   = 256
              maxRadius = 2.0
              f         = \z -> z^2 + (x :+ y)
              t         = (escape maxTime maxRadius f 0) - 1
              color     = rgb t t t


-- quadratic polynomials is only a small subset of Julia set
-- f z = z^2 + c, z0 unset
julia :: C -> IO ()
julia c = drawFractal "julia.png" imageSize coorRange (colorMagic c) where
    imageSize = (1000, 1000)
    coorRange = (-2.0, 2.0, -2.0, 2.0)
    colorMagic c (x, y)
        | t > maxTime   = rgb 0 0 0
        | otherwise     = color
        where maxTime   = 256
              maxRadius = 2.0
              f         = \z -> z^2 + c
              t         = (escape maxTime maxRadius f (x :+ y)) - 1
              color     = rgb t t t


-- f z = (|Re(z)| + i|Im(z)|)^2 + c, z0 = 0
-- using (-) to generate, for better view
burningShip :: IO ()
burningShip = drawFractal "burningShip.png" imageSize coorRange colorMagic where
    imageSize = (2000, 1500)
    coorRange = (-1.67, -1.65, -0.002, 0.013)
    colorMagic (x, y)
        | t > maxTime   = rgb 0 0 0
        | otherwise     = color
        where maxTime   = 256
              maxRadius = 2.0
              f         = \z -> ((abs $ realPart z) :+ (negate . abs $ imagPart z))^2 + (x :+ y)
              t         = (escape maxTime maxRadius f 0) - 1
              color     = rgb t t t


-- only a subset of Nova
-- f z = z^p - 1
-- z => z - Rf/f' + c, (c = 0)
nova :: Int -> Double -> IO ()
nova p r = drawFractal "nova.png" imageSize coorRange (colorMagic p r) where
    imageSize = (1000, 1000)
    coorRange = (-2.0, 2.0, -2.0, 2.0)
    colorMagic p r (x, y)
        | t > maxTime = rgb 0 0 0
        | otherwise   = color
        where maxTime   = 256
              minDiff   = 0.0001
              cr        = r :+ 0
              f         = \z -> z - cr * (z^p - 1) / (fromIntegral p * z^(p-1))
              t         = (escape' maxTime minDiff f (x :+ y)) - 1
              color     = rgb t t t
