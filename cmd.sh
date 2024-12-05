ffmpeg -y -i /Users/stas/Downloads/moves4/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a mp3 -b:a 128k "/Users/stas/Downloads/moves4/1/1.mov"
ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a mp3 -b:a 128k "/Users/stas/Downloads/moves/1/1.mp4"

ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx -crf 25 -c:a libvorbis -b:a 128k "/Users/stas/Downloads/moves/1/1.webm"

ffmpeg -y -i /Users/stas/Downloads/moves4/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx-vp9 -crf 25 -b:v 0 -c:a libopus -b:a 128k "/Users/stas/Downloads/moves4/1/1.webm"

ffmpeg -y -i /Users/stas/Downloads/moves4/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx -crf 4 -b:v 2M -c:a libvorbis -b:a 128k "/Users/stas/Downloads/moves4/1/1.webm"


for file in moves/raw/*; do ffmpeg -y -i "$file" -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a aac -b:a 128k "moves/processed/$(basename "${file%.*}.mp4")"; done


python -c "import os; [os.rename(f, f\"s{int(f.split('.')[0][:-1] if not f.split('.')[0][-1].isdigit() else f.split('.')[0]):03}{f.split('.')[0][-1] if not f.split('.')[0][-1].isdigit() else ''}.{f.split('.')[-1]}\") for f in os.listdir() if os.path.isfile(f)]"

for file in raw/*; do ffmpeg -y -i "$file"  -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx-vp9 -crf 41 -b:v 0 -c:a libopus -b:a 128k -row-mt 1 "webm/$(basename "${file%.*}.webm")"; done