local wezterm = require 'wezterm'
local act = wezterm.action
return {
  -- 窗口不透明度
  window_background_opacity = 0.8,
  -- 只有一个标签时隐藏标签栏
  hide_tab_bar_if_only_one_tab = true,
  always_new_process = true,
  enable_scroll_bar = true,
  font = wezterm.font_with_fallback {
    'JetBrains Mono',
    'Noto Sans CJK SC',
  },
  -- 颜色
  colors = {
    -- 标签栏
    tab_bar = {
      -- 标签栏背景色
      background = '#363636',

      -- 活动标签
      active_tab = {
        -- 标签背景颜色
        bg_color = '#202020',
        -- 标签文字颜色
        fg_color = '#f0f0f0',
      },

      -- 未活动标签
      inactive_tab = {
        -- 标签背景颜色
        bg_color = '#303030',
        -- 标签文字颜色
        fg_color = '#f0f0f0',
      },

      -- 未活动标签悬停
      inactive_tab_hover = {
        -- 标签背景颜色
        bg_color = '#202020',
        -- 标签文字颜色
        fg_color = '#f0f0f0',
      },

      -- 新建标签页按钮
      new_tab = {
        -- 背景颜色
        bg_color = '#363636',
        -- 文字颜色
        fg_color = '#f0f0f0',
      },

      -- 新建标签页按钮悬停
      new_tab_hover = {
        bg_color = '#202020',
        fg_color = '#f0f0f0',
        italic = true,
      },
    },
  },
  window_background_gradient = {
    -- 渐变方向，垂直或水平 "Vertical" or "Horizontal"
    orientation = 'Vertical',
    -- 渐变颜色
    colors = {
      '#121212',
    },
    -- 渐变方式，可选 "Linear", "Basis" and "CatmullRom"
    interpolation = 'Linear',
    blend = 'Rgb',
  },
  -- 快捷键
  keys = {
    -- 新建标签页
    { key = 'n', mods = 'CTRL', action = act.SpawnTab 'DefaultDomain' },
    -- 向右拆分
    {
      key = 'RightArrow',
      mods = 'CTRL',
      action = wezterm.action.SplitHorizontal {domain = 'DefaultDomain'},
    },
    -- 向下拆分
    {
      key = 'DownArrow',
      mods = 'CTRL',
      action = wezterm.action.SplitVertical {domain = 'DefaultDomain'},
    },
  },
  -- 自定义鼠标滚轮灵敏度
  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = 'NONE',
      action = act.ScrollByLine(-3),
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = 'NONE',
      action = act.ScrollByLine(3),
    },
  }
}
