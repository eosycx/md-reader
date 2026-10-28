property coreScript : ""

-- Raw event codes keep command-line osacompile builds reliable.
on run
    set coreScript to (POSIX path of («event earsffdr» me)) & "Contents/Resources/launch-core.sh"
    «event sysoexec» "bash " & quoted form of coreScript
end run

on open theFiles
    set coreScript to (POSIX path of («event earsffdr» me)) & "Contents/Resources/launch-core.sh"
    repeat with currentFile in theFiles
        «event sysoexec» "bash " & quoted form of coreScript & " " & quoted form of POSIX path of currentFile
    end repeat
end open
