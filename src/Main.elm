module Main exposing (main)

import Browser exposing (..)
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, text)
import Html.Events exposing (onClick)
import Url


type alias Model =
    { key : Nav.Key
    }


initialModel key =
    { key = key }


type Msg
    = ClickedLink UrlRequest
    | NoOp


init flags url key =
    ( initialModel key, Cmd.none )


update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        NoOp ->
            ( model, Cmd.none )


document model =
    { title = "Hello"
    , body = [ view model ]
    }


view : Model -> Html Msg
view model =
    div []
        [ a [] [ text "hello" ]
        ]


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = document
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = ClickedLink
        , onUrlChange = always NoOp
        }
