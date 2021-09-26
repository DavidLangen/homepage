#!/bin/bash
xdg-open http://localhost:8000/dist/index.html
elm-live src/Main.elm -Hv --start-page="dist/index.html" -- --output="./dist/elm.js" --debug
