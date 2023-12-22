{-# Language OverloadedStrings #-}

import Text.Blaze.Svg11
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.String (renderSvg)
import Data.String
import qualified SVGDraw as SVGDraw

main = putStrLn $ renderSvg svgDoc

lineDrawing x = x ! A.stroke "black" ! A.fill "white"
move (x,y) elem = elem ! A.transform (translate x y)
rectangle x y = lineDrawing $ S.rect ! A.width (fromString (show x)) ! A.height (fromString (show y))

svgDoc :: S.Svg
svgDoc = S.docTypeSvg ! A.version "1.1" ! A.width "153mm" ! A.height "127mm" 
   ! A.viewbox "0 0 153 127" $ do
   rectangle 153 126
   move (boarder, boarder) $ rectangle bigW bigH
   move (boarder, boarder*2+bigH) $ rectangle bigW bigH
   move (bigW+boarder*2,boarder) $ rectangle littleW littleH
   move (bigW+boarder*2+littleW+smallBoarder,boarder+smallBoarder+littleH) $ rectangle littleW littleH
   move (bigW+boarder*2,boarder+smallBoarder+littleH) $ rectangle littleW littleH
   move (bigW+boarder*2+littleW+smallBoarder,boarder) $ rectangle littleW littleH

   move (bigW+boarder*2,boarder+boarder+bigH) $ rectangle littleW littleH
   move (bigW+boarder*2+littleW+smallBoarder,boarder+smallBoarder+littleH+boarder+bigH) $ rectangle littleW littleH
   move (bigW+boarder*2,boarder+smallBoarder+littleH+boarder+bigH) $ rectangle littleW littleH
   move (bigW+boarder*2+littleW+smallBoarder,boarder+boarder+bigH) $ rectangle littleW littleH

fromInches = (*25.4)
boarder = fromInches 0.5
smallBoarder = fromInches 0.25
width = fromInches 6
height = fromInches 5
bigH = (height-boarder*3)/2
bigW = (width-boarder*3)/2
littleW = (bigW - smallBoarder) / 2
littleH = (bigH - smallBoarder) / 2
