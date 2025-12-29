import 'package:flutter/material.dart';

class FoodDeliveryPlatform {
  final String name;
  final String appScheme;
  final String webUrl;
  final Color color;
  final IconData icon;

  const FoodDeliveryPlatform({
    required this.name,
    required this.appScheme,
    required this.webUrl,
    required this.color,
    required this.icon,
  });

  String getSearchUrl(String keyword) {
    return webUrl.replaceAll('{keyword}', Uri.encodeComponent(keyword));
  }

  Uri getAppUri(String keyword) {
    return Uri.parse(appScheme.replaceAll('{keyword}', Uri.encodeComponent(keyword)));
  }
}

class FoodDeliveryConfig {
  // Vietnam
  static const shopeeFood = FoodDeliveryPlatform(
    name: 'ShopeeFood',
    appScheme: 'shopeefood://search?keyword={keyword}',
    webUrl: 'https://shopeefood.vn/search?keyword={keyword}',
    color: Color(0xFFEE4D2D),
    icon: Icons.shopping_bag,
  );

  static const grabFood = FoodDeliveryPlatform(
    name: 'GrabFood',
    appScheme: 'grab://food?screen=search&keyword={keyword}',
    webUrl: 'https://food.grab.com/vn/vi/search?keyword={keyword}',
    color: Color(0xFF00B14F),
    icon: Icons.two_wheeler,
  );

  static const now = FoodDeliveryPlatform(
    name: 'Now',
    appScheme: 'now://search?keyword={keyword}',
    webUrl: 'https://www.now.vn/search?keyword={keyword}',
    color: Color(0xFFFF6347),
    icon: Icons.restaurant,
  );

  // USA
  static const uberEats = FoodDeliveryPlatform(
    name: 'Uber Eats',
    appScheme: 'ubereats://search?q={keyword}',
    webUrl: 'https://www.ubereats.com/search?q={keyword}',
    color: Color(0xFF06C167),
    icon: Icons.delivery_dining,
  );

  static const doorDash = FoodDeliveryPlatform(
    name: 'DoorDash',
    appScheme: 'doordash://search?query={keyword}',
    webUrl: 'https://www.doordash.com/search/?query={keyword}',
    color: Color(0xFFFF3008),
    icon: Icons.local_shipping,
  );

  static const grubhub = FoodDeliveryPlatform(
    name: 'Grubhub',
    appScheme: 'grubhub://search?q={keyword}',
    webUrl: 'https://www.grubhub.com/search?q={keyword}',
    color: Color(0xFFFF8000),
    icon: Icons.fastfood,
  );

  // UK & Europe
  static const justEat = FoodDeliveryPlatform(
    name: 'Just Eat',
    appScheme: 'justeat://search?q={keyword}',
    webUrl: 'https://www.just-eat.co.uk/search?q={keyword}',
    color: Color(0xFFFF8000),
    icon: Icons.restaurant_menu,
  );

  static const deliveroo = FoodDeliveryPlatform(
    name: 'Deliveroo',
    appScheme: 'deliveroo://search?query={keyword}',
    webUrl: 'https://deliveroo.co.uk/search?query={keyword}',
    color: Color(0xFF00CCBC),
    icon: Icons.pedal_bike,
  );

  // Singapore & Southeast Asia
  static const foodpanda = FoodDeliveryPlatform(
    name: 'foodpanda',
    appScheme: 'foodpanda://search?q={keyword}',
    webUrl: 'https://www.foodpanda.sg/search?q={keyword}',
    color: Color(0xFFE21B70),
    icon: Icons.delivery_dining,
  );

  // Korea
  static const baeminKR = FoodDeliveryPlatform(
    name: '배달의민족',
    appScheme: 'baemin://search?keyword={keyword}',
    webUrl: 'https://www.baemin.com/search?keyword={keyword}',
    color: Color(0xFF2AC1BC),
    icon: Icons.restaurant,
  );

  static const coupangEats = FoodDeliveryPlatform(
    name: 'Coupang Eats',
    appScheme: 'coupangeats://search?keyword={keyword}',
    webUrl: 'https://www.coupangeats.com/search?keyword={keyword}',
    color: Color(0xFF5F0080),
    icon: Icons.shopping_cart,
  );

  // Japan
  static const uberEatsJP = FoodDeliveryPlatform(
    name: 'Uber Eats',
    appScheme: 'ubereats://search?q={keyword}',
    webUrl: 'https://www.ubereats.com/jp/search?q={keyword}',
    color: Color(0xFF06C167),
    icon: Icons.delivery_dining,
  );

  static const demaecan = FoodDeliveryPlatform(
    name: '出前館',
    appScheme: 'demaecan://search?keyword={keyword}',
    webUrl: 'https://demae-can.com/search?keyword={keyword}',
    color: Color(0xFFFF6600),
    icon: Icons.restaurant,
  );

