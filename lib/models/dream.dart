import 'package:isar/isar.dart';

part 'dream.g.dart'; //line needed to generate file.
//then run: dart run build_runner build

@Collection() // class is a collection in the Isar database.. just helps Isar to understand how to seralize objects before storing and for CRUD operations
class Dream {
  Id id = Isar.autoIncrement;
  late String content;
  late DateTime createdAt;
  late String photoPath;
  late String feeling;
  late String category;
  late bool isLucid;
  
  List<String> tags = [];
}