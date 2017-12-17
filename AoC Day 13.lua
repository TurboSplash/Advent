local input = "input_day_13"

--https://adventofcode.com/2017/day/13

local layers = {}
local scanners = {}
for i=0, 100 do
  layers[i] = 0
  scanners[i] = 0
end

for line in io.lines(input) do
  local depth = tonumber(string.sub(line, string.find(line, "[0-99]+")))
  local range = tonumber(string.sub(line, string.find(line, "[: ][0-99]+")))
  layers[depth] = range
end

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

print(severity)