// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 2;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as int,
      routineID: fields[1] as int?,
      title: fields[2] as String,
      description: fields[3] as String?,
      type: fields[4] as TaskTypeEnum,
      taskDate: fields[5] as DateTime,
      time: fields[6] as TimeOfDay?,
      isNotificationOn: fields[7] as bool,
      currentDuration: fields[8] as Duration?,
      remainingDuration: fields[9] as Duration?,
      currentCount: fields[10] as int?,
      targetCount: fields[11] as int?,
      isTimerActive: fields[12] as bool?,
      attributeIDList: (fields[13] as List?)?.cast<int>(),
      skillIDList: (fields[14] as List?)?.cast<int>(),
      status: fields[15] as TaskStatusEnum?,
      priority: fields[16] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.routineID)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.taskDate)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.isNotificationOn)
      ..writeByte(8)
      ..write(obj.currentDuration)
      ..writeByte(9)
      ..write(obj.remainingDuration)
      ..writeByte(10)
      ..write(obj.currentCount)
      ..writeByte(11)
      ..write(obj.targetCount)
      ..writeByte(12)
      ..write(obj.isTimerActive)
      ..writeByte(13)
      ..write(obj.attributeIDList)
      ..writeByte(14)
      ..write(obj.skillIDList)
      ..writeByte(15)
      ..write(obj.status)
      ..writeByte(16)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
