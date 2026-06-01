# GNOME 50 Icon Fixer 🛠️

A script to fix broken/missing symbolic icons in 3rd-party icon themes on **GNOME 50+** (including **Fedora 44**).

## Why is this happening?
With the release of GNOME 50, a reorganization known as **"The Great Icon Cleanup"** renamed several symbolic category icons. Most community-maintained themes (like Fluent, Tela, WhiteSur) still use the legacy naming scheme (`applications-xxx-symbolic`), which causes icons to disappear in the **GNOME Software** store and **Extension Manager**.

## How it works
This script identifies the missing category icons and maps them to their modern counterparts (`category-xxx-symbolic`) by leveraging the system's Adwaita symbols. It then force-refreshes the icon cache to ensure the changes take effect immediately.

## Quick Install (via curl)
You can run the fix directly without cloning:

```bash
curl -sSL https://raw.githubusercontent.com/gutopardini/gnome-50-icon-fix/main/fix-icons.sh | bash -s -- YourThemeName
```
*(Replace `YourThemeName` with the name of your theme folder, e.g., `Fluent`)*

## Local Usage
1. Clone this repository.
2. Run the script:
   ```bash
   chmod +x fix-icons.sh
   ./fix-icons.sh YourThemeName
   ```

## Requirements
- GNOME 50+
- `gtk-update-icon-cache` (usually installed by default)
- Sudo privileges (to refresh the system `hicolor` cache)
