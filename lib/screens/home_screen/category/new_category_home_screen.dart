// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/category_db.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/categoy/category_model.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/home_screen/category/view_category.dart';
import 'package:schedulia/widgets/alert_box/alert_box.dart';
import 'package:schedulia/widgets/category/add_category.dart';
import 'package:schedulia/widgets/category/custom_dialogbox.dart';
import 'package:schedulia/widgets/category/user_container.dart';
import 'package:schedulia/widgets/category/custom_category_card.dart';
import 'package:schedulia/widgets/colors.dart';

class CategoryScreenNew extends StatefulWidget {
  const CategoryScreenNew({
    super.key,
  });

  @override
  State<CategoryScreenNew> createState() => _CategoryScreenNewState();
}

class _CategoryScreenNewState extends State<CategoryScreenNew> {
  List<Widget> widgets = [];
  UserModel? user;

  @override
  void initState() {
    super.initState();
    CategoryFunctions().currentUserCategory(userKey!);
    CategoryFunctions().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    CategoryFunctions().currentUserCategory(userKey!);
    CategoryFunctions().getCategory();
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 195, 199, 226),
          const Color.fromARGB(255, 250, 250, 252),
          white
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: userListNotifier,
                builder:
                    (BuildContext context, List<UserModel> userList, Widget? _) {
                  return UserContainer(color: white.withOpacity(0),items: const [],
                      text: userList.isNotEmpty &&
                              userList[int.parse(userKey!)].userName != null
                          ? 'Hello ${userList[int.parse(userKey!)].userName}'
                          : 'Hello User!',
                      img: userList[int.parse(userKey!)].userimage ?? '');
                }),
             Padding(
              padding: EdgeInsets.only(left: width*0.1, top: height*0.04),
              child:const  Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: currentUserCategoryNotifier,
                    builder: (context, categorylist, _) {
                      CategoryFunctions().currentUserCategory(userKey!);
                      onOptionSelected(categorylist);
                      return GridView(padding: EdgeInsets.all(width<600?width*0.05:width * 0.1,),
                        shrinkWrap: false,
                        gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: width<600?2:4,
                                crossAxisSpacing:width<600? width*0.04:width*0.06,
                                mainAxisSpacing: width<600? width*0.04:width*0.03,
                                ),
                        children: [
                          ...widgets,
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomDialogBox();
                                },
                              );
                            },
                            child: const AddCategory(),
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(height: height*0.1,)
          ],
        ),
      ),
    );
  }

  void onOptionSelected(List<CategoryModel> list) {
    widgets = [];

    for (var element in list) {
      widgets.add(
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Viewcategory(
                        category: element.categoryTitle,
                      )));
            },
            child: CustomCategorycontainer(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertBox(
                        okText: 'Delete',
                        title: 'Delete category?',
                        text: 'Are you sure you want to delete this category?',
                        onpressedCancel: () {
                          Navigator.of(context).pop();
                        },
                        onpressedDelete: () async {
                          await CategoryFunctions()
                              .deleteCategory(element.key)
                              .then((value) => Navigator.of(context).pop());
                        });
                  },
                );
              },
              category: element.categoryTitle,
              text: SizedBox(
                width: 100,
                child: Text(
                  element.categoryTitle,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              text2: '',
              text3: '',
              icon: element.categoryIcon != null
                  ? _getIconData(element.categoryIcon!)
                  // ? IconData(
                  //     int.tryParse(element.categoryIcon!.split('-').last) ??
                  //         Icons.error.codePoint,
                  //     fontFamily: element.categoryIcon!.split('-').first)
                  : null,
            )),
      );
    }
  }

  IconData _getIconData(String iconDataString) {
    switch (iconDataString) {
      case 'MaterialIcons-985232':
        return Icons.person_2_rounded;
      case 'MaterialIcons-983892':
        return Icons.monitor_heart_rounded;
      case 'MaterialIcons-61843':
        return Icons.location_on_outlined;
      case 'MaterialIcons-983751':
        return Icons.work_rounded;
      case 'MaterialIcons-58780':
        return Icons.shopping_cart;
      case 'MaterialIcons-58141':
        return Icons.home_work;
      case 'MaterialIcons-57632':
        return Icons.cake;
      case 'MaterialIcons-63364':
        return Icons.food_bank_rounded;
      case 'MaterialIcons-59445':
        return Icons.campaign_sharp;
      case 'MaterialIcons-63002':
        return Icons.card_giftcard_rounded;
      case 'MaterialIcons-62127':
        return Icons.play_circle_fill_outlined;
      case 'MaterialIcons-60757':
        return Icons.time_to_leave_sharp;
      case 'MaterialIcons-984157':
        return Icons.punch_clock_sharp;
      default:
        return Icons.tab;
    }
  }

  initializeUserKey() async {
    String? currentKey = await UserFunctions().getCurrentUserKey();
    return currentKey;
  }

  initializeuser() async {
    UserModel? user =
        await UserFunctions().getCurrentUser(await initializeUserKey());
    return user;
  }
}
