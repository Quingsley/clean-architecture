import 'package:clean_architecture/features/advice/domain/failures/failures.dart';
import 'package:clean_architecture/features/advice/domain/usecases/advice_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit({required this.adviceUseCase}) : super(AdviceInitial());

  final AdviceUseCase adviceUseCase;
  Future<void> getAdvice() async {
    emit(AdviceLoadingState());
    // will execute our domain logic
    final failureOrAdvice = await adviceUseCase.getAdvice();
    String mapFailureToMessage(Failure f) {
      switch (f.runtimeType) {
        case ServerFailure:
          return 'Something went wrong, Please try again later';
        case CacheFailure:
          return 'Something went wrong, Cache Failed, Please try again later';
        default:
          return 'Something went wrong';
      }
    }

    failureOrAdvice.fold(
      (failure) =>
          emit(AdviceErrorState(message: mapFailureToMessage(failure))),
      (adviceEntity) => emit(AdviceLoadedState(advice: adviceEntity.advice)),
    );
  }
}
