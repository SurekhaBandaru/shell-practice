#!/bin/bash
MOVIES=("Court" "Chaava" "ThirtyFive" "Gudachaari")
echo "first movie: ${MOVIES[0]}"
echo "Last movie: ${MOVIES[3]}"
echo "Fourth Movie: ${MOVIES[4]}"

echo "All available movies: ${MOVIES[@]}"