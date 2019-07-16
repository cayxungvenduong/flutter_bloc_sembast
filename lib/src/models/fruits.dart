import 'package:meta/meta.dart';

class Fruit {
  int id;

  final String name;
  final bool isBig;

  Fruit({@required this.name, @required this.isBig});

  Map<String, dynamic> toMap() {
    print(name);
    return {"name": this.name, "isBig": this.isBig};
  }

  static Fruit fromMap(Map<String, dynamic> map) {
    if (!(map is Map<String, dynamic>)) {
      return null;
    } else
      return Fruit(name: map["name"], isBig: map["isBig"]);
  }
}
