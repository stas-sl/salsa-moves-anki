ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a mp3 -b:a 128k "/Users/stas/Downloads/moves/1/1.mov"
ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a mp3 -b:a 128k "/Users/stas/Downloads/moves/1/1.mp4"

ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx -crf 25 -c:a libvorbis -b:a 128k "/Users/stas/Downloads/moves/1/1.webm"

ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx -crf 25 -c:a libvorbis -b:a 128k "/Users/stas/Downloads/moves/1/1.webm"

for file in moves/raw/*; do ffmpeg -y -i "$file" -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a aac -b:a 128k "moves/processed/$(basename "${file%.*}.mp4")"; done