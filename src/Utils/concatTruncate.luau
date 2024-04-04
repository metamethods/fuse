return function<V>(tbl: {[number]: V}, delimiter: string, limit: number, fn: ((v: V) -> string)?): string 
  local strings = {}
  for i, v in tbl do
    table.insert(strings, fn and fn(v) or tostring(v))
    if i > limit then 
      table.insert(strings, `+{#tbl - limit} more...`)
      break
    end
  end
  return table.concat(strings, delimiter)
end