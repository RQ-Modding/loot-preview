# Item Previews — agent notes

This file is optional. It is read only because this mod is installed. If this file is missing, or `item-previews` / `preview-close` are not in `rqmod-ctl ui`, the buttons are not there. Do not assume them, and do not look for them in the C dump. They are HUD rectangles this file registers with `rq.agent.control`.

## When the buttons exist

`item-previews` exists only while `rq.dungeon.exploring()` is true (map walk). It is cleared when a dialog, battle, config, or the join event hides the map. `preview-close` exists only while the preview grid is open. After the grid closes, `hover` / `press` on `preview-close` fail with `unknown-control`.

## Control ids

| id | label | role |
| --- | --- | --- |
| `item-previews` | Item Previews | toggles the chest grid for the current room |
| `preview-close` | Close | closes the grid |

Both are rects (`x`, `y`, `w`, `h`), not `T_Button` handles. `hover` / `press` click the rectangle.

## Layout

Screen size comes from `rq.hud.screen()`. The open button is 300×36, centered, `y = 8`. On a 1024×768 view that is `x = 362`. Close is 106×30 inside the panel, at the panel’s top right (`panel_x + panel_w - 118`, `panel_y + 8`). The panel is 580×430, centered, `y = 56`. Confirm `x` / `y` from the live `ui` row.

Opening the grid blocks game input until Close. Quest Storage is a different, vanilla button.
