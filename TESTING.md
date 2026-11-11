# Testing Loot Preview

For people and agents who test the mod in the game. Read it before you use anything the mod adds. If this file is missing, or `loot-preview.previews` is not in `rqmod-ctl ui`, the tab is not there. Do not assume it, and do not look for it in the C dump.

## When the controls exist

The tab `loot-preview.previews` is one of the game's own buttons on a quest's map panel (`rq.gamebutton` group `"map"`, loader 2.32.0). It exists while the panel does: on a quest's map, from the area's start. It hides with the panel (a dialog, a fight, a menu) and comes back with it. It is listed with a `button` handle while the map takes input, so `press` and `hover` work on it as on the panel's own buttons. Over the Quest Storage screen the game keeps the panel drawn, and the tab shows above that window, but it is not listed there and a click does nothing. In the map's key mode (Space), Left from AREA DISPLAY reaches it.

The window's controls exist only while the window is open. After it closes, `hover` / `press` on them fail with `unknown-control`.

## Control ids

| id | label | role |
| --- | --- | --- |
| `loot-preview.previews` | Item Previews | the tab on the map panel's left edge: opens the window |
| `page-loot` | Item Previews | the window (type `page`) |
| `button-close-loot` | Close | closes the window |
| `item-loot-<n>` | the item's name ("Unidentified item" when not seen) | the nth item's tile, a kit widget (type `item`, its ii as `value` when seen) |
| `button-loot-prev`, `button-loot-next` | `<`, `>` | the pages, only with more than 20 items |

After 500 ms of `hover` on a tile its card shows, listed as type `card` (it takes no click). Hover on the tab shows its tip in the game's comment window, left of the tab.

## Layout

The tab is 40×44 at x 768, y 129 (the first tab; a mod's next tab is 47 lower), on the 3D view's right edge under the area map. Confirm from the live `ui` row.

The window is the game's Quest Storage window at its own place, x 473. With up to 15 items it has three rows of tiles (y 165, 360 high); with more, four rows (y 141, 466 high), and pages of 20 after that. The tiles are 100×100, 106 apart, five to a row, from the window's x + 9, y + 39. Close is at the window's top right (x + 512, y + 6).

While the window is open the game takes no mouse and no keys. A right click or Esc closes it. Quest Storage is a different, vanilla button.
