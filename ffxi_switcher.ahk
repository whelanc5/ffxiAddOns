#SingleInstance Force
DetectHiddenWindows(false)
SetTitleMatchMode(2)

FFXI_Instances := []

SC029::   ; plain backtick (hardware scancode)
{
    FFXI_Instances := WinGetList("ahk_class FFXiClass")
    if (FFXI_Instances.Length < 2)
        return

    Active := WinGetID("A")
    NextWin := ""

    Loop FFXI_Instances.Length {
        if (FFXI_Instances[A_Index] = Active) {
            idx := (A_Index = FFXI_Instances.Length) ? 1 : A_Index + 1
            NextWin := FFXI_Instances[idx]
            break
        }
    }
    if (NextWin = "")
        NextWin := FFXI_Instances[1]

    ; Restore if minimized
    if (WinGetMinMax("ahk_id " . NextWin) = -1)
        WinRestore("ahk_id " . NextWin)

    ; --- TRUE ALT-TAB SWITCH, no freeze ---
    SendEvent "{Alt down}"
    WinActivateBottom("ahk_id " . NextWin)
    Sleep 20
    WinActivate("ahk_id " . NextWin)
    Sleep 50
    SendEvent "{Alt up}"

    Sleep 100
}
