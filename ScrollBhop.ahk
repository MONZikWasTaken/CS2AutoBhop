scrolling := false

WheelUp::
WheelDown::
    Send, {F5}             ; Сразу нажимаем F5 при скролле
    scrolling := true
    SetTimer, ScrollStopped, -500  ; Таймер 500 мс после последнего скролла
return

ScrollStopped:
    if (scrolling) {
        Send, {F6}         ; Нажимаем F6 после паузы
        scrolling := false
    }
return
