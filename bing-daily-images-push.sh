git_commit_push_changes() {
  git remote add origin-token https://${GITHUB_TOKEN}@github.com/kijart/bing-daily-images-dl.git > /dev/null 2>&1
  git config --global user.email "kijart+ci@gmail.com"
  git config --global user.name "Travis CI"

  git add .
  git commit --message "Bing daily images (`date +"%Y-%m-%d"`)"

  git push --quiet --set-upstream origin-token master
}

git_commit_push_changes
