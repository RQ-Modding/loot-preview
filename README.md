# Loot Preview

Shows what the chests of the dungeon room hold before you open them.

## Showcase

### Loot Preview Icon

<img width="512" height="257" alt="image" src="https://github.com/user-attachments/assets/940a36a3-192e-4971-8c31-574787ad585a" />

### Showing Magnum Item

<img width="763" height="501" alt="image" src="https://github.com/user-attachments/assets/01598d50-7ab1-4cb9-a3d9-c802b9680127" />

### Showing Item Stats

<img width="1165" height="480" alt="image" src="https://github.com/user-attachments/assets/dcef8575-9957-45f6-aa9a-4c464e4242a7" />

### Showing Upcoming Items form Chests

<img width="850" height="462" alt="image" src="https://github.com/user-attachments/assets/13dc0beb-d1bb-4ed3-9b3a-048a27eda68d" />

There are 2 chests in this room.

### Showing Upcoming Item Stats

<img width="1018" height="443" alt="image" src="https://github.com/user-attachments/assets/00691706-8c98-4cb4-86f8-4e73c569f834" />

I already have *a version* of this item, but I do not have this variation of it, that's why I can see it's an armor but not which.

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
