#!/usr/bin/env python3
"""
Add short weekday names to all localization files
"""

import json
import os

# Map of language code to short weekday names (Mon, Tue, Wed, Thu, Fri, Sat, Sun)
weekday_short_map = {
    'en': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    'vi': ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
    'zh': ['一', '二', '三', '四', '五', '六', '日'],
    'ja': ['月', '火', '水', '木', '金', '土', '日'],
    'ko': ['월', '화', '수', '목', '금', '토', '일'],
    'es': ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
    'fr': ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
    'de': ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
    'th': ['จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส', 'อา'],
    'it': ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'],
    'pt': ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
    'ru': ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'],
    'hi': ['सोम', 'मंगल', 'बुध', 'गुरु', 'शुक्र', 'शनि', 'रवि'],
    'id': ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
    'ar': ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'],
    'tr': ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'],
    'pl': ['Pon', 'Wt', 'Śr', 'Czw', 'Pt', 'Sob', 'Nie'],
    'nl': ['Ma', 'Di', 'Wo', 'Do', 'Vr', 'Za', 'Zo'],
    'sv': ['Mån', 'Tis', 'Ons', 'Tor', 'Fre', 'Lör', 'Sön'],
    'uk': ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Нд'],
    'el': ['Δευ', 'Τρί', 'Τετ', 'Πέμ', 'Παρ', 'Σάβ', 'Κυρ'],
    'hu': ['H', 'K', 'Sze', 'Cs', 'P', 'Szo', 'V'],
    'cs': ['Po', 'Út', 'St', 'Čt', 'Pá', 'So', 'Ne'],
    'ro': ['Lun', 'Mar', 'Mie', 'Joi', 'Vin', 'Sâm', 'Dum'],
}

def update_arb_file(file_path, lang_code):
    """Add short weekday names to ARB file"""

    if lang_code not in weekday_short_map:
        print(f"⚠  Skipping {lang_code} - no short weekday mapping defined")
        return

    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    short_names = weekday_short_map[lang_code]
    weekday_keys = ['mondayShort', 'tuesdayShort', 'wednesdayShort', 'thursdayShort',
                    'fridayShort', 'saturdayShort', 'sundayShort']

    # Find position after sunday key
    keys = list(data.keys())
    insert_index = -1
    for i, key in enumerate(keys):
        if key == 'sunday':
            insert_index = i + 1
            break

    # Add short weekday names
    new_data = {}
    added = False
    for i, key in enumerate(keys):
        new_data[key] = data[key]
        if i == insert_index - 1 and not added:
            # Insert short weekday names after sunday
            for short_key, short_val in zip(weekday_keys, short_names):
                new_data[short_key] = short_val
            added = True

    # If not added yet, add at the end (before last closing brace)
    if not added:
        for short_key, short_val in zip(weekday_keys, short_names):
            new_data[short_key] = short_val

    # Write back
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(new_data, f, ensure_ascii=False, indent=2)
        f.write('\n')

    print(f"✓ Updated {lang_code}: {', '.join(short_names)}")

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    l10n_dir = os.path.join(script_dir, 'lib', 'l10n')

    print("=" * 60)
    print("ADDING SHORT WEEKDAY NAMES TO ALL LANGUAGES")
    print("=" * 60)

    for filename in sorted(os.listdir(l10n_dir)):
        if filename.startswith('app_') and filename.endswith('.arb'):
            lang_code = filename.replace('app_', '').replace('.arb', '')
            file_path = os.path.join(l10n_dir, filename)
            update_arb_file(file_path, lang_code)

    print("\n✅ Done! All localization files updated with short weekday names.")
    print("\nNext: Update notification_settings_screen.dart to use these new keys")

if __name__ == '__main__':
    main()
