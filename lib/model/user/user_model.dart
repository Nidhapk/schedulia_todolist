import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  final String? userName;

  @HiveField(2)
  String? userimage;

  @HiveField(3)
  String? password;

  @HiveField(4)
  bool? isBlocked;

  UserModel({this.name, this.userName, this.userimage, this.password,this.isBlocked});
}
