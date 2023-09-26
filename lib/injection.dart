import 'package:clean_architecture/features/advice/data/datasources/remote_data_sources.dart';
import 'package:clean_architecture/features/advice/data/repository/advice_repo_impl.dart';
import 'package:clean_architecture/features/advice/domain/usecases/advice_usecase.dart';
import 'package:clean_architecture/features/advice/presentation/cubit/advice_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.I;

Future<void> init() async {
// ! Data Layer

//ensure the return type specified in the generic is the same as the return type of the function
//like earlier we had serviceLocator.registerFactory<AdviceRemoteDataSource>(() => AdviceRemoteDataSourceImpl(client: serviceLocator())
  serviceLocator.registerFactory<AdviceRemoteDataSourceImpl>(
      () => AdviceRemoteDataSourceImpl(client: serviceLocator()));

  serviceLocator.registerFactory<AdviceRepositoryImpl>(
      () => AdviceRepositoryImpl(adviceDataSource: serviceLocator()));

// ! Domain Layer
  serviceLocator.registerFactory<AdviceUseCase>(
      () => AdviceUseCase(adviceRepo: serviceLocator()));

  // ! application Layer
  serviceLocator.registerFactory<AdviceCubit>(
      () => AdviceCubit(adviceUseCase: serviceLocator()));

  //! external

  serviceLocator.registerFactory(() => http.Client());
}
