library(stringr)

#TASK 1
low.directory <- list.dirs(path = "Music", full.names = TRUE, recursive = TRUE)
album.num <- which(str_count(low.directory, "/") == 2)
album <- rep(x = NA, times = length(album.num))
song.list <- c()
full.path <- c()
tracks <- c()
artists <- c()
output <- c()
code.to.process <- c()

#Fills the album vector with the album sub directories
for(i in 1:length(album.num)){
  album[i] = low.directory[album.num[i]]
}

#Fills the song.list vector with the song names of each album file
for(file in album){
  song.names = list.files(path = file)
  for(i in 1:length(song.names)){
    song.list = c(song.list, song.names[i])
  }
}

#Fills the full.path vector with the full directory paths of all the .wav files
for(i in 1:length(song.list)){
  for(file in album){
    album.files = list.files(path = file)
    wav.count = str_count(album.files, ".wav")
    for(i in 1:length(album.files)){
      if (album.files[i] == 1){
        full.path = c(full.path, paste('"' ,file, "/", song.list[i], '"',  sep = ""))
      }
    }
  }
}

#extracts all the .wav file's track name and artists name
for(song in song.list){
  song = str_sub(song, start = 1, end =-5)
  song = str_split_1(song, "-")
  tracks = c(tracks, song[3])
  artists = c(artists, song[2])
}

#Create json file names for all the .wav files in the Music Folder
for(i in 1:length(song.list)){
  curr.album = str_split_1(album[ceiling(i/2)], "/")
  output = c(output, paste(artists[i], "-", curr.album[3], "-", tracks[i], ".json", sep = ""))
}

#Processes the Essentia command lines in a vector called code.to.process
for(i in 1:length(song.list)){
  code.to.process = c(code.to.process, paste0("streaming_extractor_music.exe", " ", '"', song.list[i], '"', " ", '"', output[i], '"', rep = ""))
}

#Writes all the command lines in batfile.txt
txt.file = file("batfile.txt", "a")
writeLines(code.to.process, txt.file)
close(txt.file)

#TASK 2
library(jsonlite)
song.file = str_split(str_sub("The Front Bottoms-Talon Of The Hawk-Au Revoir (Adios).json", 
                              start = 1, end = -6), "-")
song.data = fromJSON("The Front Bottoms-Talon Of The Hawk-Au Revoir (Adios).json")
average.loudness = song.data$lowlevel$average_loudness
spectral.energy.mean = song.data$lowlevel$spectral_energy$mean
danceability = song.data$rhythm$danceability
bpm = song.data$rhythm$bpm
key = song.data$tonal$key_key
key.scale = song.data$tonal$key_scale
song.length = song.data$metadata$audio_properties$length

