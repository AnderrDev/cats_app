part of 'cats_bloc.dart';

class CatsState {
  final List<Cat> cats;
  const CatsState({required this.cats});

  CatsState copyWith({
    required List<Cat>? cats,
  }) {
    return CatsState(
      cats: cats ?? this.cats,
    );
  }
}
