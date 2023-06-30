import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final format = DateFormat.yMd();

enum Category { leisure, food, work, travel }

const CategoryIcons = {
  Category.food: Icons.dinner_dining,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff
};

class Expanse {
  Expanse(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatdate {
    return format.format(date);
  }
}

class ExpanseBucket {
  const ExpanseBucket({required this.category, required this.expanses});

  ExpanseBucket.forCategory(List<Expanse> allExpanses, this.category)
      : expanses = allExpanses
            .where((expanse) => expanse.category == category)
            .toList();

  final Category category;
  final List<Expanse> expanses;

  double get totalExpanse {
    double sum = 0;

    for (final expanse in expanses) {
      sum += expanse.amount;
    }

    return sum;
  }
}
