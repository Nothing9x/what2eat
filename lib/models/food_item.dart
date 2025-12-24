class FoodItem {
  final String name;
  final String icon;
  final String description;
  final String imageUrl;

  const FoodItem({
    required this.name,
    required this.icon,
    required this.description,
    required this.imageUrl,
  });

  static const List<FoodItem> foodList = [
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
