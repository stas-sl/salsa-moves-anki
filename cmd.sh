ffmpeg -y -i /Users/stas/Downloads/moves4/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a mp3 -b:a 128k "/Users/stas/Downloads/moves4/1/1.mov"
ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a mp3 -b:a 128k "/Users/stas/Downloads/moves/1/1.mp4"

ffmpeg -y -i /Users/stas/Downloads/moves/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx -crf 25 -c:a libvorbis -b:a 128k "/Users/stas/Downloads/moves/1/1.webm"

ffmpeg -y -i /Users/stas/Downloads/moves4/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx-vp9 -crf 25 -b:v 0 -c:a libopus -b:a 128k "/Users/stas/Downloads/moves4/1/1.webm"

ffmpeg -y -i /Users/stas/Downloads/moves4/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx -crf 4 -b:v 2M -c:a libvorbis -b:a 128k "/Users/stas/Downloads/moves4/1/1.webm"


for file in moves/raw/*; do ffmpeg -y -i "$file" -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 -crf 25 -c:a aac -b:a 128k "moves/processed/$(basename "${file%.*}.mp4")"; done

libvpx-vp9 -crf 32
libx264 -crf 23
libx265 -crf 23
libaom-av1 -crf 30

ffmpeg -y -i raw/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx-vp9 -crf 41 -c:a aac -b:a 128k encoded/1_vp9_crf41_g0.mp4

ffmpeg -y -i raw/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libaom-av1 -crf 32 -b:v 0 -cpu-used 9 -threads 4 -c:a libopus -b:a 128k encoded/1_av1_crf32_g0.webm



ffmpeg -y -i raw/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx265 -g 15 -crf 28 -x265-params pass=1 -an -f null /dev/null

ffmpeg -y -i raw/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx265 -g 15 -crf 28 -x265-params pass=2 -tag:v hvc1 encoded/1_h265_crf0_g15_p2.mp4

ffmpeg -y -i raw/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx265 -g 15 -tag:v hvc1 -crf 28 -preset slow encoded/1_h265_crf28_g15.mp4

ffmpeg -y -i raw/1.mp4 -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx264 encoded/1_h264_crf0_g0.mp4


python -c "import os; [os.rename(f, f\"s{int(f.split('.')[0][:-1] if not f.split('.')[0][-1].isdigit() else f.split('.')[0]):03}{f.split('.')[0][-1] if not f.split('.')[0][-1].isdigit() else ''}.{f.split('.')[-1]}\") for f in os.listdir() if os.path.isfile(f) and len(f) < 10]"

python3 -c "import sys; import os; import json; print(json.dumps([{'name': f} for f in sorted(os.listdir(sys.argv[1]))], indent=2))" ~/Downloads/moves/encoded_x265 > ~/Projects/salsa-moves/static/files.json


for file in raw/*; do ffmpeg -y -i "$file"  -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libvpx-vp9 -crf 41 -b:v 0 -c:a libopus -b:a 128k -row-mt 1 "webm/$(basename "${file%.*}.webm")"; done

for file in raw/*; do ffmpeg -y -i "$file"  -vf "scale='if(gt(a,1),720,-2)':'if(gt(a,1),-2,720)'" -r 30 -c:v libx265 -g 15 -tag:v hvc1 -crf 25 -preset slow "encoded_x265_crf25_preset_slow/$(basename "${file%.*}.mp4")"; done
