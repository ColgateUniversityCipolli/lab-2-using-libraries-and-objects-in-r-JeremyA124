library(stringr)
dirs <- list.dirs(path = "Music", full.names = TRUE, recursive = TRUE)
slash.count <- str_count(dirs, "/")
album.num <- which(slash.count == 2)
album <- rep(x = NA, times = length(album.num))
song.list <- c()
code.to.process <- c()
tracks <- c()
artists <- c()
output <- c()
code.to.process <- c()

for(i in 1:length(album.num)){
  album[i] = dirs[album.num[i]]
}

for(file in album){
  song.names = list.files(path = file)
  for(i in 1:length(song.names)){
    song.list = c(song.list, song.names[i])
  }
}

for(i in 1:length(song.list)){
  code.to.process = c(code.to.process, paste(album[ceiling(i/2)], "/", song.list[i], sep = ""))
}

for(song in song.list){
  song = str_sub(song, start = 1, end =-5)
  song = str_split_1(song, "-")
  tracks = c(tracks, song[3])
  artists = c(artists, song[2])
}

for(i in 1:length(song.list)){
  curr.album = str_split_1(album[ceiling(i/2)], "/")
  output = c(output, paste(, artists[i], "-", curr.album[3], "-", tracks[i], ".json", sep = ""))
}

for(i in 1:length(song.list)){
  code.to.process = c(code.to.process, paste("streaming_extractor_music.exe", song.list[i], output[i]))
}
print(code.to.process)
