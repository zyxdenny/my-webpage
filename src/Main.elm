module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Svg exposing (Svg)
import Svg.Attributes as SvgAttr

main =
  Browser.sandbox { init = (), update = update, view = view }

type alias Model = ()
type Msg = NoOp
update : Msg -> Model -> Model
update _ model = model

view : model -> Html msg
view _ = layout [] all

svgToElem : Svg msg -> Element msg
svgToElem svg =
  Svg.svg [] [ svg ]
    |> html

-- Elements
lightBlue =
  rgb255 30 144 255

section : String -> List (Element msg) -> Element msg
section title par =
  column
    [ spacing 20 ]
    [ el
        [ Font.bold
        , Font.size 28
        , Font.color (rgb255 0 116 217)
        ]
        (text title)
    , column
      [ spacing 15
      , width fill
      ]
      par
    ]

subsection : String -> List (Element msg) -> Element msg
subsection title par =
  column
    [ spacing 15 ]
    [ el
        [ Font.bold
        , Font.size 20
        ]
        (text title)
    , column
      [ spacing 15
      , width fill
      ]
      par
    ]

mainPar : List (Element msg) -> Element msg
mainPar par =
  paragraph 
    [ spacing 10
    , Font.justify
    ]
    par 

all =
  column
    [ width
        (fill
          |> maximum 800
        )
    , height fill
    , centerX
    , paddingEach
      { top = 60
      , bottom = 150
      , left = 30
      , right = 30
      }
    , spacing 20
    ]
    [ header
    , navbar
    , body
    ]

header =
  row
    [ width fill
    , height (px 180)
    ]
    [ mottoHead
    , portrait
    ]

mottoHead =
  column
    [ width
      (fill
        |> maximum 180
        |> minimum 150
      )
    , height fill
    , Font.family 
      [ Font.external
        { name = "Orbitron"
        , url = "https://fonts.googleapis.com/css2?family=Orbitron"
        }
      , Font.sansSerif
      ]
    , Font.size 25
    , Font.bold
    , spacing 15
    ]
    [ el [ alignRight ] ( text "Technology." )
    , el [ alignRight ] ( text "Artistry." )
    , el [ alignRight ] ( text "Simplicity." )
    , el [ alignRight ] ( text "Reliability." )
    ]

portrait =
  column
    [ alignRight
    , spacing 10
    ]
    [ el
      [ Border.width 2
      , centerX
      ] 
      ( image
        [ width (px 100)
        , height (px 100)
        ]
        { src = "./assets/avatar.jpeg"
        , description = "My Portrait"
        }
      )
    , el
      [ Font.size 15
      , Font.family 
        [ Font.external
          { name = "Fira Sans"
          , url = "https://fonts.googleapis.com/css2?family=Fira+Sans"
          }
        , Font.sansSerif
        ]
      , Font.italic
      , width (fill |> maximum 200)
      , centerX
      ]
      ( paragraph [] 
        [ text "(My self-portrait showing artistry and simplicity...)"
        ]
      )
    ]

navbar =
  let
    navBarElem name =
      el
        [ width <| px 90
        , height <| px 50
        , Border.width 2
        , Border.rounded 8
        , mouseOver [ alpha 0.5 ]
        , Font.size 20
        , Font.family 
          [ Font.external
            { name = "Fira Sans"
            , url = "https://fonts.googleapis.com/css2?family=Fira+Sans"
            }
          , Font.sansSerif
          ]
        ]
        ( el
          [ centerX
          , centerY
          ]
          ( text name )
        )
  in
    row
      [ height (px 80)
      , width
        ( fill
          |> maximum 600
        )
      , spaceEvenly
      , centerX
      , paddingXY 10 0
      ]
      [ navBarElem "Blog"
      , navBarElem "Photo"
      , navBarElem "Recipe"
      ]

--post =
--  Svg.circle
--    [ SvgAttr.cx "38"
--    , SvgAttr.cy "38"
--    , SvgAttr.r "38"
--    , SvgAttr.fill "none"
--    , SvgAttr.stroke "black"
--    -- , SvgAttr.strokeWidth "3"
--    ]
--    []
--    |> svgToElem
--    |> el
--    [ width <| px 80
--    , height <| px 80
--    ]

body =
  column
    [ height fill
    , width fill
    , spacing 40
    , Font.size 18
    , Font.family 
      [ Font.external
        { name = "Fira Sans"
        , url = "https://fonts.googleapis.com/css2?family=Fira+Sans"
        }
      , Font.sansSerif
      ]
    ]
    [ about
    , motto
    , cv
    , contact
    , miscellaneous
    ]

about =
  section "About"
    [ mainPar
      [ text
        "Hi! I'm Yuxuan Zheng, currently a Master's student in Computer Science at New York University. "
      , text
        "I got my B.S. in ECE at UM-SJTU Joint Institue (UM has announced to end the partnership with SJTU in 2025, unfortunately) "
      , text
        "in Shanghai with minors in CS and DS."
      ]
    , mainPar
      [ text
        "I will post my thoughts, ideas, and anything I find intersting here. "
      , text
        "I don't use Twitter, Instagram, TikTok or anything where people \"gather together\" and post stuffs in a single app. "
      , text
        "Those are too crowded and a bit noisy for me. "
      , text
        "I like to post things in my "
      , el [ Font.italic ]( text "own" )
      , text
        " place. Cheers for being the landlord of the internet! "
      ]
    ]

