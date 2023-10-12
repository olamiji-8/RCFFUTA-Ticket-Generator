// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../models/response.dart';
import '../models/user_model.dart';

abstract class IDownloadQrDatasource {
  Future<Either<SuccessResponse, FailureResponse>> getProfile(String user);
}

class HomeDatasource extends IDownloadQrDatasource {
  final http.Client httpClient;
  HomeDatasource({
    required this.httpClient,
  });
  @override
  Future<Either<SuccessResponse, FailureResponse>> getProfile(
      String user) async {
    try {
      final result =
          await httpClient.get(Uri.parse('https://api.github.com/users/$user'));
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        return Left(SuccessResponse(user: UserModel.fromMap(data)));
      } else {
        return Right(FailureResponse(message: 'Falha'));
      }
    } on Exception {
      return Right(FailureResponse(message: 'Tente Novamente'));
    }
  }
}
