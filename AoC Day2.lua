local path = "input_day_2"

--day 2 part 1
local function find_checksum(path)
  local checksum  = 0
  for line in io.lines(path) do 
    local max = 0
    local min = nil
    for word in line:gmatch("%w+") do
      local number = tonumber(word)
      if not min then min = number
      elseif number < min then min = number
      elseif number > max then max = number end
    end
    checksum = checksum + (max - min)
  end
  return checksum
end

--day 2 part 2
local function find_evenly_divisible(string)
  for word in string:gmatch("%w+") do
    local num = tonumber(word)
    for word in string:gmatch("%w+") do
      local den = tonumber(word)
      if num ~= den and num > den and num % den == 0  then return num / den end
    end
  end
end

local function find_checksum_even(path)
  local checksum  = 0
  for line in io.lines(path) do 
    checksum = checksum + find_evenly_divisible(line)
  end
  return checksum
end

print("part 1: " .. find_checksum(path))
print("Part 2: " .. find_checksum_even(path))