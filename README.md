# Bad Apple ASCII

A simple Windows batch script that plays **Bad Apple!!** as ASCII art directly inside the CMD, while playing the original audio in sync.

The video is converted to grayscale frames using **FFmpeg**, then each frame is rendered in real time using ASCII characters in the terminal.

## Features

* 🎬 Plays `bad_apple.mp4` as ASCII art
* 🎵 Plays `bad_apple.mp3` simultaneously
* 🖥️ Automatically configures the Command Prompt window size
* 🔒 Disables window resizing during playback
* 👻 Hides the console cursor for a cleaner animation
* 🖤 Converts the video to grayscale ASCII characters in real time
* 📁 Automatically runs from the directory containing the `.bat` file

## Requirements

You need:

* **FFmpeg** (to download it, click here: https://ffmpeg.org/download.html )
* **FFplay** (included with most FFmpeg distributions)

Make sure `ffmpeg` and `ffplay` are available from the command line.

You can check this by running:

```cmd
ffmpeg -version
ffplay -version
```

## Installation

1. Clone or download this repository.

2. Place the following files in the same directory:

```text
.
├── bad_apple.bat
├── bad_apple.mp4
└── bad_apple.mp3
```

3. Make sure FFmpeg is installed and added to your system `PATH`.

## Usage

Simply run:

```cmd
bad_apple.bat
```

The script will:

1. Resize the Command Prompt window to the required dimensions.
2. Disable window resizing.
3. Hide the console cursor.
4. Start playing the audio.
5. Convert the video into grayscale frames.
6. Render each frame using ASCII characters.
7. Restore the cursor when playback ends.

## How It Works

The video is processed using FFmpeg:

```cmd
ffmpeg -i "bad_apple.mp4" -vf "fps=30,scale=100:40,format=gray" -f rawvideo -pix_fmt gray -
```

Each pixel's grayscale value is mapped to an ASCII character.

The characters used are:

```text
@%#*+=-:.
```

Dark and bright areas of the video are represented by different characters, creating the ASCII animation.

PowerShell reads the raw grayscale frames from FFmpeg and writes them directly to the console.

## Customization

You can change the ASCII resolution by modifying:

```bat
set "W=100"
set "H=40"
```

For example:

```bat
set "W=120"
set "H=45"
```

Keep in mind that increasing the resolution requires more processing power and may affect playback performance.

You can also change the frame rate by modifying the `fps` values in the script.

## Notes

* This script is designed specifically for **Windows Command Prompt**.
* Performance may vary depending on your system and terminal.
* The audio and video are started independently, so synchronization may vary slightly depending on system performance.

Enjoy the ASCII version of **Bad Apple!!** :)
