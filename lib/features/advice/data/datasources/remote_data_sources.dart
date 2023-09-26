import 'dart:convert';

import 'package:clean_architecture/features/advice/data/exceptions/exceptions.dart';
import 'package:clean_architecture/features/advice/data/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDataSource {
  /// Calls api to get random advice and returns [AdviceModel]
  /// Throws [ServerException] for all error codes
  Future<AdviceModel> getRandomAdvice();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client;

  AdviceRemoteDataSourceImpl({required this.client});

  @override
  Future<AdviceModel> getRandomAdvice() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final data = jsonDecode(response.body);
      return AdviceModel.fromJSON(data);
    }
  }
}
