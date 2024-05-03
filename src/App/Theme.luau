local Studio = settings():GetService("Studio")

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local source = vide.source

local studioTheme = source(Studio.Theme.Name)

Studio.ThemeChanged:Connect(function()
  studioTheme(Studio.Theme.Name)
end)

local theme: {[Color]: Enum.StudioStyleGuideColor | { Enum: Enum.StudioStyleGuideColor, Modifier: Enum.StudioStyleGuideModifier  } | { Dark: string, Light: string }} = {
  Background = Enum.StudioStyleGuideColor.MainBackground,
  BackgroundSecondary = Enum.StudioStyleGuideColor.InputFieldBackground,
  BackgroundTertiary = Enum.StudioStyleGuideColor.DialogButton,

  Text = Enum.StudioStyleGuideColor.MainText,
  SubText = Enum.StudioStyleGuideColor.DimmedText,
  SubTextSecondary = Enum.StudioStyleGuideColor.DimmedText,

  Overlay = {
    Dark = "#7a7a7a",
    Light = "#2a2a2a"
  },
  Border = Enum.StudioStyleGuideColor.Border,
  Primary = {
    Enum = Enum.StudioStyleGuideColor.Button,
    Modifier = Enum.StudioStyleGuideModifier.Selected 
  },

  Lavender = {
    Dark = "#b4befe",
    Light = "#7287fd"
  },
  Blue = {
    Dark = "#89b4fa",
    Light = "#1e66f5"
  },
  Green = {
    Dark = "#a6e3a1",
    Light = "#40a02b"
  },
  Red = {
    Dark = "#f38ba8",
    Light = "#d20f39"
  }
}

export type Color = 
  "Background" | "BackgroundSecondary" | "BackgroundTertiary" |
  "Text" | "SubText" | "SubTextSecondary" |
  "Overlay" |
  "Border" |
  "Primary" |
  "Lavender" | "Blue" | "Green" | "Red"

local function Theme(color: Color): () -> Color3
  return function()
    studioTheme() -- for the effect to run

    local themeColor = theme[color]

    if typeof(themeColor) == "EnumItem" then
      return Studio.Theme:GetColor(themeColor)
    else
      if themeColor.Enum and themeColor.Modifier then
        return Studio.Theme:GetColor(themeColor.Enum, themeColor.Modifier)
      else
        return Color3.fromHex(themeColor[studioTheme()])
      end
    end
  end
end

return Theme