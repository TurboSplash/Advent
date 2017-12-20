local passphrases = "input_day_4"

--https://adventofcode.com/2017/day/4

local function line_to_table(line)
  local table = {}
  local i = 1
  for word in line:gmatch("%w+") do
    table[i] = word
    i = i + 1
  end
  return table
end

local function get_table_length(table)
  length = 0
  for _ in pairs(table) do 
    length = length + 1
  end
  return length
end

local function sort_word(word)
  local length = #word
  repeat
    local swapped = false
    for i = 1, length - 1 do
      if word[i] > word [i+1] then
        word[i], word[i+1] = word[i+1], word[i]
        swapped = true
      end
    end
    length = length - 1
  until not swapped
  return word
end

local function is_anagram(line)
  for i = 1, #line do
    for j = i + 1, #line do
      local word_length_i = get_table_length(line[i])
      local word_length_j = get_table_length(line[j])
      if word_length_i == word_length_j then
        local equal = 0
        for k = 1, word_length_i do
          if line[i][k] == line[j][k] then
            equal = equal + 1
            if equal == word_length_i then
              return false
            end
          end
        end
      end
    end
  end
  return true
end

local function check_anagrams(line)
  line = line_to_table(line)
  for i = 1, #line do
    local word = {}
    for j = 1, #line[i] do
      local char = line[i]:sub(j, j)
      word[j] = string.byte(char)
    end
    line[i] = sort_word(word)
  end
  return is_anagram(line)
end

local function check_duplicates(line)
  line = line_to_table(line)
  for i = 1, #line do
    for j = i + 1, #line do
      if line[i] == line[j] then
        return false
      end
    end
  end
  return true
end

local function validate_passphrases(path)
  local valid_no = 0
  for line in io.lines(path) do 
    if check_duplicates(line) and check_anagrams(line) then
      valid_no = valid_no + 1
    end
  end
  return valid_no
end

print(validate_passphrases(passphrases))