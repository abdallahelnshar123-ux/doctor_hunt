---
name: slang-i18n
description: Use this skill whenever the user mentions translations, localizations, internationalization, i18n, adding new languages, modifying text, or using the "slang" package in Flutter. It contains strict rules on generation commands, slang.yaml configuration, JSON key casing, and avoiding build_runner conflicts.
---

# 🌐 Flutter Slang (i18n) - Custom Skill & Best Practices

You are an expert Flutter developer. When working with translations and localizations in this project, you MUST adhere strictly to the following `slang` package guidelines:

## 1. Execution & Generation (Strict Rule)
- ❌ **DO NOT** use `slang_build_runner` or `build_runner` to generate translations. It causes conflicts and generates unwanted duplicate folders (e.g., `gen/`).
- ✅ **ALWAYS** use the standalone CLI command to generate or update translations:
  ```bash
  dart run slang
  ```

## 2. Configuration Standard (`../../slang.yaml`)
The project relies on a strictly configured `../../slang.yaml` file at the root. Do not alter these core rules unless explicitly asked:
- `key_case: camel`: Ensures all generated Dart getters are strictly `camelCase` to comply with Dart Clean Code standards.
- `key_map_case: snake`: Ensures keys inside specific `maps` (like backend error codes) retain their original `snake_case` format.

## 3. JSON Files Convention (`.i18n.json`)
- **Naming:** Files must be named following the `<locale>.i18n.json` pattern (e.g., `../../assets/i18n/en.i18n.json`).
- **Syntax:** All JSON keys **MUST** be written in pure `snake_case` (e.g., `welcome_back`, `forgot_password`, `user_name`). DO NOT use `camelCase` inside the JSON files.

## 4. Dart Code Implementation
- Access translations using the global `t` variable.
- You **MUST** translate the JSON `snake_case` keys to `camelCase` when writing Dart code.
  - *Example:* JSON `"create_doctor": "..."` ➔ Dart `t.createDoctor`.

## 5. Advanced Edge Cases & Fixes (Lessons Learned)
When modifying translations, keep these architectural decisions in mind:

- **Ignoring Unused Keys (Commenting):** If a translation key is unused but should be kept as a reference, **DO NOT delete it**. Instead, prefix the key with `@` in the JSON file (e.g., `"@old_title": "Old"`). Slang will ignore it, keeping the Dart code clean.
- **Numbers and Versions in Keys:** Slang strips special characters and underscores around numbers. A JSON key like `"v1_0_0"` will be generated in Dart as `v100` (e.g., `t.settings.v100`). Always double-check the generated getter name.
- **Dynamic Backend Errors:** The project uses the `maps:` property in `../../slang.yaml` for things like `e_codes`. This generates a `Map<String, String>` where keys remain `snake_case`. This is intentional so you can do direct lookups for backend errors: `t.eCodes['email_already_in_use']`.
- **Finding Dead Code:** Use the analyzer command periodically to detect unused translations:
  ```bash
  dart run slang analyze --full
  ```