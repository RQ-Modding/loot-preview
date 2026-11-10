# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

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
