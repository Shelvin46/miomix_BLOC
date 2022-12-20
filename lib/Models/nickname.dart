import 'package:hive/hive.dart';
part 'nickname.g.dart';

@HiveType(typeId: 5)
class nickName {
  @HiveField(0)
  String? name;

  nickName({
    required this.name,
  });
}
