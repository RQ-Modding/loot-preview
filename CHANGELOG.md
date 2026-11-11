# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

## 1.2.0

- The Item Previews button at the top middle, over the encounter bar, is gone. A tab with the game's
  pouch now sits on the map panel's left edge, under the area map: one of the game's own buttons
  (`rq.gamebutton` group `"map"`), with the game's keys and comment window.
- The items show in the game's Quest Storage window (`rq.uikit.item_window`), at its own place. Past
  15 items it grows a fourth row, and pages after 20. A right click or Esc closes it.
- Agent ids: `loot-preview.previews` (the tab), `button-close-loot`, `item-loot-<n>`.
- Needs loader 2.32.0.

## 1.1.0

- The grid shows the game's item tiles (`rq.uikit.item_icon`, loader 2.21.0), and hovering one
  shows the game's item card, the UNIDENTIFIED card for an item not identified yet. The text box
  under the grid is gone.
- The "Magnum" mark is at the tile's top left, clear of the rank badge.
- Needs loader 2.21.0.

## 1.0.0

First version.

- Chest items are rolled when the chest is placed, and an Item Previews button on the dungeon map
  shows them in a grid.
- Item Previews and Close are registered as agent controls (`item-previews`, `preview-close`).
- An error when the patch cannot be placed points at `logs/rqmod.log`.
