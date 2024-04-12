local Studio = settings():GetService("Studio")

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local source = vide.source

local studioTheme = source(Studio.Theme.Name)

Studio.ThemeChanged:Connect(function()
  studioTheme(Studio.Theme.Name)
end)

local theme: {[Color]: { Dark: string, Light: string }} = {
  Background = {
    Dark = "#11111b",
    Light = "#eff1f5"
  },
  BackgroundSecondary = {
    Dark = "#181825",
    Light = "#e6e9ef"
  },
  BackgroundTertiary = {
    Dark = "#1e1e2e",
    Light = "#dce0e8"
  },
  
  Text = {
    Dark = "#cdd6f4",
    Light = "#4c4f69"
  },
  TextSwap = {
    Dark = "#4c4f69",
    Light = "#cdd6f4"
  },
  SubText = {
    Dark = "#a6adc8",
    Light = "#5c5f77"
  },
  SubTextSecondary = {
    Dark = "#bac2de",
    Light = "#5c5f77"
  },

  Overlay = {
    Dark = "#6c7086",
    Light = "#9ca0b0"
  },

  Border = {
    Dark = "#585b70",
    Light = "#acb0be"
  },

  Primary = {
    Dark = "#cba6f7",
    Light = "#7287fd"
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
  "Text" | "TextSwap" | "SubText" | "SubTextSecondary" |
  "Overlay" |
  "Border" |
  "Primary" |
  "Lavender" | "Blue" | "Green" | "Red"

local function Theme(color: Color): () -> Color3
  return function()
    return Color3.fromHex(theme[color][studioTheme()])
  end
end

return Theme