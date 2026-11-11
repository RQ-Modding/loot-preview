-- B+C loot-lock stays in the engine. This file owns the HUD: a tab on the map panel's edge (the
-- game's own button, rq.gamebutton group "map", loader 2.32.0) that opens the game's Quest Storage
-- window with the room's items as the game's tiles (rq.uikit.item_window), each with the game's
-- item card as its tip.

rq.log("Lua Item Previews HUD (lock-roll stays in the engine)")

if not rq.loot.install() then
  error("loot-preview: rq.loot.install failed (see logs/rqmod.log)")
end

local open = false
local last_logged_n = -1

local function exploring()
  if rq.dungeon.exploring then
    return rq.dungeon.exploring()
  end
  return rq.dungeon.active()
end

-- The tab's icon: the pouch of the Quest Storage's ITEM icon (CG 11329, 100x100), without its word.
local POUCH = rq.image.compose("loot-preview:pouch", { { cg = 11329, src = { 18, 0, 64, 54 } } },
  { w = 64, h = 54 })

rq.gamebutton.add({
  group = "map",
  id = "previews",
  label = "Item Previews",
  icon = POUCH,
  tip = "What the chests of this room hold,\nand the Magnum's prize.",
  on_click = function() open = true end,
})

local function mark(x, y, str)
  rq.hud.text(x + 1, y + 1, str, { size = 12, r = 0, g = 0, b = 0 })
  rq.hud.text(x, y, str, { size = 12, r = 255, g = 220, b = 80 })
end

rq.on_frame(function()
  if not exploring() then
    open = false
    last_logged_n = -1
    return
  end
  if not open then return end

  local items = rq.loot.list()
  local n = #items
  if n ~= last_logged_n then
    rq.log("Detected " .. n .. " items")
    last_logged_n = n
  end
  -- An item not seen yet: the game's "?" icon and its UNIDENTIFIED card, never the real one.
  local list = {}
  for i, it in ipairs(items) do
    list[i] = {
      item = it.seen and it.id or { icon = it.cg, rank = 0, name = "Unidentified item" },
      judged = it.seen,
      magnum = it.source == "magnum",
    }
  end
  open = rq.uikit.item_window(list, {
    id = "loot",
    title = "Item Previews",
    empty = "No locked chests or Magnum prize yet.",
    -- Top left: the rank badge sits at the bottom left.
    cell = function(_, x, y, e)
      if e.magnum then mark(x + 4, y + 3, "Magnum") end
    end,
  })
end)
