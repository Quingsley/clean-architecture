import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/features/advice/domain/entities/advice_entity.dart';
import 'package:clean_architecture/features/advice/domain/failures/failures.dart';
import 'package:clean_architecture/features/advice/domain/usecases/advice_usecase.dart';
import 'package:clean_architecture/features/advice/presentation/cubit/advice_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCase extends Mock implements AdviceUseCase {}

void main() {
  group('Advice Cubit', () {
    group('should emit', () {
      MockAdviceUseCase mockAdviceUseCase = MockAdviceUseCase();
      blocTest('nothing when a method is called',
          build: () => AdviceCubit(adviceUseCase: mockAdviceUseCase),
          expect: () => <AdviceCubitState>[]);
      blocTest(
        '[AdviceLoadingState], [AdviceLoadedState] when [AdviceGetEvent] is added',
        setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: 'test', id: 1),
            ),
          ),
        ),
        build: () => AdviceCubit(adviceUseCase: mockAdviceUseCase),
        act: (cubit) => cubit.getAdvice(),
        expect: () => <AdviceCubitState>[
          AdviceLoadingState(),
          const AdviceLoadedState(advice: 'test'),
        ],
      );
    });
  });
}
