part of 'cats_bloc.dart';

abstract class CatsEvent {}

class GetCats extends CatsEvent {}


class LoadCats extends CatsEvent {
  final List<Cat> cats;
  LoadCats({required this.cats});
}

class LoadCatImages extends CatsEvent {
  final String catId;
  LoadCatImages({required this.catId});
}
