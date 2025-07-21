#Requires AutoHotkey v2.0
#SingleInstance Force

^+q:: {
    try {
        ClipSaved := ClipboardAll() ; Save clipboard
        A_Clipboard := ""
        Send("^c")
        ClipWait(1)
        selection := Trim(A_Clipboard)
        A_Clipboard := ClipSaved
    } catch {
        selection := "" ; If copy fails, fall back to blank
    }

    ; Create popup menu
    MyMenu := Menu()
    MyMenu.Add("Open in Core", (*) => Run("https://core.callbox.com/go/account.cfm?lid=" . selection))
    MyMenu.Add("Search in Core", (*) => Run("https://core.callbox.com/go/account_dash_f.cfm?search=" . selection))
    MyMenu.Add("Tracking Line DNIS Search", (*) => Run("https://core.callbox.com/admin/phone_search.cfm?lednis=" . selection))
    MyMenu.Add("XXML Shares", (*) => Run("https://core.callbox.com/admin/managefeeds.cfm?lid=" . selection))
    MyMenu.Add("Open Ticket in Zendesk", (*) => Run("https://callboxsupport.zendesk.com/agent/tickets/" . selection))
    MyMenu.Add("Test Menu", (*) => Run("https://callboxsupport.zendesk.com/agent/tickets/" . selection))

    MouseGetPos(&x, &y)
    MyMenu.Show(x, y)
}

/*
This is still being worked on - you'll see updates popping up periodically
If anything seems off or there's a feature you would like to see, let me know
jmagno@carwars.com
Rep available at
/*