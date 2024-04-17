import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schedulia/model/categoy/category_model.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/screens/home_screen/category/view_category.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<CategoryModel>> categoryNotifier = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> currentUserCategoryNotifier =
    ValueNotifier([]);
ValueNotifier<List<TaskModel>> filterTaskByCategoryOnThisDayNotifier =
    ValueNotifier([]);

class CategoryFunctions extends ChangeNotifier {
  Future addCategory(CategoryModel value) async {
    final Box<CategoryModel> box =
        await Hive.openBox<CategoryModel>('category_db');
    await box.add(value);
    await getCategory();
    await box.close();
  }

  Future getCategory() async {
    final Box<CategoryModel> box =
        await Hive.openBox<CategoryModel>('category_db');
    categoryNotifier.value.clear();
    categoryNotifier.value.addAll(box.values);
    categoryNotifier.notifyListeners();
  }

  Future deleteCategory(int key) async {
    final Box<CategoryModel> box =
        await Hive.openBox<CategoryModel>('category_db');
    box.delete(key);
    await box.close();
    await getCategory();
  }

  Future currentUserCategory(String userKeyy) async {
    final Box<CategoryModel> category =
        await Hive.openBox<CategoryModel>('category_db');
    List<CategoryModel> allcategories = category.values.toList();
    List<CategoryModel> currentUserCategory =
        allcategories.where((element) => element.userkey == userKeyy).toList();
    currentUserCategoryNotifier.value = currentUserCategory;
    currentUserCategoryNotifier.notifyListeners();
    return currentUserCategory;
  }

  Future filterTaskByCategory(String category) async {
    await TaskFunctions().getCurrentUserTask(userKey!);
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    // List<CategoryModel> currentUserAllCategries =
    //currentUserCategoryNotifier.value;
    List<TaskModel> matchingTasks = currentUserAllTask.where((tasks) {
      return tasks.taskType == category;
    }).toList();
    filteredCategoryNotifier.value.clear();
    filteredCategoryNotifier.value = matchingTasks;
    filteredCategoryNotifier.notifyListeners();
    return matchingTasks;
  }

  Future filterTaskByCategoryOnThisDay(DateTime selectedDatee) async {
    List<TaskModel> filteredTaskByCategory = filteredCategoryNotifier.value;
    List<TaskModel> filterTaskByCategoryOnThisDay = filteredTaskByCategory
        .where((task) => isSameDay(DateTime.parse(task.date!), selectedDatee))
        .toList();
    filterTaskByCategoryOnThisDayNotifier.value = filterTaskByCategoryOnThisDay;
    filterTaskByCategoryOnThisDayNotifier.notifyListeners();
  }

  Future taskDoneinCategory(String category) async {
    List<TaskModel> task = await filterTaskByCategory(category);
    List<TaskModel> filteredTasks =
        task.where((element) => element.iscompleted == true).toList();
    return filteredTasks.length;
  }

  Future taskNotDoneinCategory(String category) async {
    List<TaskModel> task = await filterTaskByCategory(category);
    List<TaskModel> filteredTasks =
        task.where((element) => element.iscompleted == false).toList();
    return filteredTasks.length;
  }

  Future<bool> checkCategoryExists(String categoryTitle) async {
    // Get the list of categories for the user
    List<CategoryModel> userCategories = await currentUserCategory(userKey!);
    String lowercasecategories = categoryTitle.toLowerCase();
    // Check if any category has the same title
    return userCategories.any((category) =>
        category.categoryTitle.toLowerCase() == lowercasecategories);
  }
}
