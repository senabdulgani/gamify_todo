import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/trait_item.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/add_task_page.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

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

  // attirbutes
  List<TraitModel>? attributeList;
  // skills
  List<TraitModel>? skillList;

  int completedTaskCount = 0;
  int failedTaskCount = 0;

  @override
  void initState() {
    super.initState();

    for (var task in TaskProvider().taskList) {
      if (task.routineID == widget.taskModel.routineID) {
        if (widget.taskModel.type == TaskTypeEnum.TIMER) {
          allTimeDuration += task.currentDuration!;
        } else if (widget.taskModel.type == TaskTypeEnum.COUNTER) {
          allTimeCount += task.currentCount!;
        }
        //
        if (task.status == TaskStatusEnum.COMPLETED) {
          completedTaskCount++;
        } else if (task.status == TaskStatusEnum.FAILED) {
          failedTaskCount++;
        }
      }
    }

    taskRutinCreatedDate = TaskProvider().routineList.firstWhere((element) => element.id == widget.taskModel.routineID).createdDate;

    if (widget.taskModel.attributeIDList != null && widget.taskModel.attributeIDList!.isNotEmpty) {
      attributeList = widget.taskModel.attributeIDList!.map((e) => TraitProvider().traitList.firstWhere((element) => element.id == e)).toList();
    }
    if (widget.taskModel.skillIDList != null && widget.taskModel.skillIDList!.isNotEmpty) {
      skillList = widget.taskModel.skillIDList!.map((e) => TraitProvider().traitList.firstWhere((element) => element.id == e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.title),
            if (widget.taskModel.description != null && widget.taskModel.description!.isNotEmpty)
              Text(
                widget.taskModel.description!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.dirtyWhite,
                ),
              ),
          ],
        ),
        leading: InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await NavigatorService().goTo(
                AddTaskPage(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          if (widget.taskModel.type == TaskTypeEnum.TIMER)
            Text(
              "${widget.taskModel.currentDuration?.textShort3()} / ${widget.taskModel.remainingDuration?.textLongDynamicWithoutZero()}",
            )
          else if (widget.taskModel.type == TaskTypeEnum.COUNTER)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () {
                    if (widget.taskModel.currentCount! > 0) {
                      setState(() {
                        widget.taskModel.currentCount = widget.taskModel.currentCount! - 1;
                      });
                    }
                    ServerManager().updateTask(taskModel: widget.taskModel);
                  },
                  onLongPress: () {
                    if (widget.taskModel.currentCount! > 20) {
                      setState(() {
                        widget.taskModel.currentCount = widget.taskModel.currentCount! - 20;
                      });
                    }

                    ServerManager().updateTask(taskModel: widget.taskModel);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: AppColors.borderRadiusAll,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.remove,
                      size: 30,
                    ),
                  ),
                ),
                Text(
                  "${widget.taskModel.currentCount} / ${widget.taskModel.targetCount}",
                ),
                InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () {
                    setState(() {
                      widget.taskModel.currentCount = widget.taskModel.currentCount! + 1;
                    });

                    ServerManager().updateTask(taskModel: widget.taskModel);
                  },
                  onLongPress: () {
                    setState(() {
                      widget.taskModel.currentCount = widget.taskModel.currentCount! + 20;
                    });

                    ServerManager().updateTask(taskModel: widget.taskModel);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: AppColors.borderRadiusAll,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ],
            )
          else
            Text(widget.taskModel.status == TaskStatusEnum.COMPLETED
                ? "Completed"
                : widget.taskModel.status == TaskStatusEnum.FAILED
                    ? "Failed"
                    : "Not Completed"),

          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${LocaleKeys.AllTime.tr()} ${widget.taskModel.type == TaskTypeEnum.TIMER ? allTimeDuration.textShort3() : allTimeCount.toString()}"),
              const SizedBox(width: 10),
              Text(
                "${(DateTime.now().difference(taskRutinCreatedDate).inDays).abs()} ${LocaleKeys.DaysInProgress.tr()}",
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          Text("${LocaleKeys.AvarageDay.tr()} ${(allTimeDuration / (DateTime.now().difference(taskRutinCreatedDate).inDays == 0 ? 1 : DateTime.now().difference(taskRutinCreatedDate).inDays).abs()).textShortDynamic()}"),
          const SizedBox(height: 30),
          // TODO: en iyi gün
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Column(
          //       children: [
          //         Text("Best Day"),
          //         Text("Wednesday"),
          //       ],
          //     ),
          //   ],
          // ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle),
              const SizedBox(width: 3),
              Text("$completedTaskCount ${LocaleKeys.Times.tr()}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.close),
              const SizedBox(width: 3),
              Text("$failedTaskCount ${LocaleKeys.Times.tr()}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.tour_rounded),
              const SizedBox(width: 3),
              Text("%${(completedTaskCount + failedTaskCount) == 0 ? "0" : ((completedTaskCount / (completedTaskCount + failedTaskCount)) * 100).toInt()}"),
            ],
          ),
          // TODO: en uzun streak
          // const SizedBox(height: 40),
          // const Text("Longest Streak"),
          // const Text("24 day"),
          const SizedBox(height: 40),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (attributeList != null) traitItemList(attributeList),
              if (skillList != null) traitItemList(skillList),
            ],
          ),

          // TODO: haftalık çalışma saat grafiği
        ],
      ),
    );
  }

  Widget traitItemList(List<TraitModel>? traitList) {
    return SizedBox(
      width: 200,
      child: ListView(
        shrinkWrap: true,
        children: [
          for (TraitModel trait in traitList!)
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TraitItem(
                  trait: trait,
                  isStatisticsPage: true,
                ),
                const SizedBox(width: 10),
                // TODO:
                Text("60% of the ${trait.title}"),
              ],
            ),
        ],
      ),
    );
  }
}
