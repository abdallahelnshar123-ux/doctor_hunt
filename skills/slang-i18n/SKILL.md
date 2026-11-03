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
- **Linked Translations (Reusing Keys):** To prevent duplication and reduce the generated file size, you can reference another key's value using `@:path.to.key`. 
  - *Example in JSON:*
    ```json
    {
      "common": {
        "next": "Next",
        "skip": "Skip"
      },
      "onboarding": {
        "btn_next": "@:common.next",
        "btn_skip": "@:common.skip"
      }
    }
    ```
- **Interfaces (Polymorphism in Translations):** When dealing with lists of objects that share the same structure (e.g., Onboarding pages, Pricing plans), use the `(interface=Name)` modifier directly in the JSON file. 
  - ❌ **DO NOT** declare paths in `slang.yaml` (Deprecated since v4.13.0).
  - ✅ **DO** declare it directly in the `.i18n.json` file:
    ```json
    {
      "onboarding": {
        "pages(interface=PageData)": [
          { "title": "Page 1", "description": "Desc 1", "image": "assets/1.png" },
          { "title": "Page 2", "description": "Desc 2", "image": "assets/2.png" }
        ]
      }
    }
    ```
  - *Note:* Do not put global UI elements (like "Next" or "Skip" buttons) inside these interface lists. Keep the interface focused only on the unique data for each item.
- **Numbers and Versions in Keys:** Slang strips special characters and underscores around numbers. A JSON key like `"v1_0_0"` will be generated in Dart as `v100` (e.g., `t.settings.v100`). Always double-check the generated getter name.
- **Dynamic Backend Errors:** The project uses the `maps:` property in `../../slang.yaml` for things like `e_codes`. This generates a `Map<String, String>` where keys remain `snake_case`. This is intentional so you can do direct lookups for backend errors: `t.eCodes['email_already_in_use']`.
- **Finding Dead Code:** Use the analyzer command periodically to detect unused translations:
  ```bash
  dart run slang analyze --full
  ```