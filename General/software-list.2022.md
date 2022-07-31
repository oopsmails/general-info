
# Software List

## Audio Edit

audacity-linux-3.1.3-x86_64.AppImage

audacity-win-3.1.3-64bit.zip


## Video Edit

sudo apt install kdenlive

#### if only cut video ..

- ref

https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg

```
ffmpeg -ss 00:06:48 -to 00:06:57  -i tmp00.mp4 -c copy tmp01.mp4

ffmpeg -i movie.mp4 -ss 00:00:03 -t 00:00:08 -async 1 cut.mp4

```
