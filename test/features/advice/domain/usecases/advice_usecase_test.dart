import 'package:clean_architecture/features/advice/data/exceptions/exceptions.dart';
import 'package:clean_architecture/features/advice/data/models/advice_model.dart';
import 'package:clean_architecture/features/advice/data/repository/advice_repo_impl.dart';
import 'package:clean_architecture/features/advice/domain/entities/advice_entity.dart';
import 'package:clean_architecture/features/advice/domain/failures/failures.dart';
import 'package:clean_architecture/features/advice/domain/repositories/iadvice_repo.dart';
import 'package:clean_architecture/features/advice/domain/usecases/advice_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepositoryImpl>()])
void main() {
  group('Advice Use case', () {
    group('should return', () {
      test('an advice entity from the repository', () async {
        final mockAdviceRepository = MockAdviceRepositoryImpl();
        final adviceUseCaseUnderTest =
            AdviceUseCase(adviceRepo: mockAdviceRepository);

        when(mockAdviceRepository.getAdviceFromDataSource()).thenAnswer(
          (realInvocation) => Future.value(
            const Right(
              AdviceEntity(advice: 'test', id: 12),
            ),
          ),
        );

        final result = await adviceUseCaseUnderTest.getAdvice();

        expect(result.isRight(), true);
        expect(result.isLeft(), false);
      });
    });
    group('should return', () {
      test('an exception when a server exception occurs', () async {
        final mockAdviceRepository = MockAdviceRepositoryImpl();
        final adviceUseCaseUnderTest =
            AdviceUseCase(adviceRepo: mockAdviceRepository);

        when(mockAdviceRepository.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));
        final result = await adviceUseCaseUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });
    });
  });
}
