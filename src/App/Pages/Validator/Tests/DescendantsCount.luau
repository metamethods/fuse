local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes

local DescribableObject = require(Classes.DescribableObject)

local ORE_DESCENDANTS_LIMIT = 1000
local ORE_RECOMMENDED_DESCENDANTS = 200

return DescribableObject.new()
  :setName("Ore Descendants Limit")
  :setDescription(`Checks if the ore is under the <b>{ORE_DESCENDANTS_LIMIT} descendant limit</b>. Very recommended to keep the ore <b>under {ORE_RECOMMENDED_DESCENDANTS} descendants</b> for transcendants/enigma ores.`)
  :setObject(function(ore: BasePart)
    local descendants = #ore:GetDescendants()
    if descendants > ORE_DESCENDANTS_LIMIT then return false, `Ore is currently <b>{descendants} descendants</b> over the <b>{ORE_DESCENDANTS_LIMIT} descendants</b> limit. Very recommended to reduce this number.` end
    if descendants <= 5 then return true, `I think the ore is under the <b>{ORE_DESCENDANTS_LIMIT} descendant</b> limit guys!11` end
    if descendants > ORE_RECOMMENDED_DESCENDANTS then return true, `Ore is currently <b>{descendants} descendants</b> over the <b>{ORE_RECOMMENDED_DESCENDANTS} recommended descendants</b> limit. Though this can still be a valid ore since its under {ORE_DESCENDANTS_LIMIT}, its not recommended for it being a transcendants/enigma ores.` end
    return true, `Ore is currently at <b>{descendants} descendants</b>, which is under the <b>{ORE_DESCENDANTS_LIMIT} descendants</b> limit.`
  end)