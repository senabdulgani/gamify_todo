import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/global_timer.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';

class StoreItem extends StatefulWidget {
  const StoreItem({
    super.key,
    required this.storeItemModel,
  });

  final StoreItemModel storeItemModel;

  @override
  State<StoreItem> createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          onTap: () {
            storeItemAction();
          },
          onLongPress: () {
            // task detaylarına git ordan da düzenlemek için ayrı gidecek
          },
          borderRadius: AppColors.borderRadiusAll,
          child: Container(
            height: 70,
            padding: const EdgeInsets.all(8),
            color: AppColors.transparent,
            child: Row(
              children: [
                storeItemIcon(),
                const SizedBox(width: 10),
                titleAndProgressWidgets(),
                const Spacer(),
                InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () {
                    userCredit -= widget.storeItemModel.credit;

                    if (widget.storeItemModel.type == TaskTypeEnum.TIMER) {
                      widget.storeItemModel.currentDuration = widget.storeItemModel.currentDuration! + widget.storeItemModel.addDuration!;
                    } else {
                      widget.storeItemModel.currentCount = widget.storeItemModel.currentCount! + widget.storeItemModel.addCount!;
                    }

                    StoreProvider().updateItems();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: AppColors.borderRadiusAll,
                      color: AppColors.panelBackground2,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          // TODO:
                          "add 1 hour ${widget.storeItemModel.credit}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.monetization_on,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget storeItemIcon() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Icon(
        widget.storeItemModel.type == TaskTypeEnum.COUNTER
            ? Icons.remove
            : widget.storeItemModel.isTimerActive!
                ? Icons.pause
                : Icons.play_arrow,
        size: 30,
      ),
    );
  }

  void storeItemAction() {
    if (widget.storeItemModel.type == TaskTypeEnum.COUNTER) {
      widget.storeItemModel.currentCount = widget.storeItemModel.currentCount! - 1;

      // TODO: - olursa disiplin düşecek
    } else {
      GlobalTimer().startStopTimer(
        storeItemModel: widget.storeItemModel,
      );
    }

    StoreProvider().updateItems();
  }

  Widget titleAndProgressWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.storeItemModel.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        widget.storeItemModel.type == TaskTypeEnum.CHECKBOX
            ? const SizedBox()
            : widget.storeItemModel.type == TaskTypeEnum.COUNTER
                ? Text(
                    "${widget.storeItemModel.currentCount}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    widget.storeItemModel.currentDuration!.textShortDynamic(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      ],
    );
  }
}
