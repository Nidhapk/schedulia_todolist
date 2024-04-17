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
    CategoryFunctions().currentUserCategory(userKey!);
    CategoryFunctions().getCategory();
    return Container(
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
                return UserContainer(
                    text: userList.isNotEmpty &&
                            userList[keys.indexOf(userKey!)].userName != null
                        ? 'Hello ${userList[keys.indexOf(userKey!)].userName}'
                        : 'Hello User!',
                    img: userList[keys.indexOf(userKey!)].userimage ?? '');
              }),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 25),
            child: Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ValueListenableBuilder(
                    valueListenable: currentUserCategoryNotifier,
                    builder: (context, categorylist, _) {
                      CategoryFunctions().currentUserCategory(userKey!);
                      onOptionSelected(categorylist);
                      return GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
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
            ),
          ),
        ],
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
                  ? IconData(
                      int.tryParse(element.categoryIcon!.split('-').last) ??
                          Icons.error.codePoint,
                      fontFamily: element.categoryIcon!.split('-').first)
                  : null,
            )),
      );
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
