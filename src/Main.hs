{-# LANGUAGE BangPatterns  #-}
module Main (main) where

import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game
import Data.Word
import Data.ByteString (ByteString, pack)
import qualified Data.ByteString as B
import Control.Monad
import GHC.Float
import qualified Data.Vector.Mutable as V

import Codec.Picture
import Graphics.Gloss.Juicy

data Stare = Stare Picture (Double,Double)

afiseazaCoordonate :: Double -> Double -> Picture
afiseazaCoordonate x y = 
    translate (-250) (-250) $ 
    scale 0.1 0.1 $ 
    color black $ 
    text $ show x ++ " " ++ show y 

defaultImage :: Picture
defaultImage = calculeazaImagine (-0.0417) 0.7116

afiseazaStare :: Stare -> IO Picture
afiseazaStare (Stare picture (x,y)) = return $ pictures [ picture , afiseazaCoordonate x y]

modificaStare :: Event -> Stare -> IO Stare
modificaStare (EventMotion (x,y)) (Stare imagine _) = do
    let x' = 2 * (float2Double x) / 512 
        y' = 2 * (float2Double y) / 512 
    return $ Stare imagine (x',y')
modificaStare _ stare = return $ stare

calculeaazaImagineNoua :: Float -> Stare -> IO Stare
calculeaazaImagineNoua _ (Stare _ (x, y)) = return $ Stare (calculeazaImagine x y) (x, y)

main :: IO ()
main = do 
    playIO (InWindow "Fractal Julia" (512, 512) (10, 10)) white 20 (Stare defaultImage (0,0)) afiseazaStare modificaStare calculeaazaImagineNoua


apartineInSetulJulia :: Double -> Double -> Double -> Double -> Int
apartineInSetulJulia !cx !cy !x !y = calculeaza x y 0
    where calculeaza x y n | n > 50 = n
          calculeaza x y n | x*x + y*y > 4 = n
          calculeaza !x !y !n = calculeaza (x*x - y*y + cx) (2*x*y + cy) (n + 1)

calculeazaValoarePixel :: Int -> PixelRGB8
calculeazaValoarePixel n = 
    let word = fromIntegral $ 255 - if n > 50 then 190 else (if n + 40 > 255 then 255 else n + 40) 
    in PixelRGB8 word word word

calculeazaImagine :: Double -> Double -> Picture 
calculeazaImagine cx cy = 
    fromImageRGB8 $! generateImage 
        (\x y -> calculeazaValoarePixel $! 
            apartineInSetulJulia cx cy ((fromIntegral (256-x))/256.0) ((fromIntegral (256-y))/256.0)) 
        512 512