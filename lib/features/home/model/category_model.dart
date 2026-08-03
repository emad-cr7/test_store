import 'package:flutter/material.dart';

class CategoryModel {
  final String? id;
  final String? name;
  final String? image;
  final IconData? icon;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      image: json['image']?.toString(),
    );
  }
}