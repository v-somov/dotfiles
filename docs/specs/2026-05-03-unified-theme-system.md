# Unified Terminal Theme System — Design Spec

## Goal
Replace the existing hardcoded dark/light file-copy switcher with a flexible, Base16-based theme engine that:
1. Supports **any number of named themes** downloaded from the internet (not just dark/light)
2. Generates all tool configs from a **single source of truth** (a Base16 palette YAML)
3. Covers: alacritty, tmux, zsh/fzf, neovim, eza, oh-my-posh, and Claude Code (OpenCode deferred — see Out of Scope)
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

| Tool | Template | Generated Path | Install / Source Location | Reload Strategy |
|---|---|---|---|---|
| **Alacritty** | `alacritty.toml.j2` | `theme/generated/alacritty.toml` | `~/.config/alacritty/alacritty.toml` (symlinked) | Live reload (no restart) |
| **Tmux** | `tmux.conf.j2` | `theme/generated/tmux.conf` | Sourced from `~/dotfiles/tmux.conf` via `source-file` | `tmux source-file <path>` |
| **ZSH / FZF** | `fzf.zsh.j2` | `theme/generated/fzf.zsh` | Sourced from `~/.zshrc` | See "Active Shell Reload" below |
| **Eza** | `eza.yml.j2` | `theme/generated/eza.yml` | `~/.config/eza/theme.yml` (symlinked) | Live on next `eza` invocation |
| **Oh-My-Posh** | `oh-my-posh.json.j2` | `theme/generated/oh-my-posh.json` | `--config` flag in `.zshrc` points here | New shells pick it up |
| **Neovim** | (mapping, not template) | `~/dotfiles/nvim/lua/theme.lua` | Loaded by nvim init | `:luafile` or restart |
| **Claude Code** | (JSON edit, not template) | `~/.claude/settings.json` `"theme"` field | In place | Restart or settings reload |

### Alacritty Path Migration
The current `switch_theme.sh` writes to `~/.alacritty.toml` (home dir, legacy). The new system uses `~/.config/alacritty/alacritty.toml` (XDG-compliant). Migration step removes `~/.alacritty.toml` and creates a symlink at the new path.

### Claude Code Theme Map
Claude Code supports: `dark`, `light`, `dark-daltonized`, `light-daltonized`, `dark-ansi`, `light-ansi`. The generator maps from the Base16 `variant` field:
```python
CLAUDE_THEME_MAP = {"dark": "dark", "light": "light"}  # extend if scheme overrides
```
A scheme YAML can override with an optional `claude_theme:` field if the user wants a non-default mapping.

### Active Shell Reload
`theme set` cannot source files into the parent shell. The fix: ship a zsh function (in `~/dotfiles/zsh/theme.zsh`) that wraps the Python CLI:

```zsh
theme() {
  python3 ~/dotfiles/theme/theme.py "$@" || return $?
  if [[ "$1" == "set" ]]; then
    source ~/dotfiles/theme/generated/fzf.zsh
    [[ -n "$TMUX" ]] && tmux source-file ~/dotfiles/theme/generated/tmux.conf
  fi
}
```

The Python script never calls `source` itself — that's the wrapper's job.

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

### Missing Variant Field
If a downloaded scheme YAML omits `variant`, the generator fails loudly with a clear error:
```
Error: theme 'foo.yml' is missing required field 'variant' (must be "dark" or "light").
       Add `variant: dark` (or `light`) to the YAML, or pass --infer-variant
       to derive it from base00 luminance.
```
The `--infer-variant` flag computes luminance from `base00` and picks `dark` if < 0.5, else `light`. Default is fail-fast — inference is opt-in to avoid silently mis-tagging schemes.

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
7. **Download 3–4 Base16 schemes** to populate `themes/`
8. **Bootstrap**: add `python3 ~/dotfiles/theme/theme.py set <default>` to `install/` script so a fresh clone has generated files before `.zshrc` runs. Also: `.zshrc` should guard the source line with `[[ -f ... ]]` to avoid breaking on first shell.
9. **Migrate alacritty path**: remove `~/.alacritty.toml`, symlink `~/.config/alacritty/alacritty.toml` → generated file, update any alacritty include paths.
10. **Add the `theme()` zsh wrapper** (see "Active Shell Reload" above) to `~/dotfiles/zsh/theme.zsh` and source it from `.zshrc`.
11. **Replace `switch_theme.sh`** and update nvim plugin to call the new CLI.
12. **Update `.zshrc`** to source generated `fzf.zsh` and point oh-my-posh `--config` at the generated JSON.
13. **Test each tool** with `theme set <name>`.

---

## Tradeoffs

**Breadth over depth.** Base16 gives you 16 colors. Tools with richer color schemas (eza has ~40 file-kind/permission/git slots; oh-my-posh segments map flexibly) lose nuance compared to a hand-tuned per-tool theme. The win is that *any* downloaded Base16 scheme works everywhere instantly — the loss is that no single theme will be as polished as a bespoke `tokyonight.yml` from upstream. This is the right tradeoff for "many themes, one source of truth."

**Jinja2 vs. stdlib.** Templates are simple `{{ baseXX }}` substitution — `string.Template` would suffice without the dep. We use Jinja2 anyway for: future conditionals (e.g., `{% if variant == "dark" %}`), better error messages, and the marginal cost of one extra pip install. If `theme.py` stays trivial, this is reversible.

---

## Out of Scope

- **OpenCode integration.** Defer until OpenCode confirms a stable theme settings API. Re-evaluate after initial rollout.
- **Dynamic OS theme sync** (follow macOS light/dark mode). Can be added later via a launchd agent calling `theme.py`.
- **Automatic scheme downloading** from the internet. User downloads YAMLs manually (or we add a `theme fetch <url>` later).
- **Neovim highlight group generation.** We delegate to existing colorscheme plugins.

---

## Dependencies

- Python 3.9+ (already on macOS)
- `jinja2` and `pyyaml` Python packages
- All existing tool configs remain valid
