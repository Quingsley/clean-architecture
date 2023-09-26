import 'package:clean_architecture/features/advice/data/datasources/remote_data_sources.dart';
import 'package:clean_architecture/features/advice/data/exceptions/exceptions.dart';
import 'package:clean_architecture/features/advice/data/models/advice_model.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('Testing Remote Data Source', () {
    final MockClient mockClient = MockClient();
    group('Should return adviceModel', () {
      test('When client response was 200 and returned valid data', () async {
        const responseBody = '{"advice": "test_advice", "advice_id": 1}';
        final remoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        when(mockClient
            .get(Uri.parse('https://api.flutter-community.com/api/v1/advice'),
                headers: {'Content-Type': 'application/json'})).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        final result = await remoteDataSourceUnderTest.getRandomAdvice();

        expect(result, AdviceModel(advice: 'test_advice', id: 1));
      });
    });
    group('should throw an error', () {
      test(
          'Should throw a server exception when response status code is not 200',
          () {
        final MockClient mockClient = MockClient();
        final remoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        when(mockClient.get(
                Uri.parse('https://api.flutter-community.com/api/v1/advice'),
                headers: {'Content-Type': 'application/json'}))
            .thenAnswer((realInvocation) => Future.value(Response('', 201)));
        expect(() async => await remoteDataSourceUnderTest.getRandomAdvice(),
            throwsA(isA<ServerException>()));
      });
      test('Should throw a Format exception when invalid json is returned', () {
        final MockClient mockClient = MockClient();
        final remoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = '{"advice": "test_advice"}';
        when(mockClient
            .get(Uri.parse('https://api.flutter-community.com/api/v1/advice'),
                headers: {'Content-Type': 'application/json'})).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));
        expect(() async => await remoteDataSourceUnderTest.getRandomAdvice(),
            throwsA(isA<FormatException>()));
      });
    });
  });
}
