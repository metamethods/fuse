return {
  name = "Ore in a Cubic Shape",
  test = function(ore: BasePart)
    if ore.Size == Vector3.new(ore.Size.X, ore.Size.X, ore.Size.X) then
      return true, `The ore is in a cubic shape. <b>{ore.Size.X}x{ore.Size.X}x{ore.Size.X}</b>`
    else
      return false, `The ore is not in a cubic shape, current size: <b>{ore.Size.X}x{ore.Size.Y}x{ore.Size.Z}</b>`
    end
  end
}