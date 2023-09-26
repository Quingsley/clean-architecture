import 'package:clean_architecture/features/advice/data/datasources/remote_data_sources.dart';
import 'package:clean_architecture/features/advice/data/exceptions/exceptions.dart';
import 'package:clean_architecture/features/advice/data/models/advice_model.dart';
import 'package:clean_architecture/features/advice/data/repository/advice_repo_impl.dart';
import 'package:clean_architecture/features/advice/domain/entities/advice_entity.dart';
import 'package:clean_architecture/features/advice/domain/failures/failures.dart';
import 'package:clean_architecture/features/advice/domain/repositories/iadvice_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group('Advice Repository', () {
    group('Should return an advice entity', () {
      test('When remote data source returns an Advice Model', () async {
        final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
        final AdviceRepository adviceRepoUnderTest =
            AdviceRepositoryImpl(adviceDataSource: mockAdviceRemoteDataSource);

        when(mockAdviceRemoteDataSource.getRandomAdvice()).thenAnswer(
          (realInvocation) => Future.value(
            AdviceModel(
              advice: 'test',
              id: 43,
            ),
          ),
        );
        final result = await adviceRepoUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(result,
            Right<Failure, AdviceEntity>(AdviceModel(advice: 'test', id: 43)));
        verify(mockAdviceRemoteDataSource.getRandomAdvice()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDataSource);
      });
    });

    group('should return left with', () {
      test('a Server failure when a ServerException occurs', () async {
        final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
        final AdviceRepository adviceRepoUnderTest =
            AdviceRepositoryImpl(adviceDataSource: mockAdviceRemoteDataSource);

        when(mockAdviceRemoteDataSource.getRandomAdvice())
            .thenThrow(ServerException());
        final result = await adviceRepoUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });
    });
  });
}
