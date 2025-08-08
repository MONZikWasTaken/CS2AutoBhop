; --- Чтение конфига ---
IniRead, JumpKey, config.ini, Settings, JumpKey, CapsLock
IniRead, ScrollDirection, config.ini, Settings, ScrollDirection, Down
IniRead, ScrollDelay, config.ini, Settings, ScrollDelay, 30
ScrollDelay := ScrollDelay + 0  ; конвертация в число

scrolling := false
fpsOn := false
manualScroll := false

#MaxThreadsPerHotkey 2

; --- Прокрутка мыши игроком ---
WheelDown::
WheelUp::
{
    ; Устанавливаем флаг, что пользователь вручную крутил колесо
    manualScroll := true

    ; Симулируем нажатие "JumpKey"
    GoSub, JumpKey_Press
    SetTimer, ResetManualScroll, -150  ; Сбросить флаг через 150мс
    Return
}

ResetManualScroll:
    GoSub, JumpKey_Release
    manualScroll := false
Return

; --- Динамические бинды клавиши прыжка ---
Hotkey, %JumpKey%, JumpKey_Press, On
Hotkey, %JumpKey% Up, JumpKey_Release, On

JumpKey_Press:
    if (!fpsOn)
    {
        Send, {F5}       ; fps_max 64
        fpsOn := true
    }

    ; Если это не ручное колесо, запускаем таймер
    if (!manualScroll)
        SetTimer, AutoBhop_Timer, 10
Return

JumpKey_Release:
    if (fpsOn)
    {
        Send, {F6}       ; fps_max 0
        fpsOn := false
    }

    SetTimer, AutoBhop_Timer, Off
Return

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
