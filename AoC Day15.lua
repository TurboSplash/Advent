local input_1 = 591
local input_2 = 393

local gen_1_factor = 16807
local gen_2_factor = 48271

local den = 2147483647
local iterations = 40000000
local iterations_2 = 5000000
local bits = math.pow(2, 16)

--part 1
local function generators(val_1, val_2)
  local acc = 0
  for i=1, iterations do
    if val_1 % bits == val_2 % bits then
      acc = acc + 1
    end
    val_1 = (val_1 * gen_1_factor) % den
    val_2 = (val_2 * gen_2_factor) % den
  end
  return acc
end

--part 2
local generator1 = coroutine.create(function (val)
    while 1 do
      val = (val * gen_1_factor) % den
      if val % 4 == 0 then 
        coroutine.yield(val % bits)
      end
    end
  end)

local generator2 = coroutine.create(function (val)
    while 1 do
      val = (val * gen_2_factor) % den
      if val % 8 == 0 then 
        coroutine.yield(val % bits)
      end
    end
  end)

local function judge()
  local acc = 0
  for i=1, iterations_2 do
    _, val_1 = coroutine.resume(generator1, input_1)
    _, val_2 = coroutine.resume(generator2, input_2)
    if val_1 == val_2 then
      acc = acc + 1
    end
  end
  return acc
end

--print(generators(input_1, input_2))
print(judge())