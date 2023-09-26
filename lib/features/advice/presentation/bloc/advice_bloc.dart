import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceInitial()) {
    on<AdviceGetEvent>((event, emit) async {
      emit(AdviceLoadingState());
      await Future.delayed(
          const Duration(seconds: 1)); // will execute our domain logic
      // emit(const AdviceLoadedState(advice: 'Fake advice testing'));
      emit(const AdviceErrorState(message: 'Error message'));
    });
  }
}
