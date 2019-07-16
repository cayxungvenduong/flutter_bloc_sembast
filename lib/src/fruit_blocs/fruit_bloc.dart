import 'package:bloc/bloc.dart';
import 'package:flutter_app/src/models/fruits.dart';
import '../daos/fruit_dao.dart';
import './fruit_event.dart';
import './fruit_state.dart';
import 'dart:async';
import 'dart:math';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  final FruitDao _fruitDao = FruitDao();

  @override
  FruitState get initialState => FruitLoading();

  @override
  Stream<FruitState> mapEventToState(FruitEvent event) async* {
    if (event is LoadFruits) {
      yield FruitLoading();
      yield* reloadFruit();
    } else if (event is AddRandomFruit) {
      final fruit = RandomFruitGenerator.getRandomFruit();
      await _fruitDao.insert(fruit);
      yield* reloadFruit();
    } else if (event is UpdateRandomFruit) {
      final newFruit = RandomFruitGenerator.getRandomFruit();
      newFruit.id = event.updateFruit.id;

      await _fruitDao.update(newFruit);
      yield* reloadFruit();
    } else if (event is DeleteFruit) {
      await _fruitDao.delete(event.fruit);
      yield* reloadFruit();
    }
  }

  Stream<FruitState> reloadFruit() async* {
    final fruits = await _fruitDao.getAllSortedByName();
    yield FruitLoaded(fruits);
  }
}

class RandomFruitGenerator {
  static final _fruits = [
    Fruit(name: 'Banana', isBig: true),
    Fruit(name: 'Strawberry', isBig: true),
    Fruit(name: 'Kiwi', isBig: false),
    Fruit(name: 'Apple', isBig: true),
    Fruit(name: 'Pear', isBig: true),
    Fruit(name: 'Lemon', isBig: false),
  ];

  static Fruit getRandomFruit() {
    return _fruits[Random().nextInt(_fruits.length)];
  }
}
