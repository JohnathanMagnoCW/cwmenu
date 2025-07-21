; CWMenu_Loader.ahk - Auto-updater for Menu Controller.ahk (AHK v2)

remoteUrl := "https://raw.githubusercontent.com/JohnathanMagnoCW/cwmenu/main/Menu%20Controller.ahk"
localFile := A_ScriptDir "\Menu Controller.ahk"
lastUpdatedFile := A_ScriptDir "\menu_last_updated.txt"

shouldDownload := true

if FileExist(localFile) && FileExist(lastUpdatedFile) {
    lastCheck := Trim(FileRead(lastUpdatedFile))
    now := FormatTime(, "yyyyMMddHHmmss")
    elapsed := Integer(now) - Integer(lastCheck)

    if elapsed <= 240000 {
        shouldDownload := false
    }
}

if shouldDownload {
    try {
        UrlDownloadToFile(remoteUrl, localFile)
        FileDelete lastUpdatedFile
        FileAppend FormatTime(, "yyyyMMddHHmmss"), lastUpdatedFile
    } catch {
        MsgBox "❌ Failed to download the latest Menu Controller. Running existing version..."
    }
}

Run localFile
ExitApp


; --- Helper function to download a file from URL ---
UrlDownloadToFile(url, filePath) {
    ; Create WinHttpRequest object
    http := ComObject("WinHttp.WinHttpRequest.5.1")
    http.Open("GET", url, false)
    http.Send()

    if (http.Status != 200)
        throw Error("HTTP error: " http.Status)

    stream := ComObject("ADODB.Stream")
    stream.Type := 1  ; Binary
    stream.Open()
    stream.Write(http.ResponseBody)
    stream.SaveToFile(filePath, 2)  ; 2 = Overwrite
    stream.Close()
}
