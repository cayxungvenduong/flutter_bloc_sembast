import 'package:meta/meta.dart';
import '../models/fruits.dart';
import 'package:equatable/equatable.dart';

@immutable
class FruitState extends Equatable {
  FruitState([List props = const []]) : super(props);
}

class FruitLoading extends FruitState {}

class FruitLoaded extends FruitState {
  final List<Fruit> fruits;

  FruitLoaded(this.fruits) : super(fruits);
}
