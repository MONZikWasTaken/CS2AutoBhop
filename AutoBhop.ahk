; --- Чтение конфига ---
IniRead, JumpKey, config.ini, Settings, JumpKey, CapsLock
IniRead, ScrollDirection, config.ini, Settings, ScrollDirection, Down
IniRead, ScrollDelay, config.ini, Settings, ScrollDelay, 30
ScrollDelay := ScrollDelay + 0  ; конвертация в число

scrolling := false
fpsOn := false

#MaxThreadsPerHotkey 2

; --- Отслеживаем нажатие и отпускание клавиши JumpKey ---

; В AHK 1.1 динамический биндинг с отдельными обработчиками
Hotkey, %JumpKey%, JumpKey_Press, On
Hotkey, %JumpKey% Up, JumpKey_Release, On

; --- Колесо мыши — для автобхопа ---
WheelUp::
WheelDown::
    ; Просто прокрутка, без fps тут
    Return

; --- Обработчики клавиши из конфига ---

JumpKey_Press:
    if (!fpsOn)
    {
        Send, {F5}       ; fps_max 64 при нажатии
        fpsOn := true
    }
    SetTimer, AutoBhop_Timer, 10
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
    {
        if (ScrollDirection = "Down")
            Send, {WheelDown}
        else
            Send, {WheelUp}
        Sleep, ScrollDelay
    }
Return
