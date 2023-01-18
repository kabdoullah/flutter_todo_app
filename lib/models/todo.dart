import 'package:hive/hive.dart';
import '../blocs/bloc_export.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends  HiveObject{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  bool? isDone;
  @HiveField(4)
  bool? isDeleted;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      this.isDone,
      this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Todo copyWith(
      {String? id,
      String? title,
      String? description,
      bool? isDone,
      bool? isDeleted}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted);
  }

}
