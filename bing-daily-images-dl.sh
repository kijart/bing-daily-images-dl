get_today_bing_images() {
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

download_images() {
  working_directory=wallpapers/`date +"%Y%m%d"`
  bing_images_endpoint=https://www.bing.com/HPImageArchive.aspx\?format\=js\&idx\=0\&n\=8

  echo "Downloading today's bing images...\n"

  mkdir -p $working_directory
  cd $working_directory
  curl -s -X GET $bing_images_endpoint | get_today_bing_images | xargs -n 1 curl -O

  # fix filenames
  for filename in th\?id=*
  do
    mv "$filename" "$(echo $filename | awk -F'[=&]' '{print $2}' | sed 's/^.\{4\}//g')"
  done

  echo "\nImages stored in $working_directory\n"
  cd ..
  echo "Done"
}

download_images
