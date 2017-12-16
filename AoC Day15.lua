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
local generator1 = coroutine.create(function (val, seed)
    for i=1, iterations_2 do
      if val % seed == 0 then 
        coroutine.yield(val % bits)
      end
      val = (val * gen_1_factor) % den
    end
  end)

local generator2 = coroutine.create(function (val, seed)
    for i=1, iterations_2 do
      if val % seed == 0 then 
        coroutine.yield(val % bits)
      end
      val = (val * gen_2_factor) % den
    end
  end)

local function judge()
  local acc = 0
  local t1, t2, val_1, val_2 = true, true, nil, nil
  while t1 or t2 do
    t1, val_1 = coroutine.resume(generator1, input_1, 4)
    t2, val_2 = coroutine.resume(generator2, input_2, 8)
    if val_1 == val_2 then
      acc = acc + 1
    end
  end
  return acc
end

--print(generators(input_1, input_2))
print(judge())