# Unified Terminal Theme System — Design Spec

## Goal
Replace the existing hardcoded dark/light file-copy switcher with a flexible, Base16-based theme engine that:
1. Supports **any number of named themes** downloaded from the internet (not just dark/light)
2. Generates all tool configs from a **single source of truth** (a Base16 palette YAML)
3. Covers: alacritty, tmux, zsh/fzf, neovim, eza, oh-my-posh, Claude Code, and OpenCode
4. Provides a simple CLI: `theme set <name>` and `theme list`

---

## Architecture

```
~/dotfiles/
├── theme/
│   ├── themes/                 # Base16 scheme YAMLs (downloaded from internet)
│   │   ├── solarized-dark.yml
│   │   ├── solarized-light.yml
│   │   ├── gruvbox-dark.yml
│   │   └── tokyonight.yml
│   ├── templates/              # Jinja2 templates per tool
│   │   ├── alacritty.toml.j2
│   │   ├── tmux.conf.j2
│   │   ├── fzf.zsh.j2
│   │   ├── oh-my-posh.json.j2
│   │   └── eza.yml.j2
│   ├── generated/              # Output configs (gitignored)
│   │   ├── alacritty.toml
│   │   ├── tmux.conf
│   │   ├── fzf.zsh
│   │   ├── oh-my-posh.json
│   │   └── eza.yml
│   ├── theme.py                # Generator script + CLI
│   └── active_theme.txt        # Currently active theme name
```

---

## Base16 Palette Format

