import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';

class CurrentStoreProgress extends StatefulWidget {
  const CurrentStoreProgress({
    super.key,
    required this.itemModel,
  });

  final ItemModel itemModel;

  @override
  State<CurrentStoreProgress> createState() => _CurrentStoreProgressState();
}

class _CurrentStoreProgressState extends State<CurrentStoreProgress> {
  bool _isIncrementing = false;
  bool _isDecrementing = false;

  @override
  Widget build(BuildContext context) {
    return widget.itemModel.type == TaskTypeEnum.COUNTER ? _buildCounterProgress() : _buildTimerProgress();
  }

  Widget _buildCounterProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.itemModel.currentCount! > 0) {
              setState(() {
                widget.itemModel.currentCount = widget.itemModel.currentCount! - 1;
              });
              ServerManager().updateItem(itemModel: widget.itemModel);
            }
          },
          onLongPressStart: (_) async {
            _isDecrementing = true;
            while (_isDecrementing && mounted) {
              if (widget.itemModel.currentCount! > 0) {
                setState(() {
                  widget.itemModel.currentCount = widget.itemModel.currentCount! - 1;
                });
                ServerManager().updateItem(itemModel: widget.itemModel);
              }
              await Future.delayed(const Duration(milliseconds: 60));
            }
          },
          onLongPressEnd: (_) {
            _isDecrementing = false;
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.remove, size: 30),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          "${widget.itemModel.currentCount}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.itemModel.currentCount = widget.itemModel.currentCount! + 1;
            });
            ServerManager().updateItem(itemModel: widget.itemModel);
          },
          onLongPressStart: (_) async {
            _isIncrementing = true;
            while (_isIncrementing && mounted) {
              setState(() {
                widget.itemModel.currentCount = widget.itemModel.currentCount! + 1;
              });
              ServerManager().updateItem(itemModel: widget.itemModel);
              await Future.delayed(const Duration(milliseconds: 60));
            }
          },
          onLongPressEnd: (_) {
            _isIncrementing = false;
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.add, size: 30),
          ),
        ),
      ],
    );
  }

  Widget _buildTimerProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDurationControl(
          label: LocaleKeys.Hour.tr(),
          value: widget.itemModel.currentDuration?.inHours ?? 0,
          onIncrease: () {
            setState(() {
              widget.itemModel.currentDuration = (widget.itemModel.currentDuration ?? Duration.zero) + const Duration(hours: 1);
            });
            ServerManager().updateItem(itemModel: widget.itemModel);
          },
          onDecrease: () {
            if ((widget.itemModel.currentDuration?.inHours ?? 0) > 0) {
              setState(() {
                widget.itemModel.currentDuration = (widget.itemModel.currentDuration ?? Duration.zero) - const Duration(hours: 1);
              });
              ServerManager().updateItem(itemModel: widget.itemModel);
            }
          },
        ),
        const SizedBox(width: 16),
        _buildDurationControl(
          label: LocaleKeys.Minute.tr(),
          value: (widget.itemModel.currentDuration?.inMinutes ?? 0) % 60,
          onIncrease: () {
            setState(() {
              widget.itemModel.currentDuration = (widget.itemModel.currentDuration ?? Duration.zero) + const Duration(minutes: 1);
            });
            ServerManager().updateItem(itemModel: widget.itemModel);
          },
          onDecrease: () {
            if ((widget.itemModel.currentDuration?.inMinutes ?? 0) > 0) {
              setState(() {
                widget.itemModel.currentDuration = (widget.itemModel.currentDuration ?? Duration.zero) - const Duration(minutes: 1);
              });
              ServerManager().updateItem(itemModel: widget.itemModel);
            }
          },
        ),
        const SizedBox(width: 16),
        _buildDurationControl(
          label: LocaleKeys.Second.tr(),
          value: (widget.itemModel.currentDuration?.inSeconds ?? 0) % 60,
          onIncrease: () {
            setState(() {
              widget.itemModel.currentDuration = (widget.itemModel.currentDuration ?? Duration.zero) + const Duration(seconds: 1);
            });
            ServerManager().updateItem(itemModel: widget.itemModel);
          },
          onDecrease: () {
            if ((widget.itemModel.currentDuration?.inSeconds ?? 0) > 0) {
              setState(() {
                widget.itemModel.currentDuration = (widget.itemModel.currentDuration ?? Duration.zero) - const Duration(seconds: 1);
              });
              ServerManager().updateItem(itemModel: widget.itemModel);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDurationControl({
    required String label,
    required int value,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onIncrease,
          onLongPressStart: (_) async {
            _isIncrementing = true;
            while (_isIncrementing && mounted) {
              onIncrease();
              await Future.delayed(const Duration(milliseconds: 60));
            }
          },
          onLongPressEnd: (_) {
            _isIncrementing = false;
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.keyboard_arrow_up, size: 24),
          ),
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onDecrease,
          onLongPressStart: (_) async {
            _isDecrementing = true;
            while (_isDecrementing && mounted) {
              onDecrease();
              await Future.delayed(const Duration(milliseconds: 60));
            }
          },
          onLongPressEnd: (_) {
            _isDecrementing = false;
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.keyboard_arrow_down, size: 24),
          ),
        ),
      ],
    );
  }
}
