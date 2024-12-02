import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/add_task_page.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/route_manager.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  // all time duration
  Duration allTimeDuration = Duration.zero;
  int allTimeCount = 0;

  late DateTime taskRutinCreatedDate;

  @override
  void initState() {
    super.initState();

    // all time duration
    // tüm tasklara bak taskmodel ile aynı id ye sahip taskların current durationlarını topla

    for (var task in TaskProvider().taskList) {
      if (task.rutinID == widget.taskModel.rutinID) {
        if (widget.taskModel.type == TaskTypeEnum.TIMER) {
          allTimeDuration += task.currentDuration!;
        } else if (widget.taskModel.type == TaskTypeEnum.COUNTER) {
          allTimeCount += task.currentCount!;
        }
      }
    }

    taskRutinCreatedDate = routineList.firstWhere((element) => element.id == widget.taskModel.rutinID).createdDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskModel.title),
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.to(
                () => AddTaskPage(
                  editTask: widget.taskModel,
                ),
                transition: Transition.rightToLeft,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text("${widget.taskModel.currentDuration?.textShort3()} / ${widget.taskModel.remainingDuration?.textLongDynamicWithoutZero()}"),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("All time ${widget.taskModel.type == TaskTypeEnum.TIMER ? allTimeDuration.textShort3() : allTimeCount.toString()}"),
              const SizedBox(width: 10),
              Text(
                "${(DateTime.now().difference(taskRutinCreatedDate).inDays).abs()} days in progress",
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          // const Text("Avarage 1h 10m in aday"),
          Text("Avarage ${(allTimeDuration / (DateTime.now().difference(taskRutinCreatedDate).inDays).abs()).textShortDynamic()} in aday"),
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Best hour"),
                  Text("15:00"),
                ],
              ),
              Column(
                children: [
                  Text("Best Day"),
                  Text("Wednesday"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle),
              Text("20 Times"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.close),
              Text("15 Times"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.tour_rounded),
              Text("% 64"),
            ],
          ),
          const SizedBox(height: 40),
          const Text("Longest Streak"),
          const Text("24 day"),
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star),
              Text("20% of the power"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star),
              Text("20% of the power"),
            ],
          ),

          // TODO: haftalık çalışma saat grafiği
        ],
      ),
    );
  }
}
