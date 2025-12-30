import 'package:flutter/material.dart';
import 'food_category.dart';
import 'food_item.dart';

class DefaultFoodData {
  /// Get default categories based on country code
  static List<FoodCategory> getCategoriesByCountry(String countryCode) {
    switch (countryCode.toUpperCase()) {
      case 'VN': // Vietnam
        return _getVietnameseCategories();
      case 'US': // USA
      case 'CA': // Canada
        return _getAmericanCategories();
      case 'JP': // Japan
        return _getJapaneseCategories();
      case 'KR': // Korea
        return _getKoreanCategories();
      case 'CN': // China
        return _getChineseCategories();
      case 'TH': // Thailand
        return _getThaiCategories();
      case 'ES': // Spain
        return _getSpanishCategories();
      case 'FR': // France
        return _getFrenchCategories();
      case 'DE': // Germany
        return _getGermanCategories();
      case 'IT': // Italy
        return _getItalianCategories();
      case 'IN': // India
        return _getIndianCategories();
      case 'GB': // UK
        return _getBritishCategories();
      default:
        // Default to international categories
        return _getInternationalCategories();
    }
  }

  // Vietnamese Categories
  static List<FoodCategory> _getVietnameseCategories() {
    return [
      FoodCategory(
        name: 'Sáng',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Bánh Mì', icon: '🥖', description: 'Bánh mì Việt Nam', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Phở', icon: '🍜', description: 'Phở bò tái', imageUrl: 'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=800'),
          FoodItem(name: 'Xôi', icon: '🍙', description: 'Xôi xéo', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
          FoodItem(name: 'Cháo', icon: '🥣', description: 'Cháo gà', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'Bún Bò', icon: '🍜', description: 'Bún bò Huế', imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800'),
          FoodItem(name: 'Hủ Tiếu', icon: '🍜', description: 'Hủ tiếu Nam Vang', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Trưa',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Cơm Tấm', icon: '🍚', description: 'Cơm tấm sườn bì', imageUrl: 'https://images.unsplash.com/photo-1569562211093-4ed0d0758f12?w=800'),
          FoodItem(name: 'Bún Bò', icon: '🍜', description: 'Bún bò Huế', imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800'),
          FoodItem(name: 'Mì Quảng', icon: '🍜', description: 'Mì Quảng tôm thịt', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
          FoodItem(name: 'Cơm Rang', icon: '🍛', description: 'Cơm rang dương châu', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'Bún Chả', icon: '🍢', description: 'Bún chả Hà Nội', imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=800'),
          FoodItem(name: 'Phở', icon: '🍜', description: 'Phở bò tái', imageUrl: 'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Tối',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Lẩu', icon: '🍲', description: 'Lẩu Thái', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'Nướng', icon: '🥩', description: 'Thịt nướng BBQ', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'Gà Rán', icon: '🍗', description: 'Gà rán giòn', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'Pizza', icon: '🍕', description: 'Pizza Hải Sản', imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800'),
          FoodItem(name: 'Burger', icon: '🍔', description: 'Burger bò phô mai', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800'),
          FoodItem(name: 'Mì Ý', icon: '🍝', description: 'Mì Ý sốt bò băm', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Cà Phê', icon: '☕', description: 'Cà phê đen đá', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Trà Sữa', icon: '🧋', description: 'Trà sữa trân châu', imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=800'),
          FoodItem(name: 'Bánh Ngọt', icon: '🧁', description: 'Bánh cupcake', imageUrl: 'https://images.unsplash.com/photo-1587668178277-295251f900ce?w=800'),
          FoodItem(name: 'Smoothie', icon: '🥤', description: 'Smoothie dâu', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
          FoodItem(name: 'Bánh Croissant', icon: '🥐', description: 'Croissant bơ', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Trà Trái Cây', icon: '🍹', description: 'Trà đào cam sả', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
        ],
      ),
    ];
  }

  // American Categories
  static List<FoodCategory> _getAmericanCategories() {
    return [
      FoodCategory(
        name: 'Breakfast',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Pancakes', icon: '🥞', description: 'Fluffy pancakes with syrup', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Waffles', icon: '🧇', description: 'Belgian waffles', imageUrl: 'https://images.unsplash.com/photo-1562376552-0d160a2f238d?w=800'),
          FoodItem(name: 'Eggs & Bacon', icon: '🍳', description: 'Scrambled eggs with bacon', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Bagel', icon: '🥯', description: 'Bagel with cream cheese', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Oatmeal', icon: '🥣', description: 'Oatmeal with fruits', imageUrl: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?w=800'),
          FoodItem(name: 'French Toast', icon: '🍞', description: 'Cinnamon french toast', imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Burger', icon: '🍔', description: 'Classic cheeseburger', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800'),
          FoodItem(name: 'Pizza', icon: '🍕', description: 'Pepperoni pizza', imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800'),
          FoodItem(name: 'Sandwich', icon: '🥪', description: 'Club sandwich', imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=800'),
          FoodItem(name: 'Tacos', icon: '🌮', description: 'Beef tacos', imageUrl: 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=800'),
          FoodItem(name: 'Hot Dog', icon: '🌭', description: 'Chicago hot dog', imageUrl: 'https://images.unsplash.com/photo-1612392062422-ef19b42f74df?w=800'),
          FoodItem(name: 'Salad', icon: '🥗', description: 'Caesar salad', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Steak', icon: '🥩', description: 'Grilled ribeye steak', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'BBQ Ribs', icon: '🍖', description: 'BBQ pork ribs', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Fried Chicken', icon: '🍗', description: 'Southern fried chicken', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'Mac & Cheese', icon: '🧀', description: 'Macaroni and cheese', imageUrl: 'https://images.unsplash.com/photo-1543826173-1beac6ea4909?w=800'),
          FoodItem(name: 'Lobster', icon: '🦞', description: 'Steamed lobster', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
          FoodItem(name: 'Pasta', icon: '🍝', description: 'Spaghetti with meatballs', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Coffee', icon: '☕', description: 'Americano', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Latte', icon: '☕', description: 'Caffe latte', imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800'),
          FoodItem(name: 'Donut', icon: '🍩', description: 'Glazed donut', imageUrl: 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=800'),
          FoodItem(name: 'Muffin', icon: '🧁', description: 'Blueberry muffin', imageUrl: 'https://images.unsplash.com/photo-1587668178277-295251f900ce?w=800'),
          FoodItem(name: 'Smoothie', icon: '🥤', description: 'Berry smoothie', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
          FoodItem(name: 'Brownie', icon: '🍫', description: 'Chocolate brownie', imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800'),
        ],
      ),
    ];
  }

  // Japanese Categories
  static List<FoodCategory> _getJapaneseCategories() {
    return [
      FoodCategory(
        name: '朝食',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: '納豆ご飯', icon: '🍚', description: 'Natto rice', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
          FoodItem(name: '味噌汁', icon: '🍲', description: 'Miso soup', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: '焼き魚', icon: '🐟', description: 'Grilled fish', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
          FoodItem(name: '卵焼き', icon: '🍳', description: 'Tamagoyaki', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'おにぎり', icon: '🍙', description: 'Rice ball', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
          FoodItem(name: 'お粥', icon: '🥣', description: 'Rice porridge', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
        ],
      ),
      FoodCategory(
        name: '昼食',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'ラーメン', icon: '🍜', description: 'Ramen', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
          FoodItem(name: '寿司', icon: '🍣', description: 'Sushi', imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800'),
          FoodItem(name: 'うどん', icon: '🍜', description: 'Udon noodles', imageUrl: 'https://images.unsplash.com/photo-1618841557871-b9a00c0f36b0?w=800'),
          FoodItem(name: '天丼', icon: '🍱', description: 'Tempura rice bowl', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
          FoodItem(name: 'カレーライス', icon: '🍛', description: 'Curry rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'そば', icon: '🍜', description: 'Soba noodles', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
        ],
      ),
      FoodCategory(
        name: '夕食',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: '焼肉', icon: '🥩', description: 'Yakiniku', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'すき焼き', icon: '🍲', description: 'Sukiyaki', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'とんかつ', icon: '🍖', description: 'Tonkatsu', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'お好み焼き', icon: '🥞', description: 'Okonomiyaki', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: '刺身', icon: '🍣', description: 'Sashimi', imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800'),
          FoodItem(name: '天ぷら', icon: '🍤', description: 'Tempura', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
        ],
      ),
      FoodCategory(
        name: 'カフェ',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: '抹茶ラテ', icon: '🍵', description: 'Matcha latte', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
          FoodItem(name: 'コーヒー', icon: '☕', description: 'Coffee', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'だんご', icon: '🍡', description: 'Dango', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
          FoodItem(name: 'どら焼き', icon: '🥞', description: 'Dorayaki', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'タピオカ', icon: '🧋', description: 'Bubble tea', imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=800'),
          FoodItem(name: 'パンケーキ', icon: '🥞', description: 'Pancake', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
        ],
      ),
    ];
  }

  // Korean Categories
  static List<FoodCategory> _getKoreanCategories() {
    return [
      FoodCategory(
        name: '아침',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: '김치찌개', icon: '🍲', description: 'Kimchi stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: '된장찌개', icon: '🍲', description: 'Soybean paste stew', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: '계란말이', icon: '🍳', description: 'Egg roll', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: '죽', icon: '🥣', description: 'Porridge', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: '김밥', icon: '🍙', description: 'Kimbap', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
          FoodItem(name: '토스트', icon: '🍞', description: 'Korean toast', imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=800'),
        ],
      ),
      FoodCategory(
        name: '점심',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: '비빔밥', icon: '🍚', description: 'Bibimbap', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: '냉면', icon: '🍜', description: 'Cold noodles', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
          FoodItem(name: '불고기', icon: '🥩', description: 'Bulgogi', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: '삼겹살', icon: '🥓', description: 'Pork belly', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: '짜장면', icon: '🍜', description: 'Jjajangmyeon', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
          FoodItem(name: '김치볶음밥', icon: '🍛', description: 'Kimchi fried rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
        ],
      ),
      FoodCategory(
        name: '저녁',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: '삼계탕', icon: '🍲', description: 'Ginseng chicken soup', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: '갈비찜', icon: '🍖', description: 'Braised short ribs', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: '치킨', icon: '🍗', description: 'Korean fried chicken', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: '떡볶이', icon: '🍢', description: 'Tteokbokki', imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=800'),
          FoodItem(name: '부대찌개', icon: '🍲', description: 'Army stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: '곱창', icon: '🥩', description: 'Grilled intestines', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
        ],
      ),
      FoodCategory(
        name: '카페',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: '아메리카노', icon: '☕', description: 'Americano', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: '라떼', icon: '☕', description: 'Latte', imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800'),
          FoodItem(name: '빙수', icon: '🍧', description: 'Bingsu', imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
          FoodItem(name: '케이크', icon: '🍰', description: 'Cake', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: '버블티', icon: '🧋', description: 'Bubble tea', imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=800'),
          FoodItem(name: '마카롱', icon: '🍪', description: 'Macaron', imageUrl: 'https://images.unsplash.com/photo-1571506165871-ee72a35f85bb?w=800'),
        ],
      ),
    ];
  }

  // Chinese Categories
  static List<FoodCategory> _getChineseCategories() {
    return [
      FoodCategory(
        name: '早餐',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: '包子', icon: '🥟', description: 'Steamed buns', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
          FoodItem(name: '油条', icon: '🥖', description: 'Fried dough stick', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: '豆浆', icon: '🥤', description: 'Soy milk', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
          FoodItem(name: '粥', icon: '🥣', description: 'Congee', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: '煎饼', icon: '🥞', description: 'Jianbing', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: '小笼包', icon: '🥟', description: 'Soup dumplings', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
        ],
      ),
      FoodCategory(
        name: '午餐',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: '炒饭', icon: '🍛', description: 'Fried rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: '面条', icon: '🍜', description: 'Noodles', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
          FoodItem(name: '饺子', icon: '🥟', description: 'Dumplings', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
          FoodItem(name: '盖浇饭', icon: '🍚', description: 'Rice with toppings', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: '麻辣烫', icon: '🍲', description: 'Spicy hot pot', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: '煎饺', icon: '🥟', description: 'Pan-fried dumplings', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
        ],
      ),
      FoodCategory(
        name: '晚餐',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: '火锅', icon: '🍲', description: 'Hot pot', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: '烤鸭', icon: '🦆', description: 'Roast duck', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: '烧烤', icon: '🥩', description: 'BBQ', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: '糖醋里脊', icon: '🍖', description: 'Sweet & sour pork', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: '宫保鸡丁', icon: '🍗', description: 'Kung Pao chicken', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: '红烧肉', icon: '🥩', description: 'Braised pork belly', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
        ],
      ),
      FoodCategory(
        name: '咖啡',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: '奶茶', icon: '🧋', description: 'Milk tea', imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=800'),
          FoodItem(name: '咖啡', icon: '☕', description: 'Coffee', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: '蛋糕', icon: '🍰', description: 'Cake', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: '泡芙', icon: '🧁', description: 'Cream puff', imageUrl: 'https://images.unsplash.com/photo-1587668178277-295251f900ce?w=800'),
          FoodItem(name: '烧仙草', icon: '🥤', description: 'Grass jelly drink', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
          FoodItem(name: '水果茶', icon: '🍹', description: 'Fruit tea', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
        ],
      ),
    ];
  }

  // Thai Categories
  static List<FoodCategory> _getThaiCategories() {
    return [
      FoodCategory(
        name: 'อาหารเช้า',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'ข้าวต้ม', icon: '🥣', description: 'Rice soup', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'โจ๊ก', icon: '🥣', description: 'Congee', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'ปาท่องโก๋', icon: '🥖', description: 'Fried dough', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'ก๋วยเตี๋ยว', icon: '🍜', description: 'Noodle soup', imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800'),
          FoodItem(name: 'ข้าวเหนียวหมูปิ้ง', icon: '🍙', description: 'Sticky rice with grilled pork', imageUrl: 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=800'),
          FoodItem(name: 'ขนมปังสังขยา', icon: '🍞', description: 'Pandan custard toast', imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=800'),
        ],
      ),
      FoodCategory(
        name: 'อาหารกลางวัน',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'ผัดไทย', icon: '🍜', description: 'Pad Thai', imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=800'),
          FoodItem(name: 'ข้าวผัด', icon: '🍛', description: 'Fried rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'ต้มยำกุ้ง', icon: '🍲', description: 'Tom Yum soup', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'ส้มตำ', icon: '🥗', description: 'Papaya salad', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          FoodItem(name: 'ข้าวมันไก่', icon: '🍚', description: 'Chicken rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'แกงเขียวหวาน', icon: '🍲', description: 'Green curry', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
        ],
      ),
      FoodCategory(
        name: 'อาหารเย็น',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'หมูกระทะ', icon: '🍲', description: 'Thai BBQ', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'ปลาเผา', icon: '🐟', description: 'Grilled fish', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
          FoodItem(name: 'หมูย่าง', icon: '🥩', description: 'Grilled pork', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'ไก่ทอด', icon: '🍗', description: 'Fried chicken', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'ข้าวหน้าเป็ด', icon: '🍚', description: 'Duck over rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'ต้มข่าไก่', icon: '🍲', description: 'Tom Kha Gai', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
        ],
      ),
      FoodCategory(
        name: 'คาเฟ่',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'กาแฟเย็น', icon: '☕', description: 'Iced coffee', imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800'),
          FoodItem(name: 'ชาเย็น', icon: '🧋', description: 'Thai iced tea', imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=800'),
          FoodItem(name: 'ข้าวเหนียวมะม่วง', icon: '🥭', description: 'Mango sticky rice', imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800'),
          FoodItem(name: 'โรตี', icon: '🥞', description: 'Roti', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'ขนมปังหน้าหมู', icon: '🍞', description: 'Toast with pork floss', imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=800'),
          FoodItem(name: 'ชาเขียว', icon: '🍵', description: 'Green tea', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
        ],
      ),
    ];
  }

  // Spanish Categories
  static List<FoodCategory> _getSpanishCategories() {
    return [
      FoodCategory(
        name: 'Desayuno',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Churros', icon: '🥖', description: 'Churros con chocolate', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Tostada', icon: '🍞', description: 'Pan con tomate', imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=800'),
          FoodItem(name: 'Tortilla', icon: '🍳', description: 'Tortilla española', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Magdalenas', icon: '🧁', description: 'Muffins', imageUrl: 'https://images.unsplash.com/photo-1587668178277-295251f900ce?w=800'),
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Croissant', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Café con leche', icon: '☕', description: 'Coffee with milk', imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Almuerzo',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Paella', icon: '🥘', description: 'Paella valenciana', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'Tapas', icon: '🍢', description: 'Spanish tapas', imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=800'),
          FoodItem(name: 'Jamón', icon: '🥓', description: 'Jamón ibérico', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Gazpacho', icon: '🥣', description: 'Cold tomato soup', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'Croquetas', icon: '🥟', description: 'Spanish croquettes', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
          FoodItem(name: 'Ensalada', icon: '🥗', description: 'Spanish salad', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Cena',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Fabada', icon: '🍲', description: 'Bean stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'Pulpo', icon: '🐙', description: 'Pulpo a la gallega', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
          FoodItem(name: 'Pescado', icon: '🐟', description: 'Grilled fish', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
          FoodItem(name: 'Cocido', icon: '🍲', description: 'Spanish stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'Albóndigas', icon: '🍖', description: 'Meatballs', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Solomillo', icon: '🥩', description: 'Pork tenderloin', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Café',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Café', icon: '☕', description: 'Espresso', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Cortado', icon: '☕', description: 'Cortado', imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800'),
          FoodItem(name: 'Pastel', icon: '🍰', description: 'Cake', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: 'Flan', icon: '🍮', description: 'Caramel custard', imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
          FoodItem(name: 'Horchata', icon: '🥤', description: 'Horchata', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
          FoodItem(name: 'Tarta', icon: '🍰', description: 'Tart', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
        ],
      ),
    ];
  }

  // French Categories
  static List<FoodCategory> _getFrenchCategories() {
    return [
      FoodCategory(
        name: 'Petit déjeuner',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Butter croissant', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Pain au chocolat', icon: '🥐', description: 'Chocolate croissant', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Baguette', icon: '🥖', description: 'French baguette', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Café au lait', icon: '☕', description: 'Coffee with milk', imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800'),
          FoodItem(name: 'Omelette', icon: '🍳', description: 'French omelette', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Brioche', icon: '🥖', description: 'Sweet bread', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Déjeuner',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Quiche', icon: '🥧', description: 'Quiche lorraine', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Croque monsieur', icon: '🥪', description: 'Grilled ham & cheese', imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=800'),
          FoodItem(name: 'Salade niçoise', icon: '🥗', description: 'Nice salad', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          FoodItem(name: 'Soupe à l\'oignon', icon: '🍲', description: 'French onion soup', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'Steak frites', icon: '🥩', description: 'Steak with fries', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'Ratatouille', icon: '🍲', description: 'Vegetable stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Dîner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Coq au vin', icon: '🍗', description: 'Chicken in wine', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'Bouillabaisse', icon: '🍲', description: 'Fish stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'Boeuf bourguignon', icon: '🥩', description: 'Beef stew', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'Confit de canard', icon: '🦆', description: 'Duck confit', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Cassoulet', icon: '🍲', description: 'Bean stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'Escargots', icon: '🐌', description: 'Snails in garlic butter', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Café',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Espresso', icon: '☕', description: 'French espresso', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Macaron', icon: '🍪', description: 'French macaron', imageUrl: 'https://images.unsplash.com/photo-1571506165871-ee72a35f85bb?w=800'),
          FoodItem(name: 'Éclair', icon: '🧁', description: 'Chocolate éclair', imageUrl: 'https://images.unsplash.com/photo-1587668178277-295251f900ce?w=800'),
          FoodItem(name: 'Crêpe', icon: '🥞', description: 'French crêpe', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Tarte tatin', icon: '🥧', description: 'Apple tart', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Mousse', icon: '🍫', description: 'Chocolate mousse', imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800'),
        ],
      ),
    ];
  }

  // German Categories
  static List<FoodCategory> _getGermanCategories() {
    return [
      FoodCategory(
        name: 'Frühstück',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Brötchen', icon: '🥖', description: 'Bread rolls', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Wurst', icon: '🌭', description: 'German sausage', imageUrl: 'https://images.unsplash.com/photo-1612392062422-ef19b42f74df?w=800'),
          FoodItem(name: 'Käse', icon: '🧀', description: 'German cheese', imageUrl: 'https://images.unsplash.com/photo-1543826173-1beac6ea4909?w=800'),
          FoodItem(name: 'Müsli', icon: '🥣', description: 'Muesli', imageUrl: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?w=800'),
          FoodItem(name: 'Rührei', icon: '🍳', description: 'Scrambled eggs', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Croissant', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Mittagessen',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Currywurst', icon: '🌭', description: 'Curry sausage', imageUrl: 'https://images.unsplash.com/photo-1612392062422-ef19b42f74df?w=800'),
          FoodItem(name: 'Schnitzel', icon: '🍖', description: 'Breaded cutlet', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Bratwurst', icon: '🌭', description: 'Grilled sausage', imageUrl: 'https://images.unsplash.com/photo-1612392062422-ef19b42f74df?w=800'),
          FoodItem(name: 'Kartoffelsalat', icon: '🥗', description: 'Potato salad', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          FoodItem(name: 'Döner', icon: '🥙', description: 'Doner kebab', imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=800'),
          FoodItem(name: 'Bratkartoffeln', icon: '🥔', description: 'Fried potatoes', imageUrl: 'https://images.unsplash.com/photo-1518013431117-eb1465fa5752?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Abendessen',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Sauerbraten', icon: '🥩', description: 'Pot roast', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'Schweinshaxe', icon: '🍖', description: 'Pork knuckle', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Rouladen', icon: '🥩', description: 'Beef rolls', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'Spätzle', icon: '🍝', description: 'German noodles', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800'),
          FoodItem(name: 'Eintopf', icon: '🍲', description: 'German stew', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'Fisch', icon: '🐟', description: 'Fish', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Café',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Kaffee', icon: '☕', description: 'German coffee', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Kuchen', icon: '🍰', description: 'Cake', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: 'Schwarzwälder Kirschtorte', icon: '🍰', description: 'Black forest cake', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: 'Apfelstrudel', icon: '🥧', description: 'Apple strudel', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Brezeln', icon: '🥨', description: 'Pretzels', imageUrl: 'https://images.unsplash.com/photo-1486335370777-73dfe63fe1c4?w=800'),
          FoodItem(name: 'Sachertorte', icon: '🍫', description: 'Chocolate cake', imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800'),
        ],
      ),
    ];
  }

  // Italian Categories
  static List<FoodCategory> _getItalianCategories() {
    return [
      FoodCategory(
        name: 'Colazione',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Cappuccino', icon: '☕', description: 'Italian cappuccino', imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800'),
          FoodItem(name: 'Cornetto', icon: '🥐', description: 'Italian croissant', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Biscotti', icon: '🍪', description: 'Italian cookies', imageUrl: 'https://images.unsplash.com/photo-1571506165871-ee72a35f85bb?w=800'),
          FoodItem(name: 'Frittata', icon: '🍳', description: 'Italian omelet', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Pane', icon: '🥖', description: 'Italian bread', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Yogurt', icon: '🥛', description: 'Italian yogurt', imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Pranzo',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Pasta carbonara', icon: '🍝', description: 'Carbonara pasta', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800'),
          FoodItem(name: 'Lasagna', icon: '🍝', description: 'Italian lasagna', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800'),
          FoodItem(name: 'Risotto', icon: '🍚', description: 'Italian risotto', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'Insalata caprese', icon: '🥗', description: 'Caprese salad', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          FoodItem(name: 'Minestrone', icon: '🍲', description: 'Vegetable soup', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'Panini', icon: '🥪', description: 'Italian sandwich', imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Cena',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Pizza margherita', icon: '🍕', description: 'Margherita pizza', imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800'),
          FoodItem(name: 'Osso buco', icon: '🍖', description: 'Braised veal shanks', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Saltimbocca', icon: '🥩', description: 'Veal with prosciutto', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'Pollo alla cacciatora', icon: '🍗', description: 'Hunter\'s chicken', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'Pesce', icon: '🐟', description: 'Grilled fish', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
          FoodItem(name: 'Bistecca', icon: '🥩', description: 'Italian steak', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Caffè',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Espresso', icon: '☕', description: 'Italian espresso', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Tiramisu', icon: '🍰', description: 'Italian tiramisu', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: 'Gelato', icon: '🍨', description: 'Italian ice cream', imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
          FoodItem(name: 'Cannoli', icon: '🥐', description: 'Sicilian pastry', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Panna cotta', icon: '🍮', description: 'Cooked cream', imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
          FoodItem(name: 'Affogato', icon: '☕', description: 'Espresso with gelato', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
        ],
      ),
    ];
  }

  // Indian Categories
  static List<FoodCategory> _getIndianCategories() {
    return [
      FoodCategory(
        name: 'Breakfast',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Idli', icon: '🥣', description: 'Steamed rice cakes', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'Dosa', icon: '🥞', description: 'Rice crepe', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Paratha', icon: '🥖', description: 'Stuffed flatbread', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Poha', icon: '🍚', description: 'Flattened rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'Upma', icon: '🥣', description: 'Semolina porridge', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
          FoodItem(name: 'Samosa', icon: '🥟', description: 'Fried pastry', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Biryani', icon: '🍛', description: 'Spiced rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'Dal', icon: '🍲', description: 'Lentil curry', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
          FoodItem(name: 'Roti', icon: '🥖', description: 'Flatbread', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Paneer tikka', icon: '🧀', description: 'Grilled cottage cheese', imageUrl: 'https://images.unsplash.com/photo-1543826173-1beac6ea4909?w=800'),
          FoodItem(name: 'Chole bhature', icon: '🥖', description: 'Chickpeas with fried bread', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Thali', icon: '🍽️', description: 'Mixed platter', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Butter chicken', icon: '🍗', description: 'Chicken in tomato sauce', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'Tandoori chicken', icon: '🍗', description: 'Grilled chicken', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'Palak paneer', icon: '🥬', description: 'Spinach with cottage cheese', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          FoodItem(name: 'Korma', icon: '🍛', description: 'Creamy curry', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'Naan', icon: '🥖', description: 'Leavened flatbread', imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800'),
          FoodItem(name: 'Vindaloo', icon: '🍲', description: 'Spicy curry', imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Masala chai', icon: '☕', description: 'Spiced tea', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Lassi', icon: '🥤', description: 'Yogurt drink', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
          FoodItem(name: 'Gulab jamun', icon: '🍡', description: 'Sweet dumplings', imageUrl: 'https://images.unsplash.com/photo-1625944230945-1b7dd3b949ab?w=800'),
          FoodItem(name: 'Jalebi', icon: '🥨', description: 'Sweet pretzel', imageUrl: 'https://images.unsplash.com/photo-1486335370777-73dfe63fe1c4?w=800'),
          FoodItem(name: 'Kheer', icon: '🍮', description: 'Rice pudding', imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
          FoodItem(name: 'Barfi', icon: '🍫', description: 'Milk fudge', imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800'),
        ],
      ),
    ];
  }

  // British Categories
  static List<FoodCategory> _getBritishCategories() {
    return [
      FoodCategory(
        name: 'Breakfast',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Full English', icon: '🍳', description: 'Full English breakfast', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Beans on toast', icon: '🍞', description: 'Baked beans on toast', imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=800'),
          FoodItem(name: 'Porridge', icon: '🥣', description: 'Oatmeal porridge', imageUrl: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?w=800'),
          FoodItem(name: 'Bacon butty', icon: '🥪', description: 'Bacon sandwich', imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=800'),
          FoodItem(name: 'Kippers', icon: '🐟', description: 'Smoked herring', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
          FoodItem(name: 'Tea', icon: '🍵', description: 'English breakfast tea', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Fish and chips', icon: '🐟', description: 'Fried fish with chips', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
          FoodItem(name: 'Ploughman\'s', icon: '🧀', description: 'Cheese and bread platter', imageUrl: 'https://images.unsplash.com/photo-1543826173-1beac6ea4909?w=800'),
          FoodItem(name: 'Jacket potato', icon: '🥔', description: 'Baked potato', imageUrl: 'https://images.unsplash.com/photo-1518013431117-eb1465fa5752?w=800'),
          FoodItem(name: 'Scotch egg', icon: '🥚', description: 'Sausage-wrapped egg', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Sausage roll', icon: '🌭', description: 'Pastry-wrapped sausage', imageUrl: 'https://images.unsplash.com/photo-1612392062422-ef19b42f74df?w=800'),
          FoodItem(name: 'Sandwich', icon: '🥪', description: 'British sandwich', imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Roast dinner', icon: '🍖', description: 'Sunday roast', imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800'),
          FoodItem(name: 'Shepherd\'s pie', icon: '🥧', description: 'Meat and potato pie', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Bangers and mash', icon: '🌭', description: 'Sausages with mashed potato', imageUrl: 'https://images.unsplash.com/photo-1612392062422-ef19b42f74df?w=800'),
          FoodItem(name: 'Toad in the hole', icon: '🌭', description: 'Sausages in Yorkshire pudding', imageUrl: 'https://images.unsplash.com/photo-1612392062422-ef19b42f74df?w=800'),
          FoodItem(name: 'Cottage pie', icon: '🥧', description: 'Beef and potato pie', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Steak and kidney pie', icon: '🥧', description: 'Meat pie', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Tea Time',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Tea', icon: '🍵', description: 'British tea', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
          FoodItem(name: 'Scones', icon: '🥐', description: 'Scones with jam', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Victoria sponge', icon: '🍰', description: 'Sponge cake', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: 'Crumpets', icon: '🥞', description: 'Griddle cakes', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Biscuits', icon: '🍪', description: 'British cookies', imageUrl: 'https://images.unsplash.com/photo-1571506165871-ee72a35f85bb?w=800'),
          FoodItem(name: 'Trifle', icon: '🍮', description: 'Layered dessert', imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800'),
        ],
      ),
    ];
  }

  // International/Default Categories
  static List<FoodCategory> _getInternationalCategories() {
    return [
      FoodCategory(
        name: 'Breakfast',
        icon: '🌅',
        color: const Color(0xFFFFB74D),
        items: [
          FoodItem(name: 'Pancakes', icon: '🥞', description: 'Fluffy pancakes', imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800'),
          FoodItem(name: 'Toast', icon: '🍞', description: 'Buttered toast', imageUrl: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=800'),
          FoodItem(name: 'Eggs', icon: '🍳', description: 'Fried eggs', imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800'),
          FoodItem(name: 'Cereal', icon: '🥣', description: 'Breakfast cereal', imageUrl: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?w=800'),
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Butter croissant', imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800'),
          FoodItem(name: 'Fruit', icon: '🍓', description: 'Fresh fruit', imageUrl: 'https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Sandwich', icon: '🥪', description: 'Club sandwich', imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=800'),
          FoodItem(name: 'Salad', icon: '🥗', description: 'Fresh salad', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          FoodItem(name: 'Pizza', icon: '🍕', description: 'Cheese pizza', imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800'),
          FoodItem(name: 'Burger', icon: '🍔', description: 'Hamburger', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800'),
          FoodItem(name: 'Pasta', icon: '🍝', description: 'Pasta dish', imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800'),
          FoodItem(name: 'Soup', icon: '🍲', description: 'Hot soup', imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Steak', icon: '🥩', description: 'Grilled steak', imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800'),
          FoodItem(name: 'Chicken', icon: '🍗', description: 'Roast chicken', imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=800'),
          FoodItem(name: 'Fish', icon: '🐟', description: 'Grilled fish', imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800'),
          FoodItem(name: 'Rice', icon: '🍚', description: 'Steamed rice', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
          FoodItem(name: 'Vegetables', icon: '🥦', description: 'Mixed vegetables', imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800'),
          FoodItem(name: 'Curry', icon: '🍛', description: 'Curry dish', imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Coffee', icon: '☕', description: 'Hot coffee', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800'),
          FoodItem(name: 'Tea', icon: '🍵', description: 'Hot tea', imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800'),
          FoodItem(name: 'Cake', icon: '🍰', description: 'Slice of cake', imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=800'),
          FoodItem(name: 'Cookie', icon: '🍪', description: 'Chocolate chip cookie', imageUrl: 'https://images.unsplash.com/photo-1571506165871-ee72a35f85bb?w=800'),
          FoodItem(name: 'Smoothie', icon: '🥤', description: 'Fruit smoothie', imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800'),
          FoodItem(name: 'Muffin', icon: '🧁', description: 'Blueberry muffin', imageUrl: 'https://images.unsplash.com/photo-1587668178277-295251f900ce?w=800'),
        ],
      ),
    ];
  }
}
