/*
    SPDX-FileCopyrightText: 2026 hikaen2

    SPDX-License-Identifier: GPL-2.0-or-later
*/

/*
 * Pure-QML stand-in for the C++ TaskManagerApplet.Backend.
 *
 * Plasma 6.6 turned the Task Manager applet into a compiled QML module and
 * dropped org.kde.plasma.private.taskmanager, so a QML-only widget can no
 * longer reach Backend. Everything that can be done from QML is done here;
 * the rest degrades to a no-op:
 *
 *   - jumpListActions/placesActions/recentDocumentActions return nothing, so
 *     the context menu has no jump list, no "Recent Files" and no "Places"
 *   - parentPid() cannot walk /proc, so audio streams are matched by their
 *     own PID only (apps that play sound from a child process lose the
 *     mute button)
 *   - applicationCategories() cannot read the .desktop file, so the tooltip
 *     does not get the web-browser special case
 */

import QtQuick

QtObject {
    // Mirrors Backend::MiddleClickAction; the values are stored in the config
    // file, so the order must not change.
    enum MiddleClickAction {
        None,
        Close,
        NewInstance,
        ToggleMinimized,
        ToggleGrouping,
        BringToCurrentDesktop
    }

    signal addLauncher(url url)
    signal showAllPlaces

    function globalRect(item: Item): rect {
        if (!item) {
            return Qt.rect(0, 0, 0, 0);
        }
        const topLeft = item.mapToGlobal(0, 0);
        return Qt.rect(topLeft.x, topLeft.y, item.width, item.height);
    }

    function isApplication(url: url): bool {
        const path = String(url);
        return path.startsWith("file://") && path.endsWith(".desktop");
    }

    // The real Backend resolves applications:foo.desktop via KService. Without
    // it the caller still gets a usable URL, just not a local file one.
    function tryDecodeApplicationsUrl(launcherUrl: url): url {
        return launcherUrl;
    }

    function applicationCategories(launcherUrl: url): var {
        return [];
    }

    function parentPid(pid: int): int {
        return -1;
    }

    function jumpListActions(launcherUrl: url, parent: QtObject): var {
        return [];
    }

    function placesActions(launcherUrl: url, showAllPlaces: bool, parent: QtObject): var {
        return [];
    }

    function recentDocumentActions(launcherUrl: url, parent: QtObject): var {
        return [];
    }

    function setActionGroup(action: var): void {
    }
}
