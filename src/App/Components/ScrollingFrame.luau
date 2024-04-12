local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local create = vide.create

export type ScrollingFrameProps = vide.vScrollingFrame -- & (({Instance} | () -> {Instance})?)

local function ScrollingFrame(props: ScrollingFrameProps): ScrollingFrame
  return create "ScrollingFrame" {
    CanvasSize = UDim2.fromScale(0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.XY,

    BackgroundTransparency = 1,

    ScrollBarThickness = 0,

    ClipsDescendants = false,

    props
  }
end

return ScrollingFrame