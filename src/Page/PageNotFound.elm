module Page.PageNotFound exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Font as Font
import Element.Border as Border

import Style


view : model -> Document msg
view _ =
  { title = "404"
  , body = [ layout [] viewElem ]
  }

viewElem =
  column
    Style.pageAlign
    [ view404
    , viewRedirect
    ]

view404 =
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


viewRedirect =
  paragraph
    [ Font.size 18
    , Font.family 
      [ Font.external
        { name = "Fira Sans"
        , url = "https://fonts.googleapis.com/css2?family=Fira+Sans"
        }
      , Font.sansSerif
      ]
    , centerX
    , centerY
    , Font.center
    ]
    [ text "Go to "
    , link
      [ Font.color Style.color.lightBlue
      ]
      { url = "/home"
      , label = text "Home"
      }
    ]
