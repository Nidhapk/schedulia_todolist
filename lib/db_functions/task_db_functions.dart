import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:schedulia/db_functions/category_db.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/screens/home_screen/calender/calender_screen.dart';
import 'package:schedulia/screens/home_screen/category/view_category.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_done.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_not_done.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<TaskModel>> taskNotifier = ValueNotifier([]);
ValueNotifier<List<TaskModel>> currentUserTaskNotifier = ValueNotifier([]);
ValueNotifier<List<TaskModel>> taskImportantNotifier = ValueNotifier([]);

class TaskFunctions extends ChangeNotifier {
  Future addTask(TaskModel value) async {
    final Box<TaskModel> taskDB = await Hive.openBox<TaskModel>('task_db');
    await taskDB.add(value);
    // var id = await getAllTask();
    await taskDB.close();
    // return id;
  }

  Future getAllTask() async {
    final userVariable = await Hive.openBox<TaskModel>('task_db');
    taskNotifier.value.clear();
    taskNotifier.value.addAll(userVariable.values);
    taskNotifier.notifyListeners();
    //await userVariable.close();
  }

  Future<void> delete(int key) async {
    final box = await Hive.openBox<TaskModel>('task_db');
    await box.delete(key);
    await getAllTask();
    await box.close();

    currentUserTaskOnSelecteDdayNotifier.value.clear();
    currentUserTaskOnSelecteDdayNotifier.notifyListeners();
    filteredCategoryNotifier.value.clear();
    filteredCategoryNotifier.notifyListeners();
    filterTaskByCategoryOnThisDayNotifier.value.clear();
    filterTaskByCategoryOnThisDayNotifier.notifyListeners();

    await getCurrentUsertaskOnSelectedDay(today);
  }

  Future editTask(
    TaskModel value,
    int key,
  ) async {
    final taskVariable = await Hive.openBox<TaskModel>('task_db');
    await taskVariable.put(key, value);
    taskNotifier.value.clear();

    currentUserTaskOnSelecteDdayNotifier.notifyListeners();
    filterTaskByCategoryOnThisDayNotifier.value.clear();
    filterTaskByCategoryOnThisDayNotifier.notifyListeners();
    await CategoryFunctions().filterTaskByCategoryOnThisDay(today);
    await getCurrentUsertaskOnSelectedDay(today);
    await CategoryFunctions().filterTaskByCategoryOnThisDay(today);
  }

  Future markCompleted(TaskModel value, int key) async {
    final taskVariable = await Hive.openBox<TaskModel>('task_db');
    await taskVariable.put(key, value);
  }

  Future<List<TaskModel>> getCurrentUserTask(String userKeyy) async {
    final Box<TaskModel> taskBox = await Hive.openBox<TaskModel>('task_db');
    List<TaskModel> allTasks = taskBox.values.toList();
    List<TaskModel> currentUserTasks =
        allTasks.where((tasks) => tasks.userKey == userKeyy).toList();
    currentUserTaskNotifier.value.clear();
    currentUserTaskNotifier.value = currentUserTasks;

    currentUserTaskNotifier.notifyListeners();
    return currentUserTasks;
  }

  Future getCurrentUsertaskOnSelectedDay(DateTime selecteddate) async {
    // String formatted = DateFormat('MMM-dd-yyyy').format(selecteddate);
    // DateTime parsedDate = DateFormat('MMM-dd-yyyy').parse(formatted);
    String? key = await UserFunctions().getCurrentUserKey();
    await getCurrentUserTask(key!);
    List<TaskModel> allTaskOfCurrentUser =
        currentUserTaskNotifier.value.toList();
    List<TaskModel> currentUserTaskOnselectedDay = allTaskOfCurrentUser
        .where((task) => isSameDay(DateTime.parse(task.date!), selecteddate))
        .toList();
    currentUserTaskOnSelecteDdayNotifier.value = currentUserTaskOnselectedDay;
    currentUserTaskOnSelecteDdayNotifier.notifyListeners();
  }

  Future getTaskDone() async {
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    List<TaskModel> filterDoneTask() {
      return currentUserAllTask.where((task) => task.iscompleted!).toList();
    }

    taskDoneNotifier.value.clear();
    taskDoneNotifier.value.addAll(filterDoneTask());
    taskDoneNotifier.notifyListeners();
    return filterDoneTask();
  }

  Future getTaskImportant() async {
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    List<TaskModel> filterImportantTask() {
      return currentUserAllTask.where((task) => task.isImportant!).toList();
    }

    taskImportantNotifier.value.clear();
    taskImportantNotifier.value.addAll(filterImportantTask());
    taskImportantNotifier.notifyListeners();
    return filterImportantTask();
  }

  Future<List<TaskModel>> getTaskNotDone() async {
    List<TaskModel> currentUserAllTask = currentUserTaskNotifier.value;
    List<TaskModel> filterDoneTask() {
      return currentUserAllTask.where((task) => !task.iscompleted!).toList();
    }

    taskNotDoneNotifier.value.clear();
    taskNotDoneNotifier.value.addAll(filterDoneTask());
    taskNotDoneNotifier.notifyListeners();
    return filterDoneTask();
  }
}
