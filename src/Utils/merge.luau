return function(tbl1: {[any]: any}, tbl2: {[any]: any})
  local result = table.clone(tbl1)
  for k, v in tbl2 do
    result[k] = v
  end
  return result
end