# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

## 1.0.0

First version.

- Chest items are rolled when the chest is placed, and an Item Previews button on the dungeon map
  shows them in a grid.
- Item Previews and Close are registered as agent controls (`item-previews`, `preview-close`).
- An error when the patch cannot be placed points at `logs/rqmod.log`.
