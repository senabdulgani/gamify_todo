import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/day_item.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/go_today_button.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_list.dart';
import 'package:gamify_todo/5%20Service/notification_services.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.watch<TaskProvider>().selectedDate;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Row(
          children: [
            DayItem(date: selectedDate.subtract(const Duration(days: 1))),
            DayItem(date: selectedDate),
            DayItem(date: selectedDate.add(const Duration(days: 1))),
            const GoTodayButton(),
          ],
        ),
        actions: [
          // test button
          if (kDebugMode)
            InkWell(
              onTap: () async {
                NotificationService().notificaitonTest();
              },
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text("Test Notificaiton"),
              ),
            ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    TaskProvider().changeShowCompleted();
                  },
                  child: Text("${TaskProvider().showCompleted ? "Hide" : "Show"} Completed"),
                ),
              ];
            },
          ),
        ],
      ),
      body: const TaskList(),
    );
  }
}
