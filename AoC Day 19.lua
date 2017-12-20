local input = "input_day_19"

local diagram = {}
local directions = {up = "up", down = "down", left = "left", right = "right", finish = "finish"}
local current_direction = directions.down
local pos = { x = 0, y = 0 }
local alphabet_soup = ""
local steps = 0

local function read_file()
  local i = 1
  for line in io.lines(input) do
    table.insert(diagram, i, {})
    local j = 1
    for char in string.gmatch(line, ".") do
      table.insert(diagram[i], j, char)
      j = j + 1
    end
    i = i + 1
  end
end

local function change_direction()
  if current_direction == directions.up or current_direction == directions.down then
    if diagram[pos.y][pos.x + 1] ~= " " then
      return directions.right
    elseif diagram[pos.y][pos.x - 1] ~= " " then
      return directions.left
    end
  elseif current_direction == directions.left or current_direction == directions.right then
    if diagram[pos.y + 1][pos.x] ~= " " then
      return directions.down
    end
    if diagram[pos.y - 1][pos.x] ~= " " then
      return directions.up
    end
  end
  return
end

local function check_chars()
  local current_char = diagram[pos.y][pos.x]
  if current_char == "+" then
    return true
  end
  if current_char:match("%a") then
    alphabet_soup = alphabet_soup .. current_char
  end
  return false
end

--a fucking hack
local function check_finish()
  local current_char = diagram[pos.y][pos.x]
  if current_char ~= "+" then
    if current_direction == directions.up and diagram[pos.y - 1][pos.x] == " " then
      return true
    elseif current_direction == directions.down and diagram[pos.y + 1][pos.x] == " " then
      return true
    elseif current_direction == directions.left and diagram[pos.y][pos.x - 1] == " " then
      return true
    elseif current_direction == directions.right and diagram[pos.y][pos.x + 1] == " " then
      return true
    end
  end
  return false
end

local function move()
  if current_direction == directions.up then
    pos.y = pos.y - 1
  elseif current_direction == directions.down then
    pos.y = pos.y + 1
  elseif current_direction == directions.left then
    pos.x = pos.x - 1
  elseif current_direction == directions.right then
    pos.x = pos.x + 1
  end
end

local function get_start_position()
  for i = 1, #diagram[1] do
    if diagram[1][i] ~= " " then
      return i, 1
    end
  end
end

local function route_packet()
  read_file()
  pos.x, pos.y = get_start_position()
  steps = steps + 1
  repeat
    local finish = false
    move()
    steps = steps + 1
    if check_chars() then
      current_direction = change_direction()
    end
  until check_finish()
end

route_packet()
print(alphabet_soup, steps)