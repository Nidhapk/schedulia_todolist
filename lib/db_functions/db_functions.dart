import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
ValueNotifier<String?> currentUserNotifier = ValueNotifier('');

String? userKey;
List<String> keys = [];

class UserFunctions extends ChangeNotifier {
  Future addUser(UserModel value) async {
    final Box<UserModel> userVariable =
        await Hive.openBox<UserModel>('user_db');
    int key = await userVariable.add(value);
    userKey = key.toString();

    await saveCurrentUser(userKey!);

    await getUser();
    //await userVariable.close();
  }

  Future getUser() async {
    final userVariable = await Hive.openBox<UserModel>('user_db');
    keys.clear();
    keys.addAll(userVariable.keys.map((e) => e.toString()).toList());
    userListNotifier.value.clear();
    userListNotifier.value.addAll(userVariable.values);
    userListNotifier.notifyListeners();
    await userVariable.close();
  }

  Future saveCurrentUser(String key) async {
    Box<String> keydata = await Hive.openBox<String>('current_userKey');
    await keydata.put('currentUserKey', key);
    await keydata.close();
    await getCurrentUserKey();
  }

  Future<String?> getCurrentUserKey() async {
    Box<String> box = await Hive.openBox<String>('current_userKey');
    String? key = box.get('currentUserKey');
    userKey = key;
    //await box.close();
    return userKey;
  }

  Future<UserModel?> getCurrentUser(String key) async {
    final Box<UserModel> userVariable =
        await Hive.openBox<UserModel>('user_db');

    return userVariable.get(int.parse(key));
  }

  Future editUser(UserModel value, int key) async {
    final userVariable = await Hive.openBox<UserModel>('user_db');
    await userVariable.putAt(key, value);
    await userVariable.close();
    await getUser();
  }

  Future<bool> checkuser() async {
    final userVariable = await Hive.openBox<UserModel>('user_db');
    keys.clear();
    keys.addAll(userVariable.keys.map((e) => e.toString()).toList());

    var l = userVariable.length;
    await userVariable.close();
    if (l >= 1) {
      return true;
    }
    return false;
  }

  Future<bool> checkUserLoggedIn(bool isLoggedIn, String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLoggedIn = pref.getBool('isLoggedIn');
    return isLoggedIn ?? false;
  }

  Future<String?> validateUserLogin(String userName, String password) async {
    final Box<UserModel> user = await Hive.openBox<UserModel>('user_db');
    if (user.isEmpty) {
      return null;
    } else {
      UserModel? matchUser = user.values.firstWhere(
        (element) =>
            element.userName == userName &&
            element.password == password &&
            element.isBlocked == false,
        orElse: () => UserModel(),
      );
      userKey = null;
      if (matchUser.isInBox) {
        int? key2 = matchUser.key;

        await saveCurrentUser(key2.toString());
      }

      return userKey;
    }
  }

  Future addProfile(UserModel user) async {
    Box<UserModel> user1 = await Hive.openBox<UserModel>('user_db');
    UserModel? currentuser = await getCurrentUser(userKey!);
    currentuser!.userimage = user.userimage;
    currentuser.name = user.name;

    await user1.put(int.parse(userKey!), currentuser);
    await user1.close();
    await getUser();
  }

  Future changePassword(UserModel user) async {
    Box<UserModel> user1 = await Hive.openBox<UserModel>('user_db');
    UserModel? currentuser = await getCurrentUser(userKey!);
    currentuser!.password = user.password;
    await user1.put(int.parse(userKey!), currentuser);
    await user1.close();
    await getUser();
  }

  Future<bool> checkUserExist(String userNameEntered) async {
    final Box<UserModel> users = await Hive.openBox<UserModel>('user_db');
    List<UserModel> allUsers = users.values.toList();
    bool existUser =
        allUsers.any((element) => element.userName == userNameEntered);
    await users.close();
    return existUser;
  }

  Future deleteUser(int key) async {
    final Box<UserModel> users = await Hive.openBox<UserModel>('user_db');
    await users.delete(key);

    await getUser();
  }

  Future blockeUser(int key) async {
    final Box<UserModel> users = await Hive.openBox<UserModel>('user_db');
    UserModel userModel = UserModel(isBlocked: true);
    await users.put(key, userModel);
  }
}
