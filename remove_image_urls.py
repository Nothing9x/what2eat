#!/usr/bin/env python3
import re

# Read the file
with open('lib/models/default_food_data.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Remove imageUrl parameters from FoodItem constructors
# Pattern: , imageUrl: 'https://...')
# We want to keep the closing parenthesis but remove the imageUrl parameter
pattern = r",\s*imageUrl:\s*'[^']*'"
content = re.sub(pattern, '', content)

# Write back
with open('lib/models/default_food_data.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print('✅ Removed all imageUrl parameters from default_food_data.dart')
print('All FoodItems will now use emoji icons instead of images')
