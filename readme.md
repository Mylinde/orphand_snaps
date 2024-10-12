**Orphaned Snap Packages Remover**
=====================================

**Description**
---------------

This script finds and removes orphaned snap packages on a Linux system, unless they serve as a default provider for another snap package.

**Usage**
-----

1. Save this script as a file (e.g. `remove_orphaned_snaps.sh`)
2. Make the script executable with `chmod +x remove_orphaned_snaps.sh`
3. Run the script with `./remove_orphaned_snaps.sh`

**How it works**
----------------

1. The script uses `snap connections` to find all snap packages that have no connections (i.e. are orphaned).
2. It filters out themes and slot-based connections.
3. It extracts the package names from the output and stores them in the `orphan` variable.
4. It checks if any of the orphaned packages are default providers for other packages by parsing the `snap.yaml` files.
5. If an orphaned package is a default provider, it will not be removed.
6. Otherwise, the script will remove the orphaned package using `sudo snap remove`.

**Notes**
-----

* Be careful when running this script, as it will permanently remove packages without prompting for confirmation.
