// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineModelAdapter extends TypeAdapter<RoutineModel> {
  @override
  final int typeId = 4;

  @override
  RoutineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineModel(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String?,
      type: fields[3] as TaskTypeEnum,
      createdDate: fields[4] as DateTime,
      startDate: fields[5] as DateTime,
      time: fields[6] as TimeOfDay?,
      isNotificationOn: fields[7] as bool,
      remainingDuration: fields[8] as Duration?,
      targetCount: fields[9] as int?,
      repeatDays: (fields[10] as List).cast<int>(),
      attirbuteIDList: (fields[11] as List?)?.cast<int>(),
      skillIDList: (fields[12] as List?)?.cast<int>(),
      isCompleted: fields[13] as bool,
      priority: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RoutineModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.createdDate)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.isNotificationOn)
      ..writeByte(8)
      ..write(obj.remainingDuration)
      ..writeByte(9)
      ..write(obj.targetCount)
      ..writeByte(10)
      ..write(obj.repeatDays)
      ..writeByte(11)
      ..write(obj.attirbuteIDList)
      ..writeByte(12)
      ..write(obj.skillIDList)
      ..writeByte(13)
      ..write(obj.isCompleted)
      ..writeByte(14)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
