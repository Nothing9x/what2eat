import 'package:uuid/uuid.dart';

class FoodItem {
  final String id;
  final String categoryId;
  final String name;
  final String icon;
  final String description;
  final String imageUrl;

  FoodItem({
    String? id,
    String? categoryId,
    required this.name,
    required this.icon,
    required this.description,
    required this.imageUrl,
  })  : id = id ?? const Uuid().v4(),
        categoryId = categoryId ?? '';

  FoodItem copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? icon,
    String? description,
    String? imageUrl,
  }) {
    return FoodItem(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'icon': icon,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String?,
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  // Keep the static list for migration purposes (will be removed later)
  static final List<FoodItem> foodList = [
    FoodItem(
      name: 'Cơm Tấm',
      icon: '🍚',
      description: 'Cơm tấm sườn nướng thơm phức, ăn kèm mắm nêm chua ngọt!',
      imageUrl: 'https://images.unsplash.com/photo-1569562211093-4ed0d0758f12?w=800',
    ),
    FoodItem(
      name: 'Bánh Mì',
      icon: '🥖',
      description: 'Bánh mì Sài Gòn giòn tan, nhân thịt đầy đặn!',
      imageUrl: 'https://images.unsplash.com/photo-1598511726623-d2e9996892f0?w=800',
    ),
    FoodItem(
      name: 'Bún Bò',
      icon: '🍜',
      description: 'Bún bò Huế cay nồng, hương sả thơm lừng!',
      imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800',
    ),
    FoodItem(
      name: 'Burger',
      icon: '🍔',
      description: 'Burger bò Úc mọng nước, phô mai tan chảy!',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
    ),
    FoodItem(
      name: 'Phở Bò',
      icon: '🍲',
      description: 'Phở bò Hà Nội truyền thống, nước trong vắt thơm ngon!',
      imageUrl: 'https://images.unsplash.com/photo-1591814468924-caf88d1232e1?w=800',
    ),
    FoodItem(
      name: 'Pizza',
      icon: '🍕',
      description: 'Pizza Ý phô mai kéo sợi, giòn rụm hấp dẫn!',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800',
    ),
  ];
}
