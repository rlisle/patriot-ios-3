#!/bin/sh
# Run command: 'cd /Volumes/workspace/repository/ci_scripts && CI_XCODEBUILD_EXIT_CODE=65 /Volumes/workspace/repository/ci_scripts/ci_post_xcodebuild.sh'
echo "DEBUG: ci_post_xcodebuild"
echo "pwd" #/Volumes/workspace/repository/ci_scripts
pwd
echo "CI = $CI" # CI = TRUE
echo "ls -al" # ., .., Artifacts, ci_post_clone.sh, ci_post_xcodebuild.sh
ls -al
#echo "ls -al Snapshots"
#ls -al Snapshots
#echo "ls -al Snapshots/PatriotTests"
#ls -al Snapshots/PatriotTests
echo "ls -al Artifacts/PatriotTests/__Snapshots__/MenuTests" # No such file or directory
ls -al Snapshots/PatriotTests/__Snapshots__/MenuTests
echo "ls -al /Volumes/workspace/repository" # ., .., ci_scripts
ls -al /Volumes/workspace/repository
#echo "ls -al /Volumes/workspace/repository/iOS"
#ls -al /Volumes/workspace/repository/iOS
echo "ls -al /Volumes/workspace/repository/ci_scripts" # ., .., Artifacts, ci_post_clone.sh, ci_post_xcodebuild.sh
ls -al /Volumes/workspace/repository/ci_scripts
echo "ls -al Artifacts/PatriotTests/__Snapshots__/MenuTests" # testMenuView.1.png
ls -al Artifacts/PatriotTests/__Snapshots__/MenuTests
echo "env"
env
echo "Done"
