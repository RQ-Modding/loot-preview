# Loot Preview

Shows what the chests of the dungeon room hold before you open them.

## What it changes

- Each chest's item is decided when the chest is placed, not when you open it, so it can be shown in
  advance. Red chests keep the game's chance and still explode on a fail, which loses the item.
- On a quest's map, an **Item Previews** tab with a pouch sits on the right edge of the 3D view,
  against the panel, under the area map. It opens the game's Quest Storage window holding the items
  waiting in the room's chests, and the Magnum's when it holds one. The tab is one of the game's own
  buttons: it hides with the panel, and in the map's key mode (Space) the arrow keys reach it (Left
  from AREA DISPLAY).
- The items are the game's own tiles. Hover one for the game's item card, as on the status page. An
  item you have not identified yet shows the game's UNIDENTIFIED card, with no name or stats.
- The window closes by its close button, a right click or Esc. While it is open, the game
  does not take input.

## Keys and settings

None.

## Saves

Nothing beyond the items you take from chests.

## Works with

Chest Safe Luck, which changes the red chest's chance. Binoculars, which adds an item to the rare
chest pool.

## Install

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **2.32.0** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/loot-preview/mod.json`.

## License

MIT, see [LICENSE](LICENSE).
