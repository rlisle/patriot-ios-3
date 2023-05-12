#!/bin/sh
echo "DEBUG: ci_post_clone"
echo "ls -al /Volumes/workspace/repository/ci_scripts" # ., .., Artifacts, ci_post_clone.sh, ci_post_xcodebuild.sh
ls -al /Volumes/workspace/repository/ci_scripts
echo "ls -al /Volumes/workspace/repository/ci_scripts/PatriotTests" # ., .., Artifacts, ci_post_clone.sh, ci_post_xcodebuild.sh
ls -al /Volumes/workspace/repository/ci_scripts/PatriotTests
