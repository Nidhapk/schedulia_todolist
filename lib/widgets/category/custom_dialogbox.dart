// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/category_db.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/categoy/category_model.dart';
import 'package:schedulia/screens/home_screen/category/icnon_class.dart';
import 'package:schedulia/widgets/custom_snackbar.dart';

List<ValueNotifier<double>> iconnotifier = [];
//ValueNotifier<int> selectedicon = ValueNotifier(0);

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({
    super.key,
  });

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final categoryController = TextEditingController();
  final categoryIconController = TextEditingController();
  IconData? selectedIcon;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SizedBox(
        height: 350,
        width: double.minPositive,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Task Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: categoryController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    final trimmedValue = value?.trim();
                    if (trimmedValue == null || trimmedValue.isEmpty) {
                      return 'location can\'t be empty';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2)),
                      hintText: 'Enter title here'),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: ((context, index) {
                  iconnotifier.add(ValueNotifier<double>(20.0));
                  return ValueListenableBuilder(
                      valueListenable: iconnotifier[index],
                      builder: (context, sizevalue, _) {
                        return IconButton(
                          icon: Icon(
                            icons[index].icon,
                            size: sizevalue,
                            color: icons[index].color,
                          ),
                          onPressed: () {
                            for (var element in iconnotifier) {
                              element.value = 20.0;
                              setState(() {});
                            }
                            iconnotifier[index].value = 40.0;
                            selectedIcon = icons[index].icon;
                          },
                        );
                      });
                }),
                itemCount: icons.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
                TextButton(
                  onPressed: () async {
                    await addCategoryOnpressed();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future addCategoryOnpressed() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      bool categoryExists = await CategoryFunctions()
          .checkCategoryExists(categoryController.text.trim());
      if (categoryExists == false) {
        CategoryModel category = CategoryModel(
            userkey: userKey!,
            categoryTitle: categoryController.text.trim(),
            categoryIcon:
                selectedIcon != null ? iconDataToString(selectedIcon!) : null,
            done: false);

        await CategoryFunctions().addCategory(category);
        await CategoryFunctions()
            .currentUserCategory(userKey!)
            .then((value) => Navigator.of(context).pop());
      } else {
        CustomSnackBar.show(
            context, 'Unable to create category,Category alredy exist!');
      }
    }
    //String? currentUserKey = await UserFunctions().getCurrentUserKey();
  }

  String iconDataToString(IconData icon) {
    return '${icon.fontFamily}-${icon.codePoint}';
  }
}
