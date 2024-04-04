local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)
local Studio = settings():GetService("Studio")

local Value = Fusion.Value
local Computed = Fusion.Computed

local studioTheme = Value(Studio.Theme.Name)

Studio.ThemeChanged:Connect(function()
  studioTheme:set(Studio.Theme.Name)
end)

function lighter(color: Color3, factor: number): Color3
  local h, s, v = color:ToHSV()
  return Color3.fromHSV(h, s, v + factor)
end

export type Colors = 
  "Background" | "BackgroundUp" | "Text" | "Border" |
  "TabBar" | "Tab" | "RibbonTabTopBar" | 
  "ButtonBackground" | "ButtonText" | "ButtonBorder" |
  "Overlay" | "OverlayOpposite" |
  "Primary" | "Success" | "Error"

local Theme: {[Colors]: Enum.StudioStyleGuideColor | {Dark: Color3, Light: Color3} | Color3} = {
  Background = Enum.StudioStyleGuideColor.MainBackground,
  BackgroundUp = lighter(Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground), .0125),
  Text = Enum.StudioStyleGuideColor.MainText,
  Border = {
    Dark = Color3.fromRGB(83, 83, 83),
    Light = Color3.fromRGB(172, 172, 172)
  },

  TabBar = Enum.StudioStyleGuideColor.TabBar,
  Tab = Enum.StudioStyleGuideColor.Tab,
  RibbonTabTopBar = Enum.StudioStyleGuideColor.RibbonTabTopBar,

  ButtonBackground = Enum.StudioStyleGuideColor.Button,
  ButtonText = {
    Dark = Color3.new(.9, .9, .9),
    Light = Color3.fromRGB(57, 57, 57) 
  },
  ButtonBorder = {
    Dark = Color3.fromRGB(83, 83, 83),
    Light = Color3.fromRGB(172, 172, 172)
  },

  Overlay = {
    Dark = Color3.new(1, 1, 1),
    Light = Color3.new(0, 0, 0)
  },
  OverlayOpposite = {
    Dark = Color3.new(0, 0, 0),
    Light = Color3.new(1, 1, 1)
  },

  Primary = Color3.fromRGB(220, 90, 90),
  Success = Color3.fromRGB(136, 227, 161),
  Error = Color3.fromRGB(220, 90, 90)
}

return function(color: Colors): Fusion.Computed<Color3>
  return Computed(function()
    local colorTheme = Theme[color]
    local studioTheme = studioTheme:get()
    if typeof(colorTheme) == "EnumItem" then
      return Studio.Theme:GetColor(colorTheme)
    elseif typeof(colorTheme) == "Color3" then
      return colorTheme
    else
      return colorTheme[studioTheme]
    end
  end)
end