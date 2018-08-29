function git_commit_push_changes {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"

  git checkout -b wallpapers

  git add .
  git commit --message "Bing daily images (`date +"%Y-%m-%d"`)"

  git remote add origin-token https://${GITHUB_TOKEN}@github.com/kijart/bing-daily-images-dl.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-token wallpapers
}

git_commit_push_changes
