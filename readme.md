# Orphaned Snap Packages Remover

## Description

Removes orphaned snap packages unless they are default providers or bases; also removes disabled snaps.

## How it works

1. The script uses `snap connections` to find all snap packages that have no connections (i.e. are orphaned).
2. It filters out themes and slot-based connections.
3. It extracts the package names from the output and stores them in the `orphan` variable.
4. It checks if any of the orphaned packages are default providers for other packages by parsing the `snap.yaml` files.
5. If an orphaned package is a default provider, it will not be removed.
6. Otherwise, the script will remove the orphaned package using elevated privileges (sudo/doas).

## Installation

Install via Debian package:
```bash
sudo dpkg -i orphand-snaps_*.deb
```

The installation:
- Creates the systemd service and weekly timer (automatically enabled)
- Prepares the state directory `/var/lib/orphand-snaps/` for tracking removed snaps
- Installs the man page

## Usage

### Automatic Cleanup (via systemd timer)
Once installed, a weekly timer runs the cleanup automatically every 7 days.

### Manual Cleanup
Run directly:
```bash
orphand-snaps
```

When run as a non-root user, the script will use elevated privileges (sudo/doas) automatically.

To override the elevation method:
```bash
OVERRIDE_ELEVATION=doas orphand-snaps
```
`

## Undo (Restore Removed Snaps)

The last run records removed snaps to:
- State file: `/var/lib/orphand-snaps/last_removed.txt`

### Usage

List snaps removed in the last run:
```bash
orphand-snaps undo
```

Restore a single snap:
```bash
orphand-snaps undo SNAPNAME
```

Restore all snaps removed in the last run:
```bash
orphand-snaps undo all
```

## Uninstallation

To uninstall the package and clean up:
```bash
sudo apt remove orphand-snaps
```

This will:
- Disable and remove the systemd timer and service
- Keep the state file for reference (see `sudo dpkg --purge orphand-snaps` to also remove it)

To completely remove all data:
```bash
sudo dpkg --purge orphand-snaps
```

## Notes

* Be careful when running this script, as it will permanently remove packages without prompting for confirmation.
* The script requires `snapd` to be installed.
* Elevated privileges (sudo or doas) are required for snap removal operations when running as a non-root user.
