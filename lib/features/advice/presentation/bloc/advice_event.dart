part of 'advice_bloc.dart';

sealed class AdviceEvent extends Equatable {
  const AdviceEvent();

  @override
  List<Object> get props => [];
}

final class AdviceGetEvent extends AdviceEvent {}
