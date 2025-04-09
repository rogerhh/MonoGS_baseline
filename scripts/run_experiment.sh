#!/bin/bash

set -e

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_DIR=$(dirname "$SCRIPT_DIR")
RESULTS_DIR="$PROJECT_DIR/results"
WANDB_DIR="$PROJECT_DIR/wandb"
SAVE_DIR="$PROJECT_DIR/saved_runs"

cd "$PROJECT_DIR"

CONFIG="$PROJECT_DIR/configs/mono/tum/fr3_office.yaml"

# Run the experiment
# python3 slam.py --config $CONFIG --eval 2>&1 | tee run.log

# Check the log to see where the results are saved
grep_str="$(grep "saving results in" run.log)"

# Split the grep_str by "/" and get the last part
datetime="${grep_str##*/}"

RESULTS_DIR_DATETIME="$(ls -d $RESULTS_DIR/*/$datetime)"


mv run.log "$RESULTS_DIR_DATETIME/run.log"

echo "Copying $RESULTS_DIR_DATETIME to $SAVE_DIR/$datetime"
cp -rf "$RESULTS_DIR_DATETIME" "$SAVE_DIR/$datetime"

echo "Copying $WANDB_DIR/*${datetime}* to $SAVE_DIR/$datetime"
cp -rf $WANDB_DIR/*${datetime}* "$SAVE_DIR/$datetime"

