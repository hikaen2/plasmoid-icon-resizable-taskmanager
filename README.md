# Icon Resizable Task Manager

An ad-hoc workaround for the inability to resize task-manager icons on vertical panels.  
Details: https://discuss.kde.org/t/how-to-change-panel-icon-size-in-plasma-5-27-5/4117

## Releases

https://github.com/hikaen2/plasmoid-icon-resizable-taskmanager/releases

## KDE Store

- for Plasma 6.3:  https://store.kde.org/p/2293978
- for Plasma 5.27: https://store.kde.org/p/2078591

## Plasma 6.6

Plasma 6.6 turned the built-in applets into compiled QML modules and removed
`org.kde.plasma.private.taskmanager`. Its successor,
`plasma.applet.org.kde.plasma.taskmanager`, is embedded in
`plasma/applets/org.kde.plasma.taskmanager.so` and is not reachable from a
QML-only widget, which is why the widget stopped showing any tasks
(https://github.com/hikaen2/plasmoid-icon-resizable-taskmanager/issues/4).

The C++ `Backend` is replaced by a QML stub (`Backend.qml`) so the widget keeps
working without being compiled. The following features are unavailable as a
result:

- context menu: jump list actions, "Recent Files" and "Places"
- launcher badges (unread counts) and progress bars
- audio streams are matched by their own PID only, so applications that play
  sound from a child process do not get a mute button
- the tooltip loses its web-browser special case

Window highlighting, "Show windows side by side" and icon geometry publishing
are unaffected: those already go through D-Bus and QML in 6.6.
