local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local module_wrapper = require"main.helpers".module_wrapper

-- Modules
local systray = require("statusbar.modules.systray")
local launcher = require("statusbar.modules.launcher")
local clock = require("statusbar.modules.clock")
local battery = require("statusbar.modules.battery")
local memory = require("statusbar.modules.memory")
local cpu = require("statusbar.modules.cpu")
local netspeed = require("statusbar.modules.netspeed")
local volume = require("statusbar.modules.volume")
local temp = require("statusbar.modules.temp")
local taglist = require("statusbar.modules.taglist")
local playerctl = require("statusbar.modules.playerctl")
local todo = require("statusbar.modules.todo")

local set_wallpaper = function(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a taglist widget
  s.taglist = taglist.widget(s)

  -- Create the wibox
  s.wibox = awful.wibar({
    position = "top",
    screen = s,
    height = theme.statusbar_height,
    width = s.geometry.width
  })

  -- Add widgets to the wibox
  s.wibox:setup{
    layout = wibox.layout.align.horizontal,
    expand = "none",
    {
      module_wrapper({
        type = "module",
        widget = launcher.widget,
        left = dpi(5),
        right = dpi(5),
        top = dpi(0),
        bottom = dpi(0)
      }),
      s.taglist,

      module_wrapper({ type = "icon", widget = playerctl.icon }),

      module_wrapper({
        type = "module",
        widget = playerctl.widget,
        left = dpi(0),
        right = dpi(12),
        top = dpi(0),
        bottom = dpi(0)
      }),

      layout = wibox.layout.fixed.horizontal
    },
    {
      module_wrapper({ type = "module", widget = clock.widget }),

      layout = wibox.layout.fixed.horizontal
    },
    {
      module_wrapper({ type = "icon", widget = netspeed.wifi_icon }),
      module_wrapper({ type = "icon", widget = netspeed.down_icon }),
      module_wrapper({ type = "module", widget = netspeed.down }),
      module_wrapper({ type = "icon", widget = netspeed.up_icon }),
      module_wrapper({ type = "module", widget = netspeed.up }),

      module_wrapper({ type = "icon", widget = volume.icon }),
      module_wrapper({ type = "module", widget = volume.widget }),

      module_wrapper({ type = "icon", widget = temp.icon }),
      module_wrapper({ type = "module", widget = temp.widget }),

      module_wrapper({ type = "icon", widget = cpu.icon }),
      module_wrapper({ type = "module", widget = cpu.widget }),

      module_wrapper({ type = "icon", widget = memory.icon }),
      module_wrapper({ type = "module", widget = memory.widget }),

      module_wrapper({ type = "icon", widget = battery.icon }),
      module_wrapper({
        type = "module",
        widget = battery.widget,
        top = 0,
        bottom = 0,
        right = 0,
      }),

      module_wrapper({
        type = "module",
        widget = todo,
        left = 5,
        right = 5,
        top = 8,
        bottom = 8,
      }),

      module_wrapper({
        type = "module",
        widget = systray.widget,
        left = 0,
        right = 2,
        top = 4,
        bottom = 4,
      }),
      layout = wibox.layout.fixed.horizontal
    }
  }
end)
