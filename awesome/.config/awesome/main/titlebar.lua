local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = require"beautiful.xresources".apply_dpi
local margin = wibox.container.margin

local M = {}

function M.get()
  local function create_title_button(c, color_focus, color_unfocus)
    local tb_color = wibox.widget {
      bg      = color_focus,
      widget  = wibox.container.background,
      shape   = gears.shape.circle
    }

    local tb = wibox.widget {
      tb_color,
      width    = dpi(12),
      height   = dpi(12),
      strategy = "min",
      layout   = wibox.container.constraint
    }

    local function update()
      if client.focus == c then
        tb_color.bg = color_focus
      else
        tb_color.bg = color_unfocus
      end
    end

    update()
    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    -- return margin(tb, dpi(2), dpi(2), dpi(4), dpi(4))
    return tb
  end

  -- Add a titlebar if titlebars_enabled is set to true in the rules.
  client.connect_signal("request::titlebars",
    function(c)
      -- buttons for the titlebar
      local buttons = gears.table.join(
        awful.button({ }, 1, function()
          client.focus = c
          c:raise()
          awful.mouse.client.move(c)
        end),

        awful.button({ }, 3, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
        end)
      )

      local close = create_title_button(c, theme.red, theme.black)
      close:connect_signal("button::press", function() c:kill() end)

      local floating = create_title_button(c, theme.yellow, theme.black)
      floating:connect_signal("button::press", function() c.floating = not c.floating end)

      local fullscreen = create_title_button(c, theme.green, theme.black)
      floating:connect_signal("button::press", function() c.floating = not c.floating end)

      local window_title = { -- client name
        align  = 'center',
        font   = 'Iosevka Curly Slab 10',
        widget = awful.titlebar.widget.titlewidget(c)
      }

      local icon = { -- client icon
        widget = awful.titlebar.widget.iconwidget(c)
      }

      -- awful.titlebar(c, { position = "left", size = beautiful.titlebar_size}):setup {
      --   { close, layout = wibox.layout.fixed.vertical }, -- top left
      --   { buttons = buttons, layout  = wibox.layout.flex.vertical }, -- middle left
      --   { floating, layout = wibox.layout.fixed.vertical }, -- bottom left
      --   layout = wibox.layout.align.vertical
      -- }

      -- awful.titlebar(c, {position = "right", size = beautiful.titlebar_size}):setup {
      --   { close, layout  = wibox.layout.fixed.vertical }, -- top right
      --   { buttons = buttons, layout  = wibox.layout.flex.vertical }, -- middle right
      --   { floating, layout = wibox.layout.fixed.vertical }, -- bottom right
      --   layout = wibox.layout.align.vertical
      -- }

      -- awful.titlebar(c, {position = "bottom", size = beautiful.titlebar_size}):setup {
      --   { floating, layout  = wibox.layout.fixed.horizontal }, -- bottom left
      --   { buttons = buttons, layout  = wibox.layout.flex.horizontal }, -- middle
      --   { floating, layout = wibox.layout.fixed.horizontal }, -- bottom right
      --   layout = wibox.layout.align.horizontal
      -- }

      awful.titlebar(c, {position = "top", size = dpi(22)}):setup {
        {
          margin(close, dpi(8)), floating, fullscreen, spacing = dpi(8),
          layout = wibox.layout.fixed.horizontal
        }, -- top right

        { window_title, buttons = buttons, layout  = wibox.layout.flex.horizontal }, -- middle
        { margin(icon, dpi(2), dpi(2), dpi(2), dpi(2)), layout = wibox.layout.fixed.horizontal }, -- top left
        -- { floating, close, layout = wibox.layout.fixed.horizontal }, -- top right
        spacing = dpi(8),
        layout = wibox.layout.align.horizontal
      }
    end
  )
end

return setmetatable({}, { __call = function(_, ...) return M.get(...) end })
