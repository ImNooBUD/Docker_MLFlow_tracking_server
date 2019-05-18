#!/bin/bash

set -e

mlflow server \
    --backend-store-uri $BACKEND_STORE \
    --default-artifact-root $ARTIFACT_STORE \
    --host 0.0.0.0