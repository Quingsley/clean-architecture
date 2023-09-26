import 'package:clean_architecture/features/advice/data/datasources/remote_data_sources.dart';
import 'package:clean_architecture/features/advice/data/exceptions/exceptions.dart';
import 'package:clean_architecture/features/advice/domain/entities/advice_entity.dart';
import 'package:clean_architecture/features/advice/domain/failures/failures.dart';
import 'package:clean_architecture/features/advice/domain/repositories/iadvice_repo.dart';
import 'package:dartz/dartz.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceRemoteDataSourceImpl adviceDataSource;

  AdviceRepositoryImpl({required this.adviceDataSource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      var data = await adviceDataSource.getRandomAdvice();
      return right(data);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
