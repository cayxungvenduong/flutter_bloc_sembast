import '../models/fruits.dart';
import '../utils/app_database.dart';
import 'package:sembast/sembast.dart';

class FruitDao {
  static const String FRUIT_STORE_NAME = "fruit";

  final _fruitStore = intMapStoreFactory.store(FRUIT_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Fruit fruit) async {
    await _fruitStore.add(await _db, fruit.toMap());
  }

  Future update(Fruit fruit) async {
    final finder = Finder(filter: Filter.byKey(fruit.id));
    await _fruitStore.update(await _db, fruit.toMap(), finder: finder);
  }

  Future delete(Fruit fruit) async {
    final finder = Finder(filter: Filter.byKey(fruit.id));
    await _fruitStore.delete(await _db, finder: finder);
  }

  Future<List<Fruit>> getAllSortedByName() async {
//    final finder = Finder(sortOrders: [SortOrder("name")]);
    final recordSnapshot = await _fruitStore.find(await _db);
    return recordSnapshot.map((snapshot) {
      final fruit = Fruit.fromMap(snapshot.value);
      fruit.id = snapshot.key;
      return fruit;
    }).toList();
  }
}
