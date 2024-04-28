local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local ScrollingFrame = require(Components.ScrollingFrame)
local ParagraphText = require(Components.ParagraphText)
local ScrollingParagraphText = require(Components.ScrollingParagraphText)
local HeaderText = require(Components.HeaderText)
local List = require(Components.List)
local PrimaryButton = require(Components.PrimaryButton)
local Padding = require(Components.Padding)
local Button = require(Components.Button)
local Rounded = require(Components.Rounded)
local ListRow = require(Components.ListRow)
local Theme = require(Fuse.App.Theme)

local TestClass = require(script.Test)

local vide = require(Packages.vide)

local create = vide.create
local indexes = vide.indexes
local source = vide.source

export type HeaderProps = {
  ore: () -> BasePart?
}

local function Header(props: HeaderProps): Frame
  return List {
    Layout = {
      Size = UDim2.fromScale(1, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
    },
    ListLayout = {
      Padding = UDim.new(0, 8),
    },

    Children = {
      HeaderText { Text = "Ore Validator" },
      ScrollingParagraphText { Text = "Welcome to the ore validator! This is where you can run some tests on your ore to see if its valid for submission on REx: Reincarnated, and even can fix the issues with a simple button click below the test. If you are a ore curator, you can use this to check if people's submissions are valid." },
      HeaderText { Text = "Usage" },
      ScrollingParagraphText { Text = "To use the ore validator, you'll need to select an ore topmost BasePart (e.g. Part, MeshPart, etc...), and then click the \"Validate Ore\" button!", Layout = { AutomaticSize = Enum.AutomaticSize.Y }},
      ParagraphText {
        Text = function()
          local oreInstance = props.ore()
          return `Currently selected ore: <b>{oreInstance and oreInstance:GetFullName() or "None"}</b>`
        end
      }
    }
  }
end

export type TestProps = {
  test: TestClass.Test,
  ore: () -> BasePart?
}

type TestResult = {
  success: boolean,
  message: string
}

local function Test(props: TestProps): (Frame, (ore: BasePart) -> ())
  local testResult: (TestResult?) -> TestResult? = source(nil)

  local result: () -> TestResult = function()
    return testResult() or {}
  end

  local testMessage = function()
    return result().message or "<i>Test hasn't been ran yet</i>"
  end

  local backgroundColor = function()
    return result().success
      and Theme("Green")()
      or Theme("Red")()
  end

  local disabled = function()
    return not props.ore()
  end

  local function test(ore: BasePart)
    local success, message = props.test.testFn(ore)
    testResult({
      success = success,
      message = message
    })
  end

  return List {
    Layout = {
      Size = UDim2.fromScale(1, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
    },

    ListLayout = {
      Padding = UDim.new(0, 8),
    },
  
    Children = {
      create "Frame" {
        Name = "TestInformation",
        BackgroundColor3 = Theme "BackgroundSecondary",
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,

        Rounded {},
        
        List {
          Layout = {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 2
          },
          ListLayout = {
            Padding = UDim.new(0, 4),
          },
          Children = {
            Padding { UDim.new(0, 8) },
            HeaderText { Text = props.test.name },
            ParagraphText { Text = props.test.description },
            ParagraphText { Text = testMessage },
          }
        },
        create "Frame" {
          Name = "Background",
          BackgroundColor3 = backgroundColor,
          BackgroundTransparency = function()
            return testResult() == nil and 1 or .75
          end,
          Size = UDim2.fromScale(1, 1),

          ZIndex = 1,

          Rounded {}
        }
      },
      
      ListRow {
        Children = {
          Button {
            Text = "Run Test",
            Disabled = disabled,
            clicked = function()
              test(props.ore() :: BasePart)
            end
          },
          Button {
            Layout = {
              Visible = props.test.fixFn ~= nil
            },

            Text = "Fix",
            Disabled = disabled,
            clicked = function()
              if not props.test.fixFn then return end
              props.test.fixFn(props.ore() :: BasePart)
              test(props.ore() :: BasePart)
            end
          },
          Button {
            Text = "Reset",
            Disabled = function()
              return not testResult()
            end,
            clicked = function()
              testResult(nil)
            end
          }
        }
      }
    }
  }, test
end

export type Props = {
  ore: () -> BasePart?
}

local function Page(props: Props): ScrollingFrame
  local testFunctions: {(ore: BasePart) -> ()} = {}

  return ScrollingFrame {
    Size = UDim2.fromScale(1, 1),

    List {
      Layout = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
      },

      ListLayout = {
        Padding = UDim.new(0, 8),
      },

      Children = {
        Header {
          ore = props.ore
        },
        PrimaryButton {
          Text = "Validate Ore",
          Disabled = function()
            return not props.ore()
          end,
          clicked = function()
            for _, test in testFunctions do
              test(props.ore())
            end
          end
        },
        indexes(source(script.Tests:GetChildren()), function(test: () -> ModuleScript, i)
          local component, testFunction = Test {
            test = require(test()),
            ore = props.ore
          }
          table.insert(testFunctions, testFunction)
          return component
        end)
      }
    }
  }
end

return Page