module Page.PageNotFound exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Font as Font
import Element.Border as Border

import Style


view : model -> Document msg
view _ =
  { title = "404"
  , body = [ layout [] all ]
  }

all =
  el
    Style.pageAlign
    viewElem

viewElem =
  el
    [ Font.size 67
    , Font.family 
      [ Font.external
        { name = "Fira Code"
        , url = "https://fonts.googleapis.com/css2?family=Fira+Code"
        }
      , Font.monospace
      ]
    , Font.bold
    , centerX
    , centerY
    ]
    ( text "404" )
