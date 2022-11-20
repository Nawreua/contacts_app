import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  String? name;
  String? surname;
  int? age;
  bool? favorite;
}
