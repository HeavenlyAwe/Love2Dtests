love.filesystem.load("world/Map.lua")()


local map = Map:new()


function love.load()
  print("love.load")
  
  map:load();
end


function love.keypressed(key)
  if key == "up" then
    map:zoomIn()
  elseif key == "down" then
    map:zoomOut()
  end
end


function love.mousepressed(x, y, button)
  print(x, y, button)
  
  oldMouseX = x
  oldMouseY = y
end


function love.update(dt)
  speed = 0.2 * 64 * dt
  
  local dx = 0
  local dy = 0
  
  if love.keyboard.isDown("a") then
    dx = -speed
  end
  if love.keyboard.isDown("d") then
    dx = speed
  end
  
  if love.keyboard.isDown("w") then
    dy = -speed
  end
  if love.keyboard.isDown("s") then
    dy = speed
  end
  
  
  if love.mouse.isDown("l") then
  
    print("Mouse Left down");
  
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    
    dx = (oldMouseX - mouseX) * dt
    dy = (oldMouseY - mouseY) * dt
    
    oldMouseX = mouseX
    oldMouseY = mouseY
    
  end
  
  
  map:move(dx, dy)
end



function love.draw()  
  map:draw();
end