import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../domain/usecases/get_home_data.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase getHomeData;

  HomeBloc({required this.getHomeData}) : super(HomeInitial()) {
    on<LoadHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      final failureOrData = await getHomeData();
      failureOrData.fold(
        (failure) => emit(HomeError(message: failure.message)),
        (data) => emit(HomeLoaded(homeData: data)),
      );
    });
  }
}
