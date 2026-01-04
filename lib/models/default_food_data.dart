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
          FoodItem(name: 'Bánh Mì', icon: '🥖', description: 'Bánh mì Việt Nam'),
          FoodItem(name: 'Phở', icon: '🍜', description: 'Phở bò tái'),
          FoodItem(name: 'Xôi', icon: '🍙', description: 'Xôi xéo'),
          FoodItem(name: 'Cháo', icon: '🥣', description: 'Cháo gà'),
          FoodItem(name: 'Bún Bò', icon: '🍜', description: 'Bún bò Huế'),
          FoodItem(name: 'Hủ Tiếu', icon: '🍜', description: 'Hủ tiếu Nam Vang'),
        ],
      ),
      FoodCategory(
        name: 'Trưa',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Cơm Tấm', icon: '🍚', description: 'Cơm tấm sườn bì'),
          FoodItem(name: 'Bún Bò', icon: '🍜', description: 'Bún bò Huế'),
          FoodItem(name: 'Mì Quảng', icon: '🍜', description: 'Mì Quảng tôm thịt'),
          FoodItem(name: 'Cơm Rang', icon: '🍛', description: 'Cơm rang dương châu'),
          FoodItem(name: 'Bún Chả', icon: '🍢', description: 'Bún chả Hà Nội'),
          FoodItem(name: 'Phở', icon: '🍜', description: 'Phở bò tái'),
        ],
      ),
      FoodCategory(
        name: 'Tối',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Lẩu', icon: '🍲', description: 'Lẩu Thái'),
          FoodItem(name: 'Nướng', icon: '🥩', description: 'Thịt nướng BBQ'),
          FoodItem(name: 'Gà Rán', icon: '🍗', description: 'Gà rán giòn'),
          FoodItem(name: 'Pizza', icon: '🍕', description: 'Pizza Hải Sản'),
          FoodItem(name: 'Burger', icon: '🍔', description: 'Burger bò phô mai'),
          FoodItem(name: 'Mì Ý', icon: '🍝', description: 'Mì Ý sốt bò băm'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Cà Phê', icon: '☕', description: 'Cà phê đen đá'),
          FoodItem(name: 'Trà Sữa', icon: '🧋', description: 'Trà sữa trân châu'),
          FoodItem(name: 'Bánh Ngọt', icon: '🧁', description: 'Bánh cupcake'),
          FoodItem(name: 'Smoothie', icon: '🥤', description: 'Smoothie dâu'),
          FoodItem(name: 'Bánh Croissant', icon: '🥐', description: 'Croissant bơ'),
          FoodItem(name: 'Trà Trái Cây', icon: '🍹', description: 'Trà đào cam sả'),
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
          FoodItem(name: 'Pancakes', icon: '🥞', description: 'Fluffy pancakes with syrup'),
          FoodItem(name: 'Waffles', icon: '🧇', description: 'Belgian waffles'),
          FoodItem(name: 'Eggs & Bacon', icon: '🍳', description: 'Scrambled eggs with bacon'),
          FoodItem(name: 'Bagel', icon: '🥯', description: 'Bagel with cream cheese'),
          FoodItem(name: 'Oatmeal', icon: '🥣', description: 'Oatmeal with fruits'),
          FoodItem(name: 'French Toast', icon: '🍞', description: 'Cinnamon french toast'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Burger', icon: '🍔', description: 'Classic cheeseburger'),
          FoodItem(name: 'Pizza', icon: '🍕', description: 'Pepperoni pizza'),
          FoodItem(name: 'Sandwich', icon: '🥪', description: 'Club sandwich'),
          FoodItem(name: 'Tacos', icon: '🌮', description: 'Beef tacos'),
          FoodItem(name: 'Hot Dog', icon: '🌭', description: 'Chicago hot dog'),
          FoodItem(name: 'Salad', icon: '🥗', description: 'Caesar salad'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Steak', icon: '🥩', description: 'Grilled ribeye steak'),
          FoodItem(name: 'BBQ Ribs', icon: '🍖', description: 'BBQ pork ribs'),
          FoodItem(name: 'Fried Chicken', icon: '🍗', description: 'Southern fried chicken'),
          FoodItem(name: 'Mac & Cheese', icon: '🧀', description: 'Macaroni and cheese'),
          FoodItem(name: 'Lobster', icon: '🦞', description: 'Steamed lobster'),
          FoodItem(name: 'Pasta', icon: '🍝', description: 'Spaghetti with meatballs'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Coffee', icon: '☕', description: 'Americano'),
          FoodItem(name: 'Latte', icon: '☕', description: 'Caffe latte'),
          FoodItem(name: 'Donut', icon: '🍩', description: 'Glazed donut'),
          FoodItem(name: 'Muffin', icon: '🧁', description: 'Blueberry muffin'),
          FoodItem(name: 'Smoothie', icon: '🥤', description: 'Berry smoothie'),
          FoodItem(name: 'Brownie', icon: '🍫', description: 'Chocolate brownie'),
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
          FoodItem(name: '納豆ご飯', icon: '🍚', description: 'Natto rice'),
          FoodItem(name: '味噌汁', icon: '🍲', description: 'Miso soup'),
          FoodItem(name: '焼き魚', icon: '🐟', description: 'Grilled fish'),
          FoodItem(name: '卵焼き', icon: '🍳', description: 'Tamagoyaki'),
          FoodItem(name: 'おにぎり', icon: '🍙', description: 'Rice ball'),
          FoodItem(name: 'お粥', icon: '🥣', description: 'Rice porridge'),
        ],
      ),
      FoodCategory(
        name: '昼食',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'ラーメン', icon: '🍜', description: 'Ramen'),
          FoodItem(name: '寿司', icon: '🍣', description: 'Sushi'),
          FoodItem(name: 'うどん', icon: '🍜', description: 'Udon noodles'),
          FoodItem(name: '天丼', icon: '🍱', description: 'Tempura rice bowl'),
          FoodItem(name: 'カレーライス', icon: '🍛', description: 'Curry rice'),
          FoodItem(name: 'そば', icon: '🍜', description: 'Soba noodles'),
        ],
      ),
      FoodCategory(
        name: '夕食',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: '焼肉', icon: '🥩', description: 'Yakiniku'),
          FoodItem(name: 'すき焼き', icon: '🍲', description: 'Sukiyaki'),
          FoodItem(name: 'とんかつ', icon: '🍖', description: 'Tonkatsu'),
          FoodItem(name: 'お好み焼き', icon: '🥞', description: 'Okonomiyaki'),
          FoodItem(name: '刺身', icon: '🍣', description: 'Sashimi'),
          FoodItem(name: '天ぷら', icon: '🍤', description: 'Tempura'),
        ],
      ),
      FoodCategory(
        name: 'カフェ',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: '抹茶ラテ', icon: '🍵', description: 'Matcha latte'),
          FoodItem(name: 'コーヒー', icon: '☕', description: 'Coffee'),
          FoodItem(name: 'だんご', icon: '🍡', description: 'Dango'),
          FoodItem(name: 'どら焼き', icon: '🥞', description: 'Dorayaki'),
          FoodItem(name: 'タピオカ', icon: '🧋', description: 'Bubble tea'),
          FoodItem(name: 'パンケーキ', icon: '🥞', description: 'Pancake'),
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
          FoodItem(name: '김치찌개', icon: '🍲', description: 'Kimchi stew'),
          FoodItem(name: '된장찌개', icon: '🍲', description: 'Soybean paste stew'),
          FoodItem(name: '계란말이', icon: '🍳', description: 'Egg roll'),
          FoodItem(name: '죽', icon: '🥣', description: 'Porridge'),
          FoodItem(name: '김밥', icon: '🍙', description: 'Kimbap'),
          FoodItem(name: '토스트', icon: '🍞', description: 'Korean toast'),
        ],
      ),
      FoodCategory(
        name: '점심',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: '비빔밥', icon: '🍚', description: 'Bibimbap'),
          FoodItem(name: '냉면', icon: '🍜', description: 'Cold noodles'),
          FoodItem(name: '불고기', icon: '🥩', description: 'Bulgogi'),
          FoodItem(name: '삼겹살', icon: '🥓', description: 'Pork belly'),
          FoodItem(name: '짜장면', icon: '🍜', description: 'Jjajangmyeon'),
          FoodItem(name: '김치볶음밥', icon: '🍛', description: 'Kimchi fried rice'),
        ],
      ),
      FoodCategory(
        name: '저녁',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: '삼계탕', icon: '🍲', description: 'Ginseng chicken soup'),
          FoodItem(name: '갈비찜', icon: '🍖', description: 'Braised short ribs'),
          FoodItem(name: '치킨', icon: '🍗', description: 'Korean fried chicken'),
          FoodItem(name: '떡볶이', icon: '🍢', description: 'Tteokbokki'),
          FoodItem(name: '부대찌개', icon: '🍲', description: 'Army stew'),
          FoodItem(name: '곱창', icon: '🥩', description: 'Grilled intestines'),
        ],
      ),
      FoodCategory(
        name: '카페',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: '아메리카노', icon: '☕', description: 'Americano'),
          FoodItem(name: '라떼', icon: '☕', description: 'Latte'),
          FoodItem(name: '빙수', icon: '🍧', description: 'Bingsu'),
          FoodItem(name: '케이크', icon: '🍰', description: 'Cake'),
          FoodItem(name: '버블티', icon: '🧋', description: 'Bubble tea'),
          FoodItem(name: '마카롱', icon: '🍪', description: 'Macaron'),
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
          FoodItem(name: '包子', icon: '🥟', description: 'Steamed buns'),
          FoodItem(name: '油条', icon: '🥖', description: 'Fried dough stick'),
          FoodItem(name: '豆浆', icon: '🥤', description: 'Soy milk'),
          FoodItem(name: '粥', icon: '🥣', description: 'Congee'),
          FoodItem(name: '煎饼', icon: '🥞', description: 'Jianbing'),
          FoodItem(name: '小笼包', icon: '🥟', description: 'Soup dumplings'),
        ],
      ),
      FoodCategory(
        name: '午餐',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: '炒饭', icon: '🍛', description: 'Fried rice'),
          FoodItem(name: '面条', icon: '🍜', description: 'Noodles'),
          FoodItem(name: '饺子', icon: '🥟', description: 'Dumplings'),
          FoodItem(name: '盖浇饭', icon: '🍚', description: 'Rice with toppings'),
          FoodItem(name: '麻辣烫', icon: '🍲', description: 'Spicy hot pot'),
          FoodItem(name: '煎饺', icon: '🥟', description: 'Pan-fried dumplings'),
        ],
      ),
      FoodCategory(
        name: '晚餐',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: '火锅', icon: '🍲', description: 'Hot pot'),
          FoodItem(name: '烤鸭', icon: '🦆', description: 'Roast duck'),
          FoodItem(name: '烧烤', icon: '🥩', description: 'BBQ'),
          FoodItem(name: '糖醋里脊', icon: '🍖', description: 'Sweet & sour pork'),
          FoodItem(name: '宫保鸡丁', icon: '🍗', description: 'Kung Pao chicken'),
          FoodItem(name: '红烧肉', icon: '🥩', description: 'Braised pork belly'),
        ],
      ),
      FoodCategory(
        name: '咖啡',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: '奶茶', icon: '🧋', description: 'Milk tea'),
          FoodItem(name: '咖啡', icon: '☕', description: 'Coffee'),
          FoodItem(name: '蛋糕', icon: '🍰', description: 'Cake'),
          FoodItem(name: '泡芙', icon: '🧁', description: 'Cream puff'),
          FoodItem(name: '烧仙草', icon: '🥤', description: 'Grass jelly drink'),
          FoodItem(name: '水果茶', icon: '🍹', description: 'Fruit tea'),
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
          FoodItem(name: 'ข้าวต้ม', icon: '🥣', description: 'Rice soup'),
          FoodItem(name: 'โจ๊ก', icon: '🥣', description: 'Congee'),
          FoodItem(name: 'ปาท่องโก๋', icon: '🥖', description: 'Fried dough'),
          FoodItem(name: 'ก๋วยเตี๋ยว', icon: '🍜', description: 'Noodle soup'),
          FoodItem(name: 'ข้าวเหนียวหมูปิ้ง', icon: '🍙', description: 'Sticky rice with grilled pork'),
          FoodItem(name: 'ขนมปังสังขยา', icon: '🍞', description: 'Pandan custard toast'),
        ],
      ),
      FoodCategory(
        name: 'อาหารกลางวัน',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'ผัดไทย', icon: '🍜', description: 'Pad Thai'),
          FoodItem(name: 'ข้าวผัด', icon: '🍛', description: 'Fried rice'),
          FoodItem(name: 'ต้มยำกุ้ง', icon: '🍲', description: 'Tom Yum soup'),
          FoodItem(name: 'ส้มตำ', icon: '🥗', description: 'Papaya salad'),
          FoodItem(name: 'ข้าวมันไก่', icon: '🍚', description: 'Chicken rice'),
          FoodItem(name: 'แกงเขียวหวาน', icon: '🍲', description: 'Green curry'),
        ],
      ),
      FoodCategory(
        name: 'อาหารเย็น',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'หมูกระทะ', icon: '🍲', description: 'Thai BBQ'),
          FoodItem(name: 'ปลาเผา', icon: '🐟', description: 'Grilled fish'),
          FoodItem(name: 'หมูย่าง', icon: '🥩', description: 'Grilled pork'),
          FoodItem(name: 'ไก่ทอด', icon: '🍗', description: 'Fried chicken'),
          FoodItem(name: 'ข้าวหน้าเป็ด', icon: '🍚', description: 'Duck over rice'),
          FoodItem(name: 'ต้มข่าไก่', icon: '🍲', description: 'Tom Kha Gai'),
        ],
      ),
      FoodCategory(
        name: 'คาเฟ่',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'กาแฟเย็น', icon: '☕', description: 'Iced coffee'),
          FoodItem(name: 'ชาเย็น', icon: '🧋', description: 'Thai iced tea'),
          FoodItem(name: 'ข้าวเหนียวมะม่วง', icon: '🥭', description: 'Mango sticky rice'),
          FoodItem(name: 'โรตี', icon: '🥞', description: 'Roti'),
          FoodItem(name: 'ขนมปังหน้าหมู', icon: '🍞', description: 'Toast with pork floss'),
          FoodItem(name: 'ชาเขียว', icon: '🍵', description: 'Green tea'),
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
          FoodItem(name: 'Churros', icon: '🥖', description: 'Churros con chocolate'),
          FoodItem(name: 'Tostada', icon: '🍞', description: 'Pan con tomate'),
          FoodItem(name: 'Tortilla', icon: '🍳', description: 'Tortilla española'),
          FoodItem(name: 'Magdalenas', icon: '🧁', description: 'Muffins'),
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Croissant'),
          FoodItem(name: 'Café con leche', icon: '☕', description: 'Coffee with milk'),
        ],
      ),
      FoodCategory(
        name: 'Almuerzo',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Paella', icon: '🥘', description: 'Paella valenciana'),
          FoodItem(name: 'Tapas', icon: '🍢', description: 'Spanish tapas'),
          FoodItem(name: 'Jamón', icon: '🥓', description: 'Jamón ibérico'),
          FoodItem(name: 'Gazpacho', icon: '🥣', description: 'Cold tomato soup'),
          FoodItem(name: 'Croquetas', icon: '🥟', description: 'Spanish croquettes'),
          FoodItem(name: 'Ensalada', icon: '🥗', description: 'Spanish salad'),
        ],
      ),
      FoodCategory(
        name: 'Cena',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Fabada', icon: '🍲', description: 'Bean stew'),
          FoodItem(name: 'Pulpo', icon: '🐙', description: 'Pulpo a la gallega'),
          FoodItem(name: 'Pescado', icon: '🐟', description: 'Grilled fish'),
          FoodItem(name: 'Cocido', icon: '🍲', description: 'Spanish stew'),
          FoodItem(name: 'Albóndigas', icon: '🍖', description: 'Meatballs'),
          FoodItem(name: 'Solomillo', icon: '🥩', description: 'Pork tenderloin'),
        ],
      ),
      FoodCategory(
        name: 'Café',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Café', icon: '☕', description: 'Espresso'),
          FoodItem(name: 'Cortado', icon: '☕', description: 'Cortado'),
          FoodItem(name: 'Pastel', icon: '🍰', description: 'Cake'),
          FoodItem(name: 'Flan', icon: '🍮', description: 'Caramel custard'),
          FoodItem(name: 'Horchata', icon: '🥤', description: 'Horchata'),
          FoodItem(name: 'Tarta', icon: '🍰', description: 'Tart'),
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
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Butter croissant'),
          FoodItem(name: 'Pain au chocolat', icon: '🥐', description: 'Chocolate croissant'),
          FoodItem(name: 'Baguette', icon: '🥖', description: 'French baguette'),
          FoodItem(name: 'Café au lait', icon: '☕', description: 'Coffee with milk'),
          FoodItem(name: 'Omelette', icon: '🍳', description: 'French omelette'),
          FoodItem(name: 'Brioche', icon: '🥖', description: 'Sweet bread'),
        ],
      ),
      FoodCategory(
        name: 'Déjeuner',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Quiche', icon: '🥧', description: 'Quiche lorraine'),
          FoodItem(name: 'Croque monsieur', icon: '🥪', description: 'Grilled ham & cheese'),
          FoodItem(name: 'Salade niçoise', icon: '🥗', description: 'Nice salad'),
          FoodItem(name: 'Soupe à l\'oignon', icon: '🍲', description: 'French onion soup'),
          FoodItem(name: 'Steak frites', icon: '🥩', description: 'Steak with fries'),
          FoodItem(name: 'Ratatouille', icon: '🍲', description: 'Vegetable stew'),
        ],
      ),
      FoodCategory(
        name: 'Dîner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Coq au vin', icon: '🍗', description: 'Chicken in wine'),
          FoodItem(name: 'Bouillabaisse', icon: '🍲', description: 'Fish stew'),
          FoodItem(name: 'Boeuf bourguignon', icon: '🥩', description: 'Beef stew'),
          FoodItem(name: 'Confit de canard', icon: '🦆', description: 'Duck confit'),
          FoodItem(name: 'Cassoulet', icon: '🍲', description: 'Bean stew'),
          FoodItem(name: 'Escargots', icon: '🐌', description: 'Snails in garlic butter'),
        ],
      ),
      FoodCategory(
        name: 'Café',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Espresso', icon: '☕', description: 'French espresso'),
          FoodItem(name: 'Macaron', icon: '🍪', description: 'French macaron'),
          FoodItem(name: 'Éclair', icon: '🧁', description: 'Chocolate éclair'),
          FoodItem(name: 'Crêpe', icon: '🥞', description: 'French crêpe'),
          FoodItem(name: 'Tarte tatin', icon: '🥧', description: 'Apple tart'),
          FoodItem(name: 'Mousse', icon: '🍫', description: 'Chocolate mousse'),
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
          FoodItem(name: 'Brötchen', icon: '🥖', description: 'Bread rolls'),
          FoodItem(name: 'Wurst', icon: '🌭', description: 'German sausage'),
          FoodItem(name: 'Käse', icon: '🧀', description: 'German cheese'),
          FoodItem(name: 'Müsli', icon: '🥣', description: 'Muesli'),
          FoodItem(name: 'Rührei', icon: '🍳', description: 'Scrambled eggs'),
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Croissant'),
        ],
      ),
      FoodCategory(
        name: 'Mittagessen',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Currywurst', icon: '🌭', description: 'Curry sausage'),
          FoodItem(name: 'Schnitzel', icon: '🍖', description: 'Breaded cutlet'),
          FoodItem(name: 'Bratwurst', icon: '🌭', description: 'Grilled sausage'),
          FoodItem(name: 'Kartoffelsalat', icon: '🥗', description: 'Potato salad'),
          FoodItem(name: 'Döner', icon: '🥙', description: 'Doner kebab'),
          FoodItem(name: 'Bratkartoffeln', icon: '🥔', description: 'Fried potatoes'),
        ],
      ),
      FoodCategory(
        name: 'Abendessen',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Sauerbraten', icon: '🥩', description: 'Pot roast'),
          FoodItem(name: 'Schweinshaxe', icon: '🍖', description: 'Pork knuckle'),
          FoodItem(name: 'Rouladen', icon: '🥩', description: 'Beef rolls'),
          FoodItem(name: 'Spätzle', icon: '🍝', description: 'German noodles'),
          FoodItem(name: 'Eintopf', icon: '🍲', description: 'German stew'),
          FoodItem(name: 'Fisch', icon: '🐟', description: 'Fish'),
        ],
      ),
      FoodCategory(
        name: 'Café',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Kaffee', icon: '☕', description: 'German coffee'),
          FoodItem(name: 'Kuchen', icon: '🍰', description: 'Cake'),
          FoodItem(name: 'Schwarzwälder Kirschtorte', icon: '🍰', description: 'Black forest cake'),
          FoodItem(name: 'Apfelstrudel', icon: '🥧', description: 'Apple strudel'),
          FoodItem(name: 'Brezeln', icon: '🥨', description: 'Pretzels'),
          FoodItem(name: 'Sachertorte', icon: '🍫', description: 'Chocolate cake'),
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
          FoodItem(name: 'Cappuccino', icon: '☕', description: 'Italian cappuccino'),
          FoodItem(name: 'Cornetto', icon: '🥐', description: 'Italian croissant'),
          FoodItem(name: 'Biscotti', icon: '🍪', description: 'Italian cookies'),
          FoodItem(name: 'Frittata', icon: '🍳', description: 'Italian omelet'),
          FoodItem(name: 'Pane', icon: '🥖', description: 'Italian bread'),
          FoodItem(name: 'Yogurt', icon: '🥛', description: 'Italian yogurt'),
        ],
      ),
      FoodCategory(
        name: 'Pranzo',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Pasta carbonara', icon: '🍝', description: 'Carbonara pasta'),
          FoodItem(name: 'Lasagna', icon: '🍝', description: 'Italian lasagna'),
          FoodItem(name: 'Risotto', icon: '🍚', description: 'Italian risotto'),
          FoodItem(name: 'Insalata caprese', icon: '🥗', description: 'Caprese salad'),
          FoodItem(name: 'Minestrone', icon: '🍲', description: 'Vegetable soup'),
          FoodItem(name: 'Panini', icon: '🥪', description: 'Italian sandwich'),
        ],
      ),
      FoodCategory(
        name: 'Cena',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Pizza margherita', icon: '🍕', description: 'Margherita pizza'),
          FoodItem(name: 'Osso buco', icon: '🍖', description: 'Braised veal shanks'),
          FoodItem(name: 'Saltimbocca', icon: '🥩', description: 'Veal with prosciutto'),
          FoodItem(name: 'Pollo alla cacciatora', icon: '🍗', description: 'Hunter\'s chicken'),
          FoodItem(name: 'Pesce', icon: '🐟', description: 'Grilled fish'),
          FoodItem(name: 'Bistecca', icon: '🥩', description: 'Italian steak'),
        ],
      ),
      FoodCategory(
        name: 'Caffè',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Espresso', icon: '☕', description: 'Italian espresso'),
          FoodItem(name: 'Tiramisu', icon: '🍰', description: 'Italian tiramisu'),
          FoodItem(name: 'Gelato', icon: '🍨', description: 'Italian ice cream'),
          FoodItem(name: 'Cannoli', icon: '🥐', description: 'Sicilian pastry'),
          FoodItem(name: 'Panna cotta', icon: '🍮', description: 'Cooked cream'),
          FoodItem(name: 'Affogato', icon: '☕', description: 'Espresso with gelato'),
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
          FoodItem(name: 'Idli', icon: '🥣', description: 'Steamed rice cakes'),
          FoodItem(name: 'Dosa', icon: '🥞', description: 'Rice crepe'),
          FoodItem(name: 'Paratha', icon: '🥖', description: 'Stuffed flatbread'),
          FoodItem(name: 'Poha', icon: '🍚', description: 'Flattened rice'),
          FoodItem(name: 'Upma', icon: '🥣', description: 'Semolina porridge'),
          FoodItem(name: 'Samosa', icon: '🥟', description: 'Fried pastry'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Biryani', icon: '🍛', description: 'Spiced rice'),
          FoodItem(name: 'Dal', icon: '🍲', description: 'Lentil curry'),
          FoodItem(name: 'Roti', icon: '🥖', description: 'Flatbread'),
          FoodItem(name: 'Paneer tikka', icon: '🧀', description: 'Grilled cottage cheese'),
          FoodItem(name: 'Chole bhature', icon: '🥖', description: 'Chickpeas with fried bread'),
          FoodItem(name: 'Thali', icon: '🍽️', description: 'Mixed platter'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Butter chicken', icon: '🍗', description: 'Chicken in tomato sauce'),
          FoodItem(name: 'Tandoori chicken', icon: '🍗', description: 'Grilled chicken'),
          FoodItem(name: 'Palak paneer', icon: '🥬', description: 'Spinach with cottage cheese'),
          FoodItem(name: 'Korma', icon: '🍛', description: 'Creamy curry'),
          FoodItem(name: 'Naan', icon: '🥖', description: 'Leavened flatbread'),
          FoodItem(name: 'Vindaloo', icon: '🍲', description: 'Spicy curry'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Masala chai', icon: '☕', description: 'Spiced tea'),
          FoodItem(name: 'Lassi', icon: '🥤', description: 'Yogurt drink'),
          FoodItem(name: 'Gulab jamun', icon: '🍡', description: 'Sweet dumplings'),
          FoodItem(name: 'Jalebi', icon: '🥨', description: 'Sweet pretzel'),
          FoodItem(name: 'Kheer', icon: '🍮', description: 'Rice pudding'),
          FoodItem(name: 'Barfi', icon: '🍫', description: 'Milk fudge'),
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
          FoodItem(name: 'Full English', icon: '🍳', description: 'Full English breakfast'),
          FoodItem(name: 'Beans on toast', icon: '🍞', description: 'Baked beans on toast'),
          FoodItem(name: 'Porridge', icon: '🥣', description: 'Oatmeal porridge'),
          FoodItem(name: 'Bacon butty', icon: '🥪', description: 'Bacon sandwich'),
          FoodItem(name: 'Kippers', icon: '🐟', description: 'Smoked herring'),
          FoodItem(name: 'Tea', icon: '🍵', description: 'English breakfast tea'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Fish and chips', icon: '🐟', description: 'Fried fish with chips'),
          FoodItem(name: 'Ploughman\'s', icon: '🧀', description: 'Cheese and bread platter'),
          FoodItem(name: 'Jacket potato', icon: '🥔', description: 'Baked potato'),
          FoodItem(name: 'Scotch egg', icon: '🥚', description: 'Sausage-wrapped egg'),
          FoodItem(name: 'Sausage roll', icon: '🌭', description: 'Pastry-wrapped sausage'),
          FoodItem(name: 'Sandwich', icon: '🥪', description: 'British sandwich'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Roast dinner', icon: '🍖', description: 'Sunday roast'),
          FoodItem(name: 'Shepherd\'s pie', icon: '🥧', description: 'Meat and potato pie'),
          FoodItem(name: 'Bangers and mash', icon: '🌭', description: 'Sausages with mashed potato'),
          FoodItem(name: 'Toad in the hole', icon: '🌭', description: 'Sausages in Yorkshire pudding'),
          FoodItem(name: 'Cottage pie', icon: '🥧', description: 'Beef and potato pie'),
          FoodItem(name: 'Steak and kidney pie', icon: '🥧', description: 'Meat pie'),
        ],
      ),
      FoodCategory(
        name: 'Tea Time',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Tea', icon: '🍵', description: 'British tea'),
          FoodItem(name: 'Scones', icon: '🥐', description: 'Scones with jam'),
          FoodItem(name: 'Victoria sponge', icon: '🍰', description: 'Sponge cake'),
          FoodItem(name: 'Crumpets', icon: '🥞', description: 'Griddle cakes'),
          FoodItem(name: 'Biscuits', icon: '🍪', description: 'British cookies'),
          FoodItem(name: 'Trifle', icon: '🍮', description: 'Layered dessert'),
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
          FoodItem(name: 'Pancakes', icon: '🥞', description: 'Fluffy pancakes'),
          FoodItem(name: 'Toast', icon: '🍞', description: 'Buttered toast'),
          FoodItem(name: 'Eggs', icon: '🍳', description: 'Fried eggs'),
          FoodItem(name: 'Cereal', icon: '🥣', description: 'Breakfast cereal'),
          FoodItem(name: 'Croissant', icon: '🥐', description: 'Butter croissant'),
          FoodItem(name: 'Fruit', icon: '🍓', description: 'Fresh fruit'),
        ],
      ),
      FoodCategory(
        name: 'Lunch',
        icon: '☀️',
        color: const Color(0xFFEF5350),
        items: [
          FoodItem(name: 'Sandwich', icon: '🥪', description: 'Club sandwich'),
          FoodItem(name: 'Salad', icon: '🥗', description: 'Fresh salad'),
          FoodItem(name: 'Pizza', icon: '🍕', description: 'Cheese pizza'),
          FoodItem(name: 'Burger', icon: '🍔', description: 'Hamburger'),
          FoodItem(name: 'Pasta', icon: '🍝', description: 'Pasta dish'),
          FoodItem(name: 'Soup', icon: '🍲', description: 'Hot soup'),
        ],
      ),
      FoodCategory(
        name: 'Dinner',
        icon: '🌙',
        color: const Color(0xFF5C6BC0),
        items: [
          FoodItem(name: 'Steak', icon: '🥩', description: 'Grilled steak'),
          FoodItem(name: 'Chicken', icon: '🍗', description: 'Roast chicken'),
          FoodItem(name: 'Fish', icon: '🐟', description: 'Grilled fish'),
          FoodItem(name: 'Rice', icon: '🍚', description: 'Steamed rice'),
          FoodItem(name: 'Vegetables', icon: '🥦', description: 'Mixed vegetables'),
          FoodItem(name: 'Curry', icon: '🍛', description: 'Curry dish'),
        ],
      ),
      FoodCategory(
        name: 'Cafe',
        icon: '☕',
        color: const Color(0xFF8D6E63),
        items: [
          FoodItem(name: 'Coffee', icon: '☕', description: 'Hot coffee'),
          FoodItem(name: 'Tea', icon: '🍵', description: 'Hot tea'),
          FoodItem(name: 'Cake', icon: '🍰', description: 'Slice of cake'),
          FoodItem(name: 'Cookie', icon: '🍪', description: 'Chocolate chip cookie'),
          FoodItem(name: 'Smoothie', icon: '🥤', description: 'Fruit smoothie'),
          FoodItem(name: 'Muffin', icon: '🧁', description: 'Blueberry muffin'),
        ],
      ),
    ];
  }
}
