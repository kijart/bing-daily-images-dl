#!/bin/bash

update_readme_images() {
  # remove previous images
  fixed_line_number=$(cat < README.md | awk '/<!-- Wallpapers -->/{ print NR; exit }')
  tmp_readme=$(head -n "$fixed_line_number" README.md)
  printf "%s\n\n" "$tmp_readme" > README.md

  # add latest images
  modified_filename_list=$(git status --porcelain | cut -c4-)
  for filename in $modified_filename_list; do
    if [[ $filename == *.jpg ]]; then
      printf "### %s\n\n" "$filename" >> README.md
      printf "![%s](%s)\n\n" "$filename" "$filename" >> README.md
    fi
  done
}

git_remote_setup() {
  git remote add origin-token https://"${GITHUB_TOKEN}"@github.com/kijart/bing-daily-images-dl.git > /dev/null 2>&1
  git config --global user.email "kijart+ci@gmail.com"
  git config --global user.name "Travis CI"

  git add .
}

git_commit_push_changes() {
  git add .
  git commit --message "Bing daily images ($(date +"%Y-%m-%d"))"
  git push --quiet --set-upstream origin-token HEAD:master
}

git_remote_setup
update_readme_images
git_commit_push_changes
