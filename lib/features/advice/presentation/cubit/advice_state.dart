part of 'advice_cubit.dart';

sealed class AdviceCubitState extends Equatable {
  const AdviceCubitState();

  @override
  List<Object> get props => [];
}

final class AdviceInitial extends AdviceCubitState {}

final class AdviceLoadingState extends AdviceCubitState {}

final class AdviceLoadedState extends AdviceCubitState {
  final String advice;

  const AdviceLoadedState({required this.advice});
  @override
  List<Object> get props => [advice];
}

final class AdviceErrorState extends AdviceCubitState {
  final String message;

  const AdviceErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
