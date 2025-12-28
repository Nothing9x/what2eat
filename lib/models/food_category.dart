import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'food_item.dart';
import 'notification_settings.dart';

class FoodCategory {
  final String id;
  final String name;
  final String icon;
  final Color color;
  final List<FoodItem> items;
  final NotificationSettings? notificationSettings;
  final DateTime createdAt;
  final DateTime updatedAt;

  FoodCategory({
    String? id,
    required this.name,
    required this.icon,
    required this.color,
    List<FoodItem>? items,
    this.notificationSettings,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        items = items ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  int get itemCount => items.length;

  FoodCategory copyWith({
    String? id,
    String? name,
    String? icon,
    Color? color,
    List<FoodItem>? items,
    NotificationSettings? notificationSettings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      items: items ?? this.items,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color.toARGB32(),
      'items': items.map((item) => item.toJson()).toList(),
      'notificationSettings': notificationSettings?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: Color(json['color'] as int),
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => FoodItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      notificationSettings: json['notificationSettings'] != null
          ? NotificationSettings.fromJson(json['notificationSettings'] as Map<String, dynamic>)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
