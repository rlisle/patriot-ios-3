#!/bin/sh
# Run command: 'cd /Volumes/workspace/repository/ci_scripts && CI_XCODEBUILD_EXIT_CODE=65 /Volumes/workspace/repository/ci_scripts/ci_post_xcodebuild.sh'
echo "DEBUG: ci_post_xcodebuild"
echo "pwd" #/Volumes/workspace/repository/ci_scripts
pwd
echo "CI = $CI" # CI = TRUE
echo "ls -al" # ., .., Artifacts, ci_post_clone.sh, ci_post_xcodebuild.sh
ls -al
echo "ls -al PatriotTests"
ls -al PatriotTests
echo "ls -al __Snapshots__/PatriotTests"
ls -al __Snapshots__/PatriotTests
echo "ls -al /Volumes/workspace/repository/ci_scripts" # ., .., Artifacts, ci_post_clone.sh, ci_post_xcodebuild.sh
ls -al /Volumes/workspace/repository/ci_scripts
echo "ls -al /Volumes/workspace/repository/ci_scripts/PatriotTests" # ., .., Artifacts, ci_post_clone.sh, ci_post_xcodebuild.sh
ls -al /Volumes/workspace/repository/ci_scripts/PatriotTests
echo "env"
env
echo "Done"
