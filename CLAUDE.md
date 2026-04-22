# Chezmoi dotfiles

## Karabiner config formatting

When editing `dot_config/karabiner/karabiner.json`, match the format Karabiner uses when it saves the file, to avoid diffs on `chezmoi apply`:

- Fields are sorted **alphabetically** within each object (e.g. `"type": "basic"` goes at the end, after `"to"` and `"to_if_alone"`)
- Simple single-item arrays are **inlined**: `[{ "key_code": "escape" }]` not multiline
- Profile-level fields order: `complex_modifications`, `devices`, `name`, `selected`, `virtual_hid_keyboard`
- **No trailing newline** at end of file
