#!/usr/bin/env python3
"""
Resize app icons to add padding around them to prevent cropping on Android adaptive icons
"""

from PIL import Image
import os

# Paths
script_dir = os.path.dirname(os.path.abspath(__file__))
assets_dir = os.path.join(script_dir, 'assets', 'icon')

# Input files
app_icon_path = os.path.join(assets_dir, 'app_icon.png')
app_icon_fg_path = os.path.join(assets_dir, 'app_icon_foreground.png')

# Backup originals
app_icon_backup = os.path.join(assets_dir, 'app_icon_original.png')
app_icon_fg_backup = os.path.join(assets_dir, 'app_icon_foreground_original.png')

def resize_with_padding(input_path, output_path, backup_path, scale=0.75):
    """
    Resize icon to scale% and center it on transparent background
    This prevents Android from cropping the outer circle border
    """
    # Backup original
    if os.path.exists(input_path) and not os.path.exists(backup_path):
        img = Image.open(input_path)
        img.save(backup_path)
        print(f"✓ Backed up original to {os.path.basename(backup_path)}")

    # Open original (or backup if exists)
    source = backup_path if os.path.exists(backup_path) else input_path
    img = Image.open(source)

    # Get dimensions
    width, height = img.size
    new_size = int(width * scale)

    # Resize the icon
    resized = img.resize((new_size, new_size), Image.Resampling.LANCZOS)

    # Create new transparent canvas
    canvas = Image.new('RGBA', (width, height), (0, 0, 0, 0))

    # Calculate position to center the resized icon
    offset = (width - new_size) // 2

    # Paste resized icon onto center of canvas
    canvas.paste(resized, (offset, offset), resized if resized.mode == 'RGBA' else None)

    # Save
    canvas.save(output_path, 'PNG')
    print(f"✓ Resized {os.path.basename(input_path)} to {int(scale*100)}% with centered padding")

    # Show file size
    size_kb = os.path.getsize(output_path) / 1024
    print(f"  File size: {size_kb:.1f} KB")

def main():
    print("=" * 60)
    print("RESIZING APP ICONS WITH PADDING")
    print("=" * 60)

    # Resize both icons to 75% (leaves 12.5% padding on each side)
    # This ensures the outer golden circle won't be cropped by Android
    resize_with_padding(app_icon_path, app_icon_path, app_icon_backup, scale=0.75)
    resize_with_padding(app_icon_fg_path, app_icon_fg_path, app_icon_fg_backup, scale=0.75)

    print("\n✅ Done! Icons resized with padding to prevent cropping.")
    print("   Originals backed up as *_original.png")
    print("\nNext steps:")
    print("  1. Run: flutter pub run flutter_launcher_icons")
    print("  2. Uninstall old app: adb uninstall com.example.what2eat")
    print("  3. Install new app: flutter install")

if __name__ == '__main__':
    main()
