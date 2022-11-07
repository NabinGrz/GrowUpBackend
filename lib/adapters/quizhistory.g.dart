// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quizhistory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizHistoryAdapter extends TypeAdapter<QuizHistory> {
  @override
  final int typeId = 0;

  @override
  QuizHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizHistory(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuizHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.quizname)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.timetaken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
