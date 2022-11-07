// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentcourse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentCourseAdapter extends TypeAdapter<StudentCourse> {
  @override
  final int typeId = 1;

  @override
  StudentCourse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentCourse(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentCourse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.noOfVideos)
      ..writeByte(3)
      ..write(obj.skillId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentCourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
