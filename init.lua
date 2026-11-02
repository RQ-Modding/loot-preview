-- B+C loot-lock stays in the engine. This file owns the HUD:
-- top-middle "Item Previews" button + Quest Storage-like grid.

rq.log("Lua Item Previews HUD (lock-roll stays in the engine)")

if not rq.loot.install() then
  error("loot-preview: rq.loot.install failed (see logs/rqmod.log)")
end

local open = false
local last_logged_n = -1
local COLS = 5
local ROWS = 3
local ICON = 96
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

local function wrap_lines(s, max_px, size)
  s = tostring(s or "")
  if s == "" then
    return {}
  end
  if rq.hud.wrap then
    return rq.hud.wrap(s, max_px, size)
  end
  local out = {}
  s = s:gsub("\r\n", "\n"):gsub("\r", "\n")
  for para in (s .. "\n"):gmatch("(.-)\n") do
    while #para > 40 do
      out[#out + 1] = para:sub(1, 40)
      para = para:sub(41)
    end
    if para ~= "" then
      out[#out + 1] = para
    end
  end
  return out
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

  local pw, ph = 580, 430
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
  local hover = nil
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
    local hot = rq.hud.hit(ix, iy, ICON, ICON)
    rq.hud.rect(ix, iy, ICON, ICON, 10, 10, 16, 230)
    if hot then
      frame(ix, iy, ICON, ICON, 255, 220, 120, 255)
    else
      frame(ix, iy, ICON, ICON, 80, 70, 50, 255)
    end
    if it.cg and it.cg > 0 then
      rq.hud.cg(ix + 2, iy + 2, it.cg)
    end
    if it.source == "magnum" then
      label(ix + 4, iy + ICON - 18, "Magnum", 12, { r = 255, g = 220, b = 80 })
    end
    if hot then
      hover = it
    end
  end

  local tx = px + 12
  local ty = py + ph - 104
  local tw = pw - 24
  local th = 92
  -- 3px frame + 10px label pad + 1px shadow; pixel wrap vs this inner width
  local inner = tw - 32
  rq.hud.rect(tx, ty, tw, th, 8, 8, 14, 235)
  frame(tx, ty, tw, th, 160, 140, 90, 255)
  if hover then
    local title = hover.name or "Unidentified item"
    if hover.source == "magnum" then
      title = title .. "  (Magnum)"
    end
    local titles = wrap_lines(title, inner, 16)
    label(tx + 10, ty + 8, titles[1] or title, 16, { r = 255, g = 240, b = 200 })
    local body = hover.comment or ""
    if not hover.seen then
      body = "You have not identified this item yet."
    end
    local lines = wrap_lines(body, inner, 14)
    local ly = ty + 30
    for i = 1, math.min(3, #lines) do
      label(tx + 10, ly, lines[i], 14, { r = 210, g = 210, b = 220 })
      ly = ly + 18
    end
  else
    label(tx + 10, ty + 34, "Hover an item for name and details.", 16)
  end
end)
