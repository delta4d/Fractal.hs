module Draw where

import Graphics.GD


-- (x1, x2, y1, y2)
type Range2 = (Double, Double, Double, Double) 
type DPoint = (Double, Double)


-- picture location       ->
-- picture size           ->
-- 2d coordinate range    ->
-- point to color function
drawFractal :: FilePath -> Size -> Range2 -> (DPoint -> Color) -> IO ()
drawFractal fp sz r2 point2color = do
    img <- newImage sz
    mapM_ (\p -> setPixel p (point2color $ point2coordinate p sz r2) img) $ pixels sz
    savePngFile fp img


-- (m, n) -> [0, m] x [0, n]
pixels :: Size -> [Point]
pixels (m, n) = [(x, y) | x <- [0..m], y <- [0..n]]


-- affine transformation
-- 0 => x1, m => x2
-- 0 => y2, n => y1 !!
point2coordinate :: Point -> Size -> Range2 -> DPoint
point2coordinate (x, y) (m, n) (x1, x2, y1, y2) = (x', y') where
    x' = (x2 - x1) / fromIntegral m * fromIntegral x + x1
    y' = (y1 - y2) / fromIntegral n * fromIntegral y + y2
