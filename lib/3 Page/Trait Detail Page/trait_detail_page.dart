import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:get/route_manager.dart';

class TraitDetailPage extends StatefulWidget {
  const TraitDetailPage({
    super.key,
    required this.traitModel,
  });

  final TraitModel traitModel;

  @override
  State<TraitDetailPage> createState() => _TraitDetailPageState();
}

// TODO: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa

class _TraitDetailPageState extends State<TraitDetailPage> {
  TextEditingController traitTitle = TextEditingController();
  String traitIcon = "🎯";
  Color selectedColor = AppColors.main;

  late Duration totalDuration;

  // relaited tasks
  List<TaskModel> relaitedTasks = [];
  List<TaskModel> relaitedRoutines = [];

  @override
  void initState() {
    traitTitle.text = widget.traitModel.title;
    traitIcon = widget.traitModel.icon;
    selectedColor = widget.traitModel.color;

    // TODO: burada her seferinde tüm listeyi kontrol etmek yerine bir üst sayfada tek seferde listeyi kontrol ederken süreleri dağıtmak olabilir mi?
    // bu trait ile bağlantılı taskların sürelerini topla
    totalDuration = TaskProvider().taskList.fold(
      Duration.zero,
      (previousValue, element) {
        if (((element.skillIDList != null && element.skillIDList!.contains(widget.traitModel.id)) || (element.attributeIDList != null && element.attributeIDList!.contains(widget.traitModel.id))) && element.remainingDuration != null) {
          if (element.type == TaskTypeEnum.CHECKBOX && element.status != TaskStatusEnum.COMPLETED) {
            return previousValue;
          }
          return previousValue +
              (element.type == TaskTypeEnum.CHECKBOX
                  ? element.remainingDuration!
                  : element.type == TaskTypeEnum.COUNTER
                      ? element.remainingDuration! * element.currentCount!
                      : element.currentDuration!);
        }
        return previousValue;
      },
    );

    // relaited tasks
    TaskProvider().taskList.where((element) {
      if (element.skillIDList != null && element.skillIDList!.contains(widget.traitModel.id)) {
        if (element.routineID != null) {
          relaitedRoutines.add(element);
        } else {
          relaitedTasks.add(element);
        }
      } else if (element.attributeIDList != null && element.attributeIDList!.contains(widget.traitModel.id)) {
        if (element.routineID != null) {
          relaitedRoutines.add(element);
        } else {
          relaitedTasks.add(element);
        }
      }
      return false;
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.traitModel.title} Detail'),
        leading: InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () async {
              if (traitTitle.text.trim().isEmpty) {
                traitTitle.clear();

                Helper().getMessage(
                  message: "Trait name cant be empty",
                  status: StatusEnum.WARNING,
                );

                return;
              }

              // TODO add değil edit olacak

              final TraitModel updatedTrait = TraitModel(
                id: widget.traitModel.id,
                title: traitTitle.text,
                icon: traitIcon,
                color: selectedColor,
                type: widget.traitModel.type == TraitTypeEnum.SKILL ? TraitTypeEnum.SKILL : TraitTypeEnum.ATTRIBUTE,
              );

              TraitProvider().editTrait(updatedTrait);

              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                Expanded(
                  child: TextField(
                    controller: traitTitle,
                    decoration: const InputDecoration(hintText: "Name"),
                  ),
                ),
                const SizedBox(width: 10),
                // Icon
                InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () async {
                    traitIcon = await Helper().showEmojiPicker(context);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.panelBackground2,
                        borderRadius: AppColors.borderRadiusAll,
                      ),
                      child: Center(
                        child: Text(
                          traitIcon,
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Color
                InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () async {
                    selectedColor = await Helper().selectColor();
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: AppColors.borderRadiusAll,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              totalDuration.toLevel(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              totalDuration.textShort2hour(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            // TODO: bu traiti etkileyen tasklar ve ne kadar etkiledikleri

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: relaitedTasks.length,
                    itemBuilder: (context, index) {
                      // TODO: task ve rutin olarak ayır

                      final TaskModel task = relaitedTasks[index];

                      Duration allTimeDuration = Duration.zero;
                      int allTimeCount = 0;

                      for (var task in TaskProvider().taskList) {
                        if (task.routineID == task.routineID) {
                          if (task.type == TaskTypeEnum.TIMER) {
                            allTimeDuration += task.currentDuration!;
                          } else if (task.type == TaskTypeEnum.COUNTER) {
                            allTimeCount += task.currentCount!;
                          }
                        }
                      }

                      if (task.type == TaskTypeEnum.COUNTER) {
                        allTimeDuration += task.remainingDuration! * allTimeCount;
                      }

                      return Row(
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            allTimeDuration.textShort2hour(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: relaitedRoutines.length,
                    itemBuilder: (context, index) {
                      // TODO: task ve rutin olarak ayır

                      final TaskModel task = relaitedRoutines[index];

                      Duration allTimeDuration = Duration.zero;
                      int allTimeCount = 0;

                      for (var task in TaskProvider().taskList) {
                        if (task.routineID == task.routineID) {
                          if (task.type == TaskTypeEnum.TIMER) {
                            allTimeDuration += task.currentDuration!;
                          } else if (task.type == TaskTypeEnum.COUNTER) {
                            allTimeCount += task.currentCount!;
                          }
                        }
                      }

                      if (task.type == TaskTypeEnum.COUNTER) {
                        allTimeDuration += task.remainingDuration! * allTimeCount;
                      }

                      return Row(
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            allTimeDuration.textShort2hour(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // delete button
            InkWell(
              borderRadius: AppColors.borderRadiusAll,
              onTap: () {
                TraitProvider().removeTrait(widget.traitModel.id);
                // TODO:
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: AppColors.borderRadiusAll,
                  color: AppColors.red,
                ),
                child: Text(
                  LocaleKeys.Delete.tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
