module Style exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


color =
  { lightBlue = rgb255 30 144 255
  , blue = rgb255 0 116 217
  }


pageAlign : List (Attribute msg)
pageAlign =
  [ width
      (fill
        |> maximum 800
      )
  , height fill
  , centerX
  , paddingEach
    { top = 40
    , bottom = 150
    , left = 30
    , right = 30
    }
  , spacing 20
  ]
