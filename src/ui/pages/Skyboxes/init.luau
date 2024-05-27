local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local vide = require(script.Parent.Parent.Parent.packages.vide)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)
local Fragment = require(script.Parent.Parent.components.Fragment)
local Round = require(script.Parent.Parent.components.Round)
local ScrollingPage = require(script.Parent.Parent.components.ScrollingPage)
local Section = require(script.Parent.Parent.components.Section)

type SkyboxProps = {
  skybox: Sky
}

local function Skybox(props: SkyboxProps): ImageButton
  local hovering = vide.source(false)
  local pressed = vide.source(false)
  local cameraRotation = 0

  local fakeSkybox = script.FakeSkybox:Clone()
  local viewportCamera = Instance.new("Camera")

  fakeSkybox.Up.Texture = props.skybox.SkyboxUp
  fakeSkybox.Down.Texture = props.skybox.SkyboxDn
  fakeSkybox.Front.Texture = props.skybox.SkyboxFt
  fakeSkybox.Left.Texture = props.skybox.SkyboxLf
  fakeSkybox.Right.Texture = props.skybox.SkyboxRt
  fakeSkybox.Back.Texture = props.skybox.SkyboxBk
  fakeSkybox.Position = Vector3.zero

  viewportCamera.FieldOfView = 90
  viewportCamera.CFrame = CFrame.new()

  vide.cleanup(RunService.RenderStepped:Connect(function(delta)
    cameraRotation += delta * 50
    viewportCamera.CFrame = CFrame.Angles(0, -math.rad(cameraRotation), 0)
  end))

  local overlayTransparency = function()
    if pressed() then return 0.25 end
    return hovering() and .5 or 1
  end

  return vide.create "TextButton" {
    Name = props.skybox.Name,
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(200, 200),

    MouseEnter = function()
      hovering(true)
    end,

    MouseLeave = function()
      hovering(false)
      pressed(false)
    end,

    MouseButton1Down = function()
      pressed(true)
    end,

    MouseButton1Up = function()
      pressed(false)
    end,

    Activated = function()
      local currentSkybox = Lighting:FindFirstChildOfClass("Sky")
      if currentSkybox then currentSkybox:Destroy() end
      props.skybox:Clone().Parent = Lighting
    end,

    vide.create "ViewportFrame" {
      Name = "Skybox",
      BackgroundTransparency = 1,
      Size = UDim2.fromScale(1, 1),

      LightColor = Color3.new(),
      Ambient = Color3.new(1, 1, 1),
      CurrentCamera = viewportCamera,

      fakeSkybox,

      Round {}
    },

    vide.create "Frame" {
      Name = "Overlay",
      BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Button, "Hover"),
      BackgroundTransparency = vide.spring(overlayTransparency, 0.125),
      Size = UDim2.fromScale(1, 1),

      Round {}
    },

    vide.create "UISizeConstraint" {
      MinSize = Vector2.new(0, 200),
    },

    Round {}
  }
end

export type SkyboxesProps = {}

local function Skyboxes(props: SkyboxesProps): ScrollingFrame
  return ScrollingPage {
    Section {
      headerText = "Skyboxes",
      text = "Click on one of the templates below, and watch the skybox change!",
    },

    Fragment {
      direction = "Horizontal",
      padding = UDim.new(0, 8),
      listLayout = {
        Wraps = true,
        HorizontalFlex = Enum.UIFlexAlignment.Fill,
        VerticalFlex = Enum.UIFlexAlignment.Fill,
      },
      children = vide.indexes(vide.source(script.skyboxes:GetChildren()), function(skybox: vide.Source<Sky>)
        return Skybox {
          skybox = skybox()
        }
      end)
    }
  }
end

return Skyboxes