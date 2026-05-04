# KESS - Project Overview & Technical Documentation

This mod introduces the **Kinetic Energy Storage System (KESS)**, a high-capacity (10GJ) late-game flywheel for Factorio 2.0.

## Technical Architecture

### Shadow Drain System
Factorio's `accumulator` prototype ignores the `drain` property in its native C++ implementation. To achieve realistic energy decay with zero visual pulsing and minimal performance impact, KESS uses a **Shadow Drain** approach:
- **Proxy Entity**: A hidden `electric-energy-interface` named `kess-drain-proxy` is spawned exactly on top of every flywheel.
- **Function**: It is configured as a `secondary-input` consumer. Its energy usage is dynamically calculated in `data.lua` based on the mod's startup settings.
- **Power Graph**: The proxy uses the high-res KESS icon and is named "KESS (Internal Leak)" in English (or "KESS (Interner Verlust)" in German) for transparent attribution in the power statistics.
- **Lifecycle**: `control.lua` manages the creation and destruction of these proxies.
  - **Dynamic Sync**: A synchronization function ensures that flywheels in existing saves receive their proxies automatically.
  - **Cleanup**: If the "Enable energy decay" startup setting is disabled, the script proactively removes all existing proxies from the save to ensure no residual drain or visual noise.
- **Performance**: Handled by the engine's electric network logic, resulting in 0ms Lua cost during regular gameplay.

### Graphics & Icons
- **Source**: High-resolution 845px sprite (`graphics/entity/kess-entity.png`).
- **Standardization**: All icons (item, entity, technology, and proxy) use the 845px sprite with explicit `icon_size = 845`. This prevents sprite-batching errors and ensures visual consistency across the UI.

### Deployment Workflow
- **Script**: `deploy.sh` automates zipping and uploading to the Factorio Mod Portal.
- **Requirements**: Requires `jq` and `FACTORIO_MOD_PORTAL_TOKEN`.
- **Packaging**: Uses `git archive` to ensure only tracked files are included in the release zip, following the `ModName_Version/` prefix convention.

## Versioning
- Minor changes increase the patch level.
- Bigger features and breaking changes increase the minor level.
- The major level is up to the author to change.

## Changelog Format (`changelog.txt`)

The project follows the strict Factorio-compatible changelog format to ensure correct parsing and display in the in-game GUI. Maintain the following structure:

```text
---------------------------------------------------------------------------------------------------
Version: 1.1.0
Date: DD. MM. YYYY
  Major Features:
    - Description of a high-level game-changing addition.
  Features:
    - Description of a standard new feature.
  Bugfixes:
    - Description of the fix.
    - This is a multiline entry example.
      Subsequent lines must have six spaces of indentation.
  Optimizations:
    - Improvements to UPS or memory usage.
```

### Recognized Categories:
While any category name is valid, Factorio prioritizes and sorts the following in the game GUI:
- `Major Features`
- `Features`
- `Graphics`
- `Modding`
- `Bugfixes`
- `Optimizations`
- `Scripting`
- `Translation`
- `Gui`
- `Changes`
- `Balancing`
- `Sound`
- `Combat`
- `Circuit Network`
- `Locale`

### Formatting Rules:
- **No Tabs:** Use spaces only. Tabs will cause parsing errors.
- **Section Start:** Exactly **99 dashes** (`-`).
- **Version/Date Lines:** Must start with `Version: ` or `Date: ` with exactly **one space** after the colon.
- **Categories:**
  - Must start with exactly **two spaces**.
  - Must end with a **colon** (e.g., `  Features:`).
- **Entries:**
  - Must start with exactly **four spaces**, followed by `- `.
  - Multiline entries must start subsequent lines with exactly **six spaces**.
- **Empty Lines:** Completely empty lines are skipped, except for the line immediately following the version section start line, which must not be empty.

## Ongoing Maintenance
- **Control Logic**: Monitor `storage.kess_shadows` for memory efficiency in extremely large bases.
- **Translations**: Sync `locale/de/config.cfg` whenever new strings are added to `locale/en/config.cfg`.
