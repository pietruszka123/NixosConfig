hl.window_rule({
  name = "windowrule-1",
  float = true,
  match = {
    title = "^(Console window for .+ Prism Launcher .+)$"
  }
})

hl.window_rule({
  name = "open files",
  float = true,
  match = {
    title = "^(Open Files)$",
    class = "^(org.gnome.Nautilus)$"
  }
})

hl.window_rule({
  name = "windowrule-2",
  fullscreen = true,
  match = {
    class = "^(Loading...)$" -- war thunder
  }
}
)

hl.window_rule({
  name = "windowrule-3",
  fullscreen = true,
  match = {
    title = "^(Wuthering Waves)$" -- Wuthering waves
  }
})


hl.window_rule({
  name = "windowrule-4",
  workspace = "special:special2 silent",
  -- silent = true,
  match = {
    class = "^(discord)$"
  }
})

hl.window_rule({
  name = "windowrule-5",
  workspace = "91 silent",
  -- silent = true,
  match = {
    title = "^(Steam)$"
  }
})

--windowrulev2 = immediate, class:^(steam_app_1017180)$
