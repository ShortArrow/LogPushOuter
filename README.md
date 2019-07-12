
# LogPushOuter

This is Auto Pusher of LogFile in MultiFolders.

## Description

Sometimes, there is software that does not erase log files. It was born to solve it. This script automatically deletes log files. Register with the Windows task scheduler or CRON to run periodically.

## Demo

none

## VS

none

## Requirement

Powershell 6 or Later

## Usage

### Setting

#### Location

add `settings.json` to same directory with `main.ps1`.

#### Content

Example about Windows

```json
{
    "path": [
        "%userprofile%/Desktop/log/log1",
        "%userprofile%/Desktop/log/log2",
        "%userprofile%/Desktop/log/log3",
        "%userprofile%/Desktop/log/log4",
        "%userprofile%/Desktop/log/log5",
        "%userprofile%/Desktop/log/log6",
        "%userprofile%/Desktop/log/log7",
        "%userprofile%/Desktop/log/log8",
        "%userprofile%/Desktop/log/log9"
    ],
    "QueueSize": 7,
    "LogCount": 7,
    "LogFolder": "C:/LogPushOuter"
}
```

Delete all files, leaving only the latest "" QueueSize "" in the folder specified by "path".

Keep delete log for "LogCount" days in "LogFolder".

If the specified path does not exist, it will be ignored.

## Install

After `git clone` or `download zip`,
Make it run regularly using [CRON](https://qiita.com/tossh/items/e135bd063a50087c3d6a) or [Task Scheduler](https://docs.microsoft.com/ja-jp/windows/win32/taskschd/task-scheduler-start-page). For security reasons, function restrictions will be applied if you do not have administrator privileges.
Note : [How to Remote](https://help.github.com/en/articles/which-remote-url-should-i-use)

## Licence

[GNU General Public License v3.0](https://github.com/ShortArrow/LogPushOuter/blob/master/LICENSE)

## Author

[ShortArrow](https://github.com/ShortArrow)