Each theme is a YAML file following the [Base16 spec](https://github.com/tinted-theming/home/blob/main/styling.md):

```yaml
system: "base16"
name: "Solarized Dark"
author: "Ethan Schoonover"
variant: "dark"       # or "light"
palette:
  base00: "002b36"    # Default Background
  base01: "073642"    # Lighter Background
  base02: "586e75"    # Selection Background
  base03: "657b83"    # Comments, Invisibles
  base04: "839496"    # Dark Foreground
  base05: "93a1a1"    # Default Foreground
  base06: "eee8d5"    # Light Foreground
  base07: "fdf6e3"    # Light Background
  base08: "dc322f"    # Red
  base09: "cb4b16"    # Orange
  base0A: "b58900"    # Yellow
  base0B: "859900"    # Green
  base0C: "2aa198"    # Cyan
  base0D: "268bd2"    # Blue
  base0E: "6c71c4"    # Purple
  base0F: "d33682"    # Magenta
```

**Where to get them:**
- Official repo: https://github.com/tinted-theming/schemes
- Each scheme is a YAML file — download and drop into `theme/themes/`

---

## Template Examples

### Alacritty (`alacritty.toml.j2`)
```jinja2
[colors.primary]
background = "#{{ base00 }}"
foreground = "#{{ base05 }}"

[colors.cursor]
text = "#{{ base00 }}"
cursor = "#{{ base05 }}"

[colors.normal]
black   = "#{{ base00 }}"
red     = "#{{ base08 }}"
green   = "#{{ base0B }}"
yellow  = "#{{ base0A }}"
blue    = "#{{ base0D }}"
magenta = "#{{ base0E }}"
cyan    = "#{{ base0C }}"
white   = "#{{ base05 }}"
```

### Tmux (`tmux.conf.j2`)
```jinja2
set-option -g status-style bg=#{{ base00 }},fg=#{{ base05 }}
set-window-option -g window-status-current-style bg=default,fg=#{{ base0B }}
set -g pane-border-style "fg=#{{ base03 }}"
set -g pane-active-border-style "fg=#{{ base0D }}"
set -g mode-style "fg=#{{ base00 }},bg=#{{ base05 }}"
set -g message-style "fg=#{{ base00 }},bg=#{{ base05 }}"
```

### FZF (`fzf.zsh.j2`)
```jinja2
export FZF_DEFAULT_OPTS="\
  --color=bg+:#{{ base01 }},bg:#{{ base00 }},spinner:#{{ base0C }},hl:#{{ base0D }} \
  --color=fg:#{{ base05 }},header:#{{ base0D }},info:#{{ base0C }},pointer:#{{ base0C }} \
   --color=marker:#{{ base0C }},prompt:#{{ base0C }},hl+:#{{ base0A }}"
```

### Eza (`eza.yml.j2`)
```jinja2
colour:
  filekinds:
    normal: {foreground: "#{{ base05 }}"}
    directory: {foreground: "#{{ base0D }}"}
    symlink: {foreground: "#{{ base0C }}"}
    executable: {foreground: "#{{ base0B }}"}
  # ... etc
```

### Oh-My-Posh (`oh-my-posh.json.j2`)
Uses base16 colors for segments. The template maps `base00`–`base0F` to palette positions.

---

## Tool-Specific Handling

| Tool | Generation Method | Reload Strategy |
|---|---|---|
| **Alacritty** | Generated TOML → `~/.config/alacritty/alacritty.toml` | Live reload (no restart) |
| **Tmux** | Generated conf → sourced via `tmux source-file` | `tmux source-file <path>` |
| **ZSH / FZF** | Generated shell snippet → sourced in `.zshrc` | New shells pick it up; current shell: `source` |
| **Eza** | Generated YAML → `~/.config/eza/theme.yml` | Live on next `eza` invocation |
| **Oh-My-Posh** | Generated JSON → `--config` path | New shells pick it up |
| **Neovim** | **Not generated.** Instead, set `vim.g.colors_name` in `theme.lua` based on a theme→colorscheme mapping | `:colorscheme <name>` or reload |
| **Claude Code** | JSON edit: `settings.json` `"theme": "dark"` or `"light"` | Restart or settings reload |
| **OpenCode** | JSON edit: `opencode.json` if it supports theme | Check support |

### Neovim Mapping
Instead of generating nvim colors (which is brittle), we maintain a mapping:

```python
NVIM_THEME_MAP = {
    "solarized-dark":  {"colorscheme": "solarized8", "background": "dark"},
    "solarized-light": {"colorscheme": "solarized8", "background": "light"},
    "gruvbox-dark":    {"colorscheme": "gruvbox",    "background": "dark"},
    "tokyonight":      {"colorscheme": "tokyonight", "background": "dark"},
    "nightfox":        {"colorscheme": "nightfox",   "background": "dark"},
}
```

The generator writes `~/dotfiles/nvim/lua/theme.lua`:
```lua
-- Auto-generated by theme.py — do not edit manually
vim.opt.background = "dark"
vim.cmd.colorscheme("nightfox")
```

---

## CLI: `theme.py`

```bash
# List available themes
theme list
# > solarized-dark
# > solarized-light
# > gruvbox-dark
# > tokyonight

# Activate a theme
theme set solarized-dark
# > Generated alacritty.toml
# > Generated tmux.conf
# > Generated fzf.zsh
# > Generated eza.yml
# > Generated oh-my-posh.json
# > Updated nvim theme.lua
# > Updated Claude Code settings
# > Sourced tmux config

# Show active theme
theme active
# > solarized-dark
```

---

## Light/Dark Variants

Base16 schemes often ship as pairs (e.g., `solarized-dark.yml`, `solarized-light.yml`). The `variant` field in the YAML distinguishes them. The CLI does not treat them specially — they are just two different themes you can `theme set`.

If a tool (like Claude Code) only supports `"dark"` / `"light"` strings, the generator reads `variant` from the YAML and maps accordingly.

---

## Integration with Existing Switcher

The `theme.py` script is invoked via its full path (or add `~/dotfiles/theme` to your `PATH`).

The current `~/switch_theme.sh` and nvim `theme-switcher.lua` will be **replaced** by calls to `theme.py`:

```lua
-- theme-switcher.lua (rewritten)
local utils = require("config.utils")

function SwitchTheme(mode)
  os.execute("python3 " .. os.getenv("HOME") .. "/dotfiles/theme/theme.py set " .. mode)
end

utils.lua_command("SetThemeDark", 'SwitchTheme("solarized-dark")')
utils.lua_command("SetThemeLight", 'SwitchTheme("solarized-light")')
```

Or better: map `<leader>tt` to a fuzzy picker of available themes.

---

## Migration Plan

1. **Create `theme/` directory** with `themes/`, `templates/`, `generated/`
2. **Install Jinja2**: `pip3 install Jinja2 PyYAML` (or use Homebrew python)
3. **Write `theme.py`** — CLI + generator
4. **Write templates** for alacritty, tmux, fzf, eza, oh-my-posh
5. **Add `theme/generated/` to `.gitignore`**
6. **Migrate existing configs** into templates using current dark/light colors as reference
6. **Download 3–4 Base16 schemes** to populate `themes/`
7. **Replace `switch_theme.sh`** and update nvim plugin
8. **Update `.zshrc`** to source generated `fzf.zsh`
9. **Test each tool** with `theme set <name>`

---

## Out of Scope

- **Dynamic OS theme sync** (follow macOS light/dark mode). Can be added later via a launchd agent calling `theme.py`.
- **Automatic scheme downloading** from the internet. User downloads YAMLs manually (or we add a `theme fetch <url>` later).
- **Neovim highlight group generation.** We delegate to existing colorscheme plugins.

---

## Dependencies

- Python 3.9+ (already on macOS)
- `jinja2` and `pyyaml` Python packages
- All existing tool configs remain valid
