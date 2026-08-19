@echo off
setlocal
title Bad Apple ASCII
cd /d "%~dp0"

REM ASCII size of the video
set "W=100"
set "H=40"

REM Set CMD window size
mode con: cols=%W% lines=%H%

REM Disable window resizing
powershell -NoProfile -Command ^
"Add-Type -Name Win32 -Namespace Native -MemberDefinition '[DllImport(\"kernel32.dll\")] public static extern IntPtr GetConsoleWindow(); [DllImport(\"user32.dll\")] public static extern int GetWindowLong(IntPtr hWnd,int nIndex); [DllImport(\"user32.dll\")] public static extern int SetWindowLong(IntPtr hWnd,int nIndex,int dwNewLong);'; ^
$hwnd=[Native.Win32]::GetConsoleWindow(); ^
$style=[Native.Win32]::GetWindowLong($hwnd,-16); ^
$style=$style -band (-bnot 0x00040000); ^
$style=$style -band (-bnot 0x00010000); ^
[Native.Win32]::SetWindowLong($hwnd,-16,$style)"

REM Hide cursor
powershell -NoProfile -Command "[Console]::CursorVisible=$false; [Console]::Clear()"

REM Start audio
start "" /B ffplay -nodisp -autoexit -loglevel quiet "bad_apple.mp3"

REM ASCII video
ffmpeg -i "bad_apple.mp4" -vf "fps=30,scale=%W%:%H%,format=gray" -f rawvideo -pix_fmt gray - 2>nul | powershell -NoProfile -Command ^
"$w=%W%; $h=%H%; $fps=30; ^
$chars='@%%#*+=-:. '; ^
$buf=New-Object byte[] ($w*$h); ^
$stdin=[Console]::OpenStandardInput(); ^
$sw=[Diagnostics.Stopwatch]::StartNew(); ^
$frame=0; ^
while(($n=$stdin.Read($buf,0,$buf.Length)) -eq $buf.Length){ ^
    $target=$frame*(1000.0/$fps); ^
    $wait=$target-$sw.Elapsed.TotalMilliseconds; ^
    if($wait -gt 0){Start-Sleep -Milliseconds ([int]$wait)}; ^
    [Console]::SetCursorPosition(0,0); ^
    $out=New-Object System.Text.StringBuilder; ^
    for($y=0;$y -lt $h;$y++){ ^
        for($x=0;$x -lt $w;$x++){ ^
            $p=$buf[$y*$w+$x]; ^
            $i=[Math]::Min($chars.Length-1,[int]($p/256*$chars.Length)); ^
            [void]$out.Append($chars[$i]) ^
        }; ^
        if($y -lt ($h-1)){[void]$out.Append([Environment]::NewLine)} ^
    }; ^
    [Console]::Write($out.ToString()); ^
    $frame++ ^
}"

REM Restore cursor
powershell -NoProfile -Command "[Console]::CursorVisible=$true"

cls
echo By @Non-Lo-S0 :)
pause
