# Orphaned Snap Packages Remover

## Description

Removes orphaned snap packages unless they are default providers or bases; also removes disabled snaps. Provides:
- Bash and Fish scripts
- Installer that places the script in /usr/local/bin
- systemd service and weekly timer
- Supports sudo or doas (auto-detect, overridable)

## Installation

Bash:
````bash
# Install (auto-detect doas/sudo; override with set -x OVERRIDE_ELEVATION=doas|sudo)
orphand_snaps install

# Uninstall
orphand_snaps uninstall
`````

Fish:
````fish
# Install (auto-detect doas/sudo; override with set -x OVERRIDE_ELEVATION=doas|sudo)
orphand_snaps install

# Uninstall
orphand_snaps uninstall
`````

## Undo

The last run records removed snaps to:
- State file: /var/lib/orphand_snaps/last_removed.txt

Usage:
````bash
# List snaps removed in the last run
orphand_snaps undo

# Reinstall a single snap
orphand_snaps undo SNAPNAME

# Reinstall all snaps removed in the last run
orphand_snaps undo all

## Usage

1. Save this script as a file (e.g. `orphand_snaps`)
2. Make the script executable with `chmod +x remove_orphaned_snaps`
3. Run the script with `./orphand_snaps`

## How it works

1. The script uses `snap connections` to find all snap packages that have no connections (i.e. are orphaned).
2. It filters out themes and slot-based connections.
3. It extracts the package names from the output and stores them in the `orphan` variable.
4. It checks if any of the orphaned packages are default providers for other packages by parsing the `snap.yaml` files.
5. If an orphaned package is a default provider, it will not be removed.
6. Otherwise, the script will remove the orphaned package using `sudo snap remove`.

## Notes

* Be careful when running this script, as it will permanently remove packages without prompting for confirmation.
