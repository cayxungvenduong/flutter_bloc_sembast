import 'package:equatable/equatable.dart';
import 'package:flutter_app/src/models/fruits.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FruitEvent extends Equatable {
  FruitEvent([List props = const []]) : super(props);
}

class LoadFruits extends FruitEvent {}

class AddRandomFruit extends FruitEvent {}

class DeleteFruit extends FruitEvent {
  final Fruit fruit;

  DeleteFruit(this.fruit) : super([fruit]);
}

class UpdateRandomFruit extends FruitEvent {
  final Fruit updateFruit;

  UpdateRandomFruit(this.updateFruit) : super([updateFruit]);
}
