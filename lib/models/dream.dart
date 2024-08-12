import 'package:isar/isar.dart';

part 'dream.g.dart';

@Collection()
class Dream {
  Id id = Isar.autoIncrement;
  late String content;
  late DateTime createdAt;
  String? aiAnalysis;
  String? feeling;
  String? category;
  bool? isLucid;
  List<String> tags = [];
}
