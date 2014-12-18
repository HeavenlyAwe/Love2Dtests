Maze = {}

local map_tiles

local START = 1
local GOAL = 3
local WALL = 2
local FLOOR = 0


function Maze:prim(w, h, startX, startY)

  -- set all tiles to nothing from the beginning
  map_tiles = {}
  for y = 1, h do
    map_tiles[y] = {}
    for x = 1, w do
      map_tiles[y][x] = WALL
    end
  end
  
  map_tiles[startY][startX] = START
    
  frontier = {}
  
  Maze:add_frontier_from_coord(startX, startY, w, h)
     
  lastTile = {}
  while #frontier ~= 0 do
    cu = Maze:get_frontier()
            
    local compX = cu[1] - cu[3][1]
    local compY = cu[2] - cu[3][2]
    if compX ~= 0 then
      op = {cu[1] + compX, cu[2]}
    elseif compY ~= 0 then
      op = {cu[1], cu[2] + compY}
    else
      op = nil
    end

--    print("f   = ", cu[1], cu[2])
--    print("op  = ", op[1], op[2])
    
    if op[2] <= h then
      if map_tiles[cu[2]][cu[1]] == WALL 
        and map_tiles[op[2]][op[1]] == WALL 
      then
        map_tiles[cu[2]][cu[1]] = FLOOR
        map_tiles[op[2]][op[1]] = FLOOR
        
        lastTile = op
        
        Maze:add_frontier_from_coord(op[1],op[2],w,h)
      end   
    end
    
    if #frontier == 0 then
      print("last tile = ", lastTile[1], lastTile[2])
      map_tiles[lastTile[2]][lastTile[1]] = 3
    end
    
      
--    LabyrinthGenerator:check_opposite(cu[1], cu[2], op[1], op[2], w, h)
        
  end

  return map_tiles
end


function Maze:add_frontier_from_coord(x, y, w, h)
  if y > 2 then
    Maze:add_frontier(x, y - 1, {x, y})
  end
  if y < (h - 1) then
    Maze:add_frontier(x, y + 1, {x, y})
  end
  if x < (w - 1) then
    Maze:add_frontier(x + 1, y, {x, y})
  end
  if x > 2 then
    Maze:add_frontier(x - 1, y, {x, y})
  end
end

function Maze:add_frontier(x, y, parent)
  if map_tiles[y][x] == WALL then
    table.insert(frontier, {x, y, parent})
  end
end


---
-- Gets a random frontier element from the list.
-- If the list is empty it'll return null
function Maze:get_frontier()
  index = math.random(1, #frontier)
  return table.remove(frontier, index)
end