motto =
  section "Motto"
    [ mainPar
      [ text
        "Four things I love: "
      , el [ Font.bold ]( text "technology" )
      , text ", "
      , el [ Font.bold ]( text "artistry" )
      , text ", "
      , el [ Font.bold ]( text "simplicity" )
      , text ", and "
      , el [ Font.bold ]( text "reliability" )
      , text ". "
      , text
        "The best technologies are those whose designs are artistic, simple, and reliable enough. "
      ]
    , subsection "Technology"
      [ mainPar
        [ text
          "I'm a fan of new technologies. Technologies in the world of computer evolves rapidly. "
        , text
          "A technology that was cutting-edge a few years ago might be deprecated now (e.g, Apache Spark replaces Hadoop MapReduce). "
        , text
          "I always have an open mind towards new things and always happy to try them out. Recently I'm trying to use "
        , newTabLink
          [ Font.color lightBlue
          ]
          { url = "https://typst.app/"
          , label = text "Typst"
          }
          , text
          " as a replacement to LaTeX in my daily writing, and it has been going smoothly (I highly recommend checking it out!)."
        ]
      ]
    , subsection "Artistry"
      [ mainPar
        [ text
          "Technology and artistry have always been deeply intertwined, as seen in the Renaissance, "
        , text
          "a period of extraordinary creativity fueled by technological innovation. "
        , text
          "Artists like Leonardo da Vinci exemplified this synergy, combining their mastery of art with scientific inquiry and engineering. "
        , text
          "Today, we still need the same spirit." 
        ]
      ]
    , subsection "Simplicity"
      [ mainPar
        [ text
          "There's a prevailing trend of complicating things to an extent that doesn't make sense. "
        , text
          "I believe the best software are those that are both functional and simple. "
        , newTabLink
          [ Font.color lightBlue
          ]
          { url = "https://suckless.org/"
          , label = text "suckless.org"
          }
        , text
          " is where I look for software that \"suck less\". "
        , text
          "A system will finally topple after adding one after another layer of complexity to it. "
        , text
          "So, let's embrace simplicity!"
        ]
      ]
    , subsection "Reliability"
      [ mainPar
        [ text
          "Reliability ensures consistent performance, builds trust, and minimizes failures that could lead to significant consequences. "
        , text
          "As an example, this entire webpage is written in "
        , newTabLink
          [ Font.color lightBlue
          ]
          { url = "https://github.com/zyxdenny/my-webpage"
          , label = text "Elm"
          }
        , text
          ", a functional language for front-end development. "
        , text
          "Elm is statically typed with no runtime exceptions, making it much more reliable than JavaScript."
        ]
      ]
    ]

cv =
  section "CV"
    [ mainPar
      [ text
        "My CV is posted on Github " 
      , newTabLink
        [ Font.color lightBlue
        ]
        { url = "https://github.com/zyxdenny/my-cv/blob/master/cv.pdf"
        , label = text "here"
        }
      , text
        ". "
      , text
        "It is composed in Typst (again, a very cool typesetting software)!"
      ]
    ]

contact =
  section "Contact"
    [ mainPar
      [ text
        "Please contact me via "
      , el
          [ Font.size 16
          , Font.family 
            [ Font.external
              { name = "Fira Code"
              , url = "https://fonts.googleapis.com/css2?family=Fira+Code"
              }
            , Font.monospace
            ]
          , Font.underline
          ]
          ( text "yx.zheng766 [at] gmail [dot] com" )
        , text "."
      ]
    ]

miscellaneous =
  section "Miscellaneous" 
    [ mainPar
      [ text
        "I love sports. I like to watch football, basketball, tennis and badminton matches, "
      , text
        "but the only sports I'm good at are badminton and table tennis."
      ]
    , mainPar
      [ text
        "I love cooking (especially Chinese food, the best of all). I prefer making my own dish rather than eat out. "
      , text
        "This is similar to the spirit if GNU/Linux, where you enjoy making your own stuffs. "
      , el [ Font.italic ]
        ( text "TODO: " )
      , text
        "I will share my recipes here 🤤."
      ]
    , mainPar
      [ text
        "I love photography, though I'm quite new to it. Needs more practice! "
      , el [ Font.italic ]
        ( text "TODO: " )
      , text
        "I will share my photos here 📷."
      ]
    , mainPar
      [ text
        "I'm not a big fan of video games. The only game I was quite \"addicted to\" in the recent years (not anymore now) was "
      , el [ Font.italic ]
        ( text "Hearthstone" )
      , text
        ", where I had fun developing my own deck (mostly OTK decks) and made the combo work. "
      , text
        "Now I feel like games are less attractive to me, compared to, say, building this site, which is even more fun 😃."
      ]
    ]
