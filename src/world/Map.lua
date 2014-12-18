love.filesystem.load("world/Maze.lua")()


Map = {}

---
-- Gives a way to implement multiple objects from the same class
function Map:new(o)
  o = o or {} -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end


local map_tiles = {}

local mapWidth
local mapHeight

local mapX
local mapY

local tilesDisplayWidth
local tilesDisplayHeight
local zoomX
local zoomY

local tileQuads = {}
local tilesetImage
local tilesetBatch
local tileSize

function Map:load()
  print("Map.load")

  self:setup()
  self:setupView()
  self:setupTileset()

  print("================================================")
  print("Setup results:")
  print("------------------------------------------------")
  print("Map Width    = ", mapWidth)
  print("Map Height   = ", mapHeight)
  print("Tiles Width  = ", tilesDisplayWidth)
  print("Tiles Height = ", tilesDisplayHeight)
  print("Map X        = ", mapX)
  print("Map Y        = ", mapY)
  print("Tile Size    = ", tileSize)
  print("Zoom X       = ", zoomX)
  print("Zoom Y       = ", zoomY)
  print("================================================")
end


function Map:setup()
  print("Map.setup")

-- Leave the map dimension odd, to correctly generate the border around
  mapWidth = 29
  mapHeight = 29

  map_tiles = Maze:prim(mapWidth, mapHeight, 2, 2);
end


function Map:setupView()
  print("Map.setupView")

  mapX = 1
  mapY = 1

  tilesDisplayWidth = 26
  tilesDisplayHeight = 20

  if tilesDisplayWidth > mapWidth then
    tilesDisplayWidth = mapWidth
  end
  if tilesDisplayHeight > mapHeight then
    tilesDisplayHeight = mapHeight
  end


  zoomX = 1
  zoomY = 1
end


function Map:setupTileset()
  print("Map.setupTileset")

  tilesetImage = love.graphics.newImage("assets/tiles/tileset.png")
  tilesetImage:setFilter("nearest", "linear")

  tileSize = 32

  tileQuads[0] = love.graphics.newQuad(0 * tileSize, 20 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
  tileQuads[1] = love.graphics.newQuad(2 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
  tileQuads[2] = love.graphics.newQuad(4 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
  tileQuads[3] = love.graphics.newQuad(3 * tileSize, 9 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())

  tilesetBatch = love.graphics.newSpriteBatch(tilesetImage,
    tilesDisplayWidth * tilesDisplayHeight)

  self.updateTilesetBatch()
end


function Map:updateTilesetBatch()
  tilesetBatch:bind()
  tilesetBatch:clear()
  for y = 0, tilesDisplayHeight - 1 do
    for x = 0, tilesDisplayWidth - 1 do

      local indexX = x + math.floor(mapX)
      local indexY = y + math.floor(mapY)

      if indexX <= mapWidth and indexY <= mapHeight then
        local index = map_tiles[indexY][indexX]

        --      print("index: ", indexX, indexY, index)

        tilesetBatch:add(
          tileQuads[index],
          x * tileSize, y * tileSize)
      end
    end
  end
  tilesetBatch:unbind()
end


function Map:move(dx, dy)
  local oldMapX = mapX
  local oldMapY = mapY

  maxValueX = mapWidth - tilesDisplayWidth + 1;
--  print("maxValueX = ", maxValueX)

  mapX = math.max(math.min(mapX + dx, mapWidth - tilesDisplayWidth + 2), 1)
  mapY = math.max(math.min(mapY + dy, mapHeight - tilesDisplayHeight + 2), 1)

--  print("----------------")
--  print(mapX, mapY, (mapX + tilesDisplayWidth), (mapY + tilesDisplayHeight))
--  print(oldMapX, oldMapY)

  -- only update if we actually moved
  if math.floor(mapX) ~= math.floor(oldMapX)
    or math.floor(mapY) ~= math.floor(oldMapY)
  then
    self.updateTilesetBatch()
  end
end



function Map:zoomIn()
  if zoomX == 16 then
    return
  end
  zoomX = zoomX * 2
  zoomY = zoomX
end

function Map:zoomOut()
  if zoomX == 0.25 then
    return
  end
  zoomX = zoomX / 2
  zoomY = zoomX
end


function Map:draw()
  --  print(mapX, " - ", (mapX % 1))

  local x = math.floor(-zoomX * (mapX % 1) * tileSize)
  local y = math.floor(-zoomX * (mapY % 1) * tileSize)

  --  print("draw: ", x, y)

  love.graphics.draw(tilesetBatch, x, y, 0, zoomX, zoomY)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 20);
end
