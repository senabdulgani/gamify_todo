import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';

class StoreProvider with ChangeNotifier {
  // burayı singelton yaptım gayet de iyi oldu neden normalde de context den kullanıyoruz anlamadım. galiba "watch" için olabilir. sibelton kısmını global timer için yaptım.
  static final StoreProvider _instance = StoreProvider._internal();

  factory StoreProvider() {
    return _instance;
  }

  StoreProvider._internal();
// ?? - kredi ve itemler - ye düşebilecek ama bu disipinden eksilmesine sebep oalcak
  List<StoreItemModel> storeItemList = [
    StoreItemModel(
      id: 0,
      title: "Game",
      type: TaskTypeEnum.TIMER,
      isTimerActive: false,
      addDuration: const Duration(hours: 1),
      currentDuration: const Duration(minutes: 0),
      credit: 5,
    ),
    StoreItemModel(
      id: 1,
      title: "Movie",
      type: TaskTypeEnum.COUNTER,
      addCount: 1,
      currentCount: 0,
      credit: 3,
    ),
  ];

  void addItem(StoreItemModel taskModel) {
    storeItemList.add(taskModel);

    notifyListeners();
  }

  void updateItems() {
    notifyListeners();
  }
}
