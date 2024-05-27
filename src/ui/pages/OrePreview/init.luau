local RunService = game:GetService("RunService")

local vide = require(script.Parent.Parent.Parent.packages.vide)
local useOre = require(script.Parent.Parent.Parent.util.useOre)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)
local Fragment = require(script.Parent.Parent.components.Fragment)
local Page = require(script.Parent.Parent.components.Page)
local Round = require(script.Parent.Parent.components.Round)
local Text = require(script.Parent.Parent.components.Text)
local TextBox = require(script.Parent.Parent.components.TextBox)

export type OrePreviewProps = {
  ore: vide.Source<BasePart?>,
}

local function OrePreview(props: OrePreviewProps): Frame
  local currentRotation = vide.source(Vector3.new(0, 0, 0))
  local currentZoom = vide.source(20) -- TODO: Allow zooming
  local clonedOre = useOre(props.ore)

  local camera = Instance.new("Camera")

  local orePosition = function()
    local ore = clonedOre()
    if not ore then return CFrame.new() end
    return ore.CFrame
  end

  local cameraCFrame = function()
    local currentRotation = currentRotation()
    return orePosition() 
      * CFrame.Angles(
        math.rad(currentRotation.X),
        math.rad(currentRotation.Y),
        math.rad(currentRotation.Z)
      )
      * CFrame.new(0, 0, currentZoom())
  end

  vide.cleanup(RunService.RenderStepped:Connect(function(delta)
    currentRotation(currentRotation() + Vector3.new(.5, 1, .25) * delta * 50)
  end))

  vide.apply(camera) {
    CFrame = cameraCFrame
  }

  return Page {
    Fragment {
      direction = "Horizontal",
      padding = UDim.new(0, 8),
      layout = {
        Size = UDim2.fromScale(1, .5),
        AutomaticSize = Enum.AutomaticSize.None
      },
      children = {
        vide.create "ViewportFrame" {
          Name = "OrePreview",
          BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Light),
          Size = UDim2.new(.5, -4, 1, 0),
          CurrentCamera = camera,
          
          clonedOre,

          Round {}
        },

        TextBox {
          text = "Some really cool description or whatever",
          readonly = true,
          layout = {
            Size = UDim2.new(.5, -4, 1, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Light),
          }
        }
      }
    },

    Fragment {
      direction = "Horizontal",
      padding = UDim.new(0, 8),
      layout = {
        Size = UDim2.fromScale(1, .15),
        AutomaticSize = Enum.AutomaticSize.None
      },
      children = {
        Text {
          text = "Ore Creator: yes",
          layout = { BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Light), BackgroundTransparency = 0 }
        },
      }
    }
  }
end

return OrePreview