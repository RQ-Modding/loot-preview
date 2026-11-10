-- B+C loot-lock stays in the engine. This file owns the HUD:
-- top-middle "Item Previews" button + a grid of the game's item tiles, each with the game's item
-- card as its tip (rq.uikit.item_icon, loader 2.21.0).

rq.log("Lua Item Previews HUD (lock-roll stays in the engine)")

if not rq.loot.install() then
  error("loot-preview: rq.loot.install failed (see logs/rqmod.log)")
end

local open = false
local last_logged_n = -1
local COLS = 5
local ROWS = 3
local ICON = 100 -- the game's item tile
local GAP = 8

local function exploring()
  if rq.dungeon.exploring then
    return rq.dungeon.exploring()
  end
  return rq.dungeon.active()
end

local function agent_rect(id, x, y, w, h, label)
  if not (rq.agent and rq.agent.control) then
    return
  end
  rq.agent.control(id, { label = label, x = x, y = y, w = w, h = h })
end

local function agent_clear(id)
  if not (rq.agent and rq.agent.control) then
    return
  end
  rq.agent.control(id)
end

local function frame(x, y, w, h, r, g, b, a)
  a = a or 255
  rq.hud.rect(x, y, w, 3, r, g, b, a)
  rq.hud.rect(x, y + h - 3, w, 3, r, g, b, a)
  rq.hud.rect(x, y, 3, h, r, g, b, a)
  rq.hud.rect(x + w - 3, y, 3, h, r, g, b, a)
end

local function label(x, y, str, size, col)
  size = size or 18
  col = col or { r = 245, g = 245, b = 255 }
  rq.hud.text(x + 1, y + 1, str, { size = size, r = 0, g = 0, b = 0 })
  rq.hud.text(x, y, str, { size = size, r = col.r, g = col.g, b = col.b })
end

local function button(x, y, w, h, text)
  local hot = rq.hud.hit(x, y, w, h)
  if hot then
    rq.hud.rect(x, y, w, h, 90, 70, 40, 240)
  else
    rq.hud.rect(x, y, w, h, 36, 28, 18, 235)
  end
  frame(x, y, w, h, 220, 200, 140, 255)
  label(x + 12, y + math.floor((h - 18) / 2), text, 18)
  return rq.hud.clicked(x, y, w, h)
end

rq.on_frame(function()
  if not exploring() then
    open = false
    last_logged_n = -1
    agent_clear("item-previews")
    agent_clear("preview-close")
    return
  end

  local sw, sh = rq.hud.screen()
  local bw, bh = 300, 36
  local bx = math.floor((sw - bw) / 2)
  local by = 8
  agent_rect("item-previews", bx, by, bw, bh, "Item Previews")
  if button(bx, by, bw, bh, "Item Previews") then
    open = not open
  end
  if not open then
    agent_clear("preview-close")
    return
  end

  rq.hud.block_game_input()
  rq.hud.rect(0, 0, sw, sh, 0, 0, 0, 150)

  local pw, ph = 580, 420
  local px = math.floor((sw - pw) / 2)
  local py = 56
  rq.hud.rect(px, py, pw, ph, 18, 16, 28, 240)
  frame(px, py, pw, ph, 210, 190, 120, 255)
  rq.hud.rect(px + 3, py + 3, pw - 6, 40, 48, 36, 22, 255)
  label(px + 16, py + 12, "Item Previews", 20, { r = 255, g = 230, b = 160 })
  agent_rect("preview-close", px + pw - 118, py + 8, 106, 30, "Close")
  if button(px + pw - 118, py + 8, 106, 30, "Close") then
    open = false
    agent_clear("preview-close")
    return
  end

  local items = rq.loot.list()
  local n = #items
  if n ~= last_logged_n then
    rq.log("Detected " .. n .. " items")
    last_logged_n = n
  end
  local ox = px + 24
  local oy = py + 56
  if n == 0 then
    label(ox, oy, "No locked chests or Magnum prize yet.", 16)
    return
  end
  for i, it in ipairs(items) do
    local col = (i - 1) % COLS
    local row = math.floor((i - 1) / COLS)
    if row >= ROWS then
      break
    end
    local ix = ox + col * (ICON + GAP)
    local iy = oy + row * (ICON + GAP)
    rq.hud.rect(ix, iy, ICON, ICON, 10, 10, 16, 230)
    -- An item not seen yet: the game's "?" icon and its UNIDENTIFIED card, never the real one.
    local item = it.seen and it.id or { icon = it.cg, rank = 0, name = "Unidentified item" }
    rq.uikit.item_icon(item, { x = ix, y = iy, id = "loot-" .. i, judged = it.seen })
    if it.source == "magnum" then
      -- Top left: the rank badge sits at the bottom left.
      label(ix + 4, iy + 3, "Magnum", 12, { r = 255, g = 220, b = 80 })
    end
  end
  label(px + 16, py + ph - 30, "Hover an item to see its card.", 15, { r = 200, g = 200, b = 210 })
end)
