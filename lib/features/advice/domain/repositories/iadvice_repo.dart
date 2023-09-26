import 'package:clean_architecture/features/advice/domain/entities/advice_entity.dart';
import 'package:clean_architecture/features/advice/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
