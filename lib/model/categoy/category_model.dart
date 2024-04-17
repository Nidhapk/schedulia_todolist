
import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject {
  @HiveField(0)
  final String categoryTitle;

  @HiveField(1)
  final String? categoryIcon;

  @HiveField(2)
  final bool? done;

  @HiveField(3)
  final String userkey;

  CategoryModel(
      {required this.categoryTitle,
      required this.categoryIcon,
      required this.done,
      required this.userkey});
}
