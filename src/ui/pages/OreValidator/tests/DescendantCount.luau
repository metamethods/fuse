local Test = require(script.Parent.Parent.Test)

local MAX_DESCENDANT_COUNT = 1_000

return Test.define("Descendant Count", `Checks if the ore's amount of descendants is less than {MAX_DESCENDANT_COUNT}`, function(ore)
  local descendants = #ore:GetDescendants()

  if descendants > MAX_DESCENDANT_COUNT then
    return Test.fail(`The ore has a total of <b>{#ore:GetDescendants()} descendants</b>, which is more than <b>{MAX_DESCENDANT_COUNT} descendants</b>`)
  elseif descendants > MAX_DESCENDANT_COUNT / 2 then
    return Test.warn(`The ore has a total of <b>{#ore:GetDescendants()} descendants</b>. You should consider <b>reducing the amount of descendants</b>`)
  else
    return Test.ok(`The ore has a total of <b>{#ore:GetDescendants()} descendants</b>`)
  end
end)