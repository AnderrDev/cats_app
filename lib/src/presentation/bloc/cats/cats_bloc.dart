import 'package:cats_app/src/domain/models/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../infrastructure/repositories/the_cat_api_repository_impl.dart';
part 'cats_event.dart';
part 'cats.state.dart';

class CatsBloc extends Bloc<CatsEvent, CatsState> {
  final catsRepo = GetIt.I<CatsRepositoryImpl>();

  CatsBloc() : super(const CatsState(cats: [])) {
    on<LoadCats>((event, emit) async {
      _loadCats(event, emit);
    });
  }

  Future<void> _loadCats(event, emit) async {
    await catsRepo.getCats();
  }
}
