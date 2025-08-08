; --- Чтение конфига ---
IniRead, JumpKey, config.ini, Settings, JumpKey, Space
ScrollDelay := 1  ; Жестко задана задержка в 1мс

fpsOn := false

#MaxThreadsPerHotkey 2

; --- Отслеживаем нажатие и отпускание клавиши JumpKey ---
Hotkey, %JumpKey%, JumpKey_Press, On
Hotkey, %JumpKey% Up, JumpKey_Release, On

; --- Колесо мыши больше не используется ---
WheelUp::
WheelDown::
    Return

; --- Обработчики клавиши из конфига ---
JumpKey_Press:
    if (!fpsOn)
    {
        Send, {F5}       ; fps_max 64 при нажатии
        fpsOn := true
    }
    SetTimer, AutoBhop_Timer, %ScrollDelay%
Return

JumpKey_Release:
    if (fpsOn)
    {
        Send, {F6}       ; fps_max 0 при отпускании
        fpsOn := false
    }
    SetTimer, AutoBhop_Timer, Off
Return

; --- Автобхоп таймер ---
AutoBhop_Timer:
    if GetKeyState(JumpKey, "P")
        Send, {Space}
Return
