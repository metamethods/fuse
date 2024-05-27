local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)
local Button = require(script.Parent.Parent.components.Button)
local Fragment = require(script.Parent.Parent.components.Fragment)
local HeaderText = require(script.Parent.Parent.components.HeaderText)
local Padding = require(script.Parent.Parent.components.Padding)
local Round = require(script.Parent.Parent.components.Round)
local ScrollingPage = require(script.Parent.Parent.components.ScrollingPage)
local Section = require(script.Parent.Parent.components.Section)
local SelectedOre = require(script.Parent.Parent.components.SelectedOre)
local Text = require(script.Parent.Parent.components.Text)

export type OreValidatorProps = {
  ore: vide.Source<BasePart?>
}

export type TestProps = types.TestDefinition & {
  ore: vide.Source<BasePart?>,
  testResult: vide.Source<types.TestResult?>,
  onRunTestClicked: (ore: BasePart) -> types.TestResult,
}

local function Test(props: TestProps): Frame
  local overlayColor = function()
    local result = props.testResult()

    if result then
      if result.type == "ok" then
        return Color3.new(.4, .7, .4)
      elseif result.type == "fail" then
        return useTheme(Enum.StudioStyleGuideColor.ErrorText)()
      elseif result.type == "warn" then
        return useTheme(Enum.StudioStyleGuideColor.WarningText)()
      end
    end

    return useTheme(Enum.StudioStyleGuideColor.Light)()
  end

  return Fragment {
    padding = UDim.new(0, 8),
    children = {
      vide.create "Frame" {
        Name = "Test",
        Size = UDim2.fromScale(1, 0),
        BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Light),
        AutomaticSize = Enum.AutomaticSize.Y,
    
        Fragment {
          padding = UDim.new(0, 8),
          children = {
            Fragment {
              children = {
                HeaderText { text = props.title },
                Text {
                  text = props.description,
                  layout = {
                    Font = Enum.Font.GothamMedium,
                  }
                },
              }
            },

            Text {
              text = function()
                local result = props.testResult()
                return result and result.message or "<i>This test hasn't been ran yet!</i>"
              end
            },
    
            Padding {}
          }
        },
    
        vide.create "Frame" {
          Name = "Overlay",
          Size = UDim2.fromScale(1, 1),
          BackgroundColor3 = vide.spring(overlayColor, .1),
          BackgroundTransparency = .75,
    
          ZIndex = 0,
    
          Round {}
        },
     
        Round {}
      },

      Fragment {
        direction = "Horizontal",
        padding = UDim.new(0, 8),
        children = {
          Button {
            text = "Run Test",
            disabled = function()
              return not props.ore()
            end,
            onClick = function()
              local ore = props.ore()
              if ore then
                props.onRunTestClicked(ore)
              end
            end,
          },

          Button {
            text = "Clear Test",
            disabled = function()
              return not props.testResult()
            end,
            onClick = function()
              props.testResult(nil)
            end
          }
        }
      }
    }
  }
end

local function OreValidator(props: OreValidatorProps): ScrollingFrame
  local tests: {{
    testResult: vide.Source<types.TestResult?>,
    runTest: () -> types.TestResult
  }} = {}

  local runTestsButtonDisabled = function()
    return props.ore() == nil
  end

  local runTests = function()
    for _, test in tests do
      test.runTest()
    end
  end

  local clearTests = function()
    for _, test in tests do
      test.testResult(nil)
    end
  end

  return ScrollingPage {
    Section {
      headerText = "Ore Validator",
      text = "Welcome to the Ore Validator! This is pretty self explanatory, just press the \"Run Tests\" button below, and you are good to go!"
    },

    SelectedOre {
      ore = props.ore
    },

    Fragment {
      direction = "Horizontal",
      padding = UDim.new(0, 8),
      children = {
        Button {
          text = "Run Tests",
          disabled = runTestsButtonDisabled,
          onClick = runTests
        },

        Button {
          text = "Clear Tests",
          onClick = clearTests
        }
      }
    },

    vide.indexes(vide.source(script.tests:GetChildren()), function(module: vide.Source<ModuleScript>)
      local testResult = vide.source(nil)
      local testDefinition: types.TestDefinition = require(module())

      local runTest = function()
        local ore = props.ore()
        if not ore then return end
        local result = testDefinition.fn(ore)
        testResult(result)
        return result
      end

      table.insert(tests, {
        testResult = testResult,
        runTest = runTest
      })

      return Test {
        title = testDefinition.title,
        description = testDefinition.description,
        fn = testDefinition.fn,
        ore = props.ore,
        testResult = testResult,
        onRunTestClicked = runTest
      }
    end)
  }
end

return OreValidator