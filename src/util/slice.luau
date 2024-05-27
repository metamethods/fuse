local function slice<T>(items: {T}, a: number, b: number?): {T}
  local sliced = {}
  local start = b and a or 1
  local stop = b or a

  for i = start, stop do
    table.insert(sliced, items[i])
  end

  return sliced
end

return slice