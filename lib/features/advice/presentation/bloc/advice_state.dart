part of 'advice_bloc.dart';

sealed class AdviceState extends Equatable {
  const AdviceState();

  @override
  List<Object> get props => [];
}

final class AdviceInitial extends AdviceState {}

final class AdviceLoadingState extends AdviceState {}

final class AdviceLoadedState extends AdviceState {
  final String advice;

  const AdviceLoadedState({required this.advice});
  @override
  List<Object> get props => [advice];
}

final class AdviceErrorState extends AdviceState {
  final String message;

  const AdviceErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
