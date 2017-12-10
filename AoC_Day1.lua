io.input("input_day_1")
local input = io.read("*all")


local function string_to_table(string)
  for i=1 , string:len() do
    table[i] = string:sub(i,i)
  end
  return table
end

--part1
local function solve_captcha(input)
  local sum = 0
  local table = string_to_table(input)
  if table[#table] == table[1] then sum = sum + table[1] end
  for i, digit in ipairs(table) do
    if table[i+1] and digit == table[i+1] then sum = sum + digit end
  end
  return sum
end

--part2
local function solve_captcha_2(input)
  local sum = 0 
  local table = string_to_table(input)
  for i, digit in ipairs(table) do
    local halfway_around_index = (i + #table / 2) % #table
    if digit == table[halfway_around_index] then
      sum = sum + digit
    end
  end
  return sum
end

print(solve_captcha(input))
print(solve_captcha_2(input))

  