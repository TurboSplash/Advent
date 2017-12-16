local passphrases = "input_day_4"

--part 1
local function line_to_table(line)
  local table = {}
  local i = 1
  for word in line:gmatch("%w+") do
    table[i] = word
    i = i + 1
  end
  return table
end

local function check_line (line)
  line = line_to_table(line)
  for i=1, #line do
    for j=i+1, #line do
      if line[i] == line[j] then
        return false
      end
    end
  end
  return true
end

local function validate_passphrases(path)
  local valid_no = 0
  local no_lines = 0
  for line in io.lines(path) do 
    if check_line(line) then
      valid_no = valid_no + 1
    end
  end
  return valid_no
end

print(validate_passphrases(passphrases))