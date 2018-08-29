function get_today_bing_images() {
  KEY="url"

  awk -F"[,:}]" '{
    for (i=1; i<=NF; i++) {
      if ($i~/'$KEY'\042/) {
        url="https://www.bing.com"$(i+1)
        print url
      }
    }
  }' | tr -d '"'
}

function download_images() {
  working_directory=wallpapers/`date +"%Y%m%d"`
  bing_images_endpoint=https://www.bing.com/HPImageArchive.aspx\?format\=js\&idx\=0\&n\=8

  echo "Downloading today's bing images...\n"

  mkdir -p $working_directory
  cd $working_directory
  curl -s -X GET $bing_images_endpoint | get_today_bing_images | xargs -n 1 curl -O

  echo "\nImages stored in $working_directory\n"
  cd ..
  echo "Done"
}

function git_commit_push_changes {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"

  git add .
  git commit --message "Bing daily images: $TRAVIS_BUILD_NUMBER"

  git remote add origin https://${GITHUB_TOKEN}@github.com/kijart/bing-daily-images-dl.git > /dev/null 2>&1
  git push --quiet --set-upstream origin master
}

function main() {
  download_images
  git_commit_push_changes
}

main