  // Australia
  static const menulog = FoodDeliveryPlatform(
    name: 'Menulog',
    appScheme: 'menulog://search?q={keyword}',
    webUrl: 'https://www.menulog.com.au/search?q={keyword}',
    color: Color(0xFFFF6600),
    icon: Icons.fastfood,
  );

  // India
  static const swiggy = FoodDeliveryPlatform(
    name: 'Swiggy',
    appScheme: 'swiggy://search?q={keyword}',
    webUrl: 'https://www.swiggy.com/search?q={keyword}',
    color: Color(0xFFFC8019),
    icon: Icons.restaurant_menu,
  );

  static const zomato = FoodDeliveryPlatform(
    name: 'Zomato',
    appScheme: 'zomato://search?q={keyword}',
    webUrl: 'https://www.zomato.com/search?q={keyword}',
    color: Color(0xFFE23744),
    icon: Icons.local_dining,
  );

  // China
  static const meituan = FoodDeliveryPlatform(
    name: '美团外卖',
    appScheme: 'imeituan://www.meituan.com/search?keyword={keyword}',
    webUrl: 'https://waimai.meituan.com/search?keyword={keyword}',
    color: Color(0xFFFFC300),
    icon: Icons.fastfood,
  );

  static const eleme = FoodDeliveryPlatform(
    name: '饿了么',
    appScheme: 'eleme://search?keyword={keyword}',
    webUrl: 'https://www.ele.me/search?keyword={keyword}',
    color: Color(0xFF0089FF),
    icon: Icons.restaurant,
  );

  // Thailand
  static const grabFoodTH = FoodDeliveryPlatform(
    name: 'GrabFood',
    appScheme: 'grab://food?screen=search&keyword={keyword}',
    webUrl: 'https://food.grab.com/th/th/search?keyword={keyword}',
    color: Color(0xFF00B14F),
    icon: Icons.two_wheeler,
  );

  static const foodpandaTH = FoodDeliveryPlatform(
    name: 'foodpanda',
    appScheme: 'foodpanda://search?q={keyword}',
    webUrl: 'https://www.foodpanda.co.th/search?q={keyword}',
    color: Color(0xFFE21B70),
    icon: Icons.delivery_dining,
  );

  // Indonesia
  static const gojek = FoodDeliveryPlatform(
    name: 'GoFood',
    appScheme: 'gojek://gofood/search?keyword={keyword}',
    webUrl: 'https://www.gojek.com/gofood/search?keyword={keyword}',
    color: Color(0xFF00AA13),
    icon: Icons.motorcycle,
  );

  // Malaysia
  static const grabFoodMY = FoodDeliveryPlatform(
    name: 'GrabFood',
    appScheme: 'grab://food?screen=search&keyword={keyword}',
    webUrl: 'https://food.grab.com/my/en/search?keyword={keyword}',
    color: Color(0xFF00B14F),
    icon: Icons.two_wheeler,
  );

  // Get platforms by country code
  static List<FoodDeliveryPlatform> getPlatformsByCountry(String countryCode) {
    switch (countryCode.toUpperCase()) {
      case 'VN': // Vietnam
        return [shopeeFood, grabFood, now];
      case 'US': // USA
        return [uberEats, doorDash, grubhub];
      case 'GB': // UK
        return [deliveroo, justEat, uberEats];
      case 'SG': // Singapore
        return [grabFood, foodpanda, deliveroo];
      case 'KR': // Korea
        return [baeminKR, coupangEats, uberEats];
      case 'JP': // Japan
        return [uberEatsJP, demaecan];
      case 'AU': // Australia
        return [menulog, uberEats, deliveroo];
      case 'IN': // India
        return [swiggy, zomato];
      case 'CN': // China
        return [meituan, eleme];
      case 'TH': // Thailand
        return [grabFoodTH, foodpandaTH];
      case 'ID': // Indonesia
        return [gojek, grabFood, foodpanda];
      case 'MY': // Malaysia
        return [grabFoodMY, foodpanda];
      case 'PH': // Philippines
        return [grabFood, foodpanda];
      case 'DE': // Germany
      case 'FR': // France
      case 'ES': // Spain
      case 'IT': // Italy
        return [deliveroo, justEat, uberEats];
      case 'CA': // Canada
        return [uberEats, doorDash, skipTheDishes];
      default:
        // Default to international platforms
        return [uberEats, deliveroo];
    }
  }

  static const skipTheDishes = FoodDeliveryPlatform(
    name: 'SkipTheDishes',
    appScheme: 'skipthedishes://search?q={keyword}',
    webUrl: 'https://www.skipthedishes.com/search?q={keyword}',
    color: Color(0xFFE8222E),
    icon: Icons.restaurant,
  );
}
