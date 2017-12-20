local input = "input_day_13"

--https://adventofcode.com/2017/day/13

local layers = {}
local scanners = {}
local function reset_firewall()
  for i=0, 100 do
    layers[i] = 0
    scanners[i] = 0
  end
end

local function populate_firewall()
  for line in io.lines(input) do
    local depth = tonumber(string.sub(line, string.find(line, "[0-9]+")))
    local range = tonumber(string.sub(line, string.find(line, "[: ][0-9]+")))
    layers[depth] = range
  end
end

reset_firewall()
populate_firewall()
local wait = 0
repeat
  --increment all scanners
  for j = 0, #layers do
    if layers[j] ~= 0 then
      scanners[j] = (scanners[j] + 1) % (layers[j])
    end
  end
  --pass through firewall and check if caught
  local caught = false
  for i = 0, #layers do
    if scanners[i] == 1 then
      caught = true
      break
    end
  end
  wait = wait + 1
until not caught

reset_firewall()
populate_firewall()
local severity = 0
for i = 0, #layers do
  for j = 0, #layers do
    if layers[j] ~= 0 then
      scanners[j] = (scanners[j] + 1) % (layers[j] - 1)
    end
  end
  if scanners [i] == 1 then
    severity = severity + i * layers[i]
  end
end

--to do: make them scan pu and down and not reset ot the beginning

print(severity)
print(wait)

--101 - low