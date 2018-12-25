git_commit_push_changes() {
  git remote add origin-token https://${GITHUB_TOKEN}@github.com/kijart/bing-daily-images-dl.git > /dev/null 2>&1
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"

  git checkout -b wallpapers
  git pull origin-token wallpapers

  git add .
  git commit --message "Bing daily images (`date +"%Y-%m-%d"`)"

  git push --quiet --set-upstream origin-token wallpapers
}

git_commit_push_changes
