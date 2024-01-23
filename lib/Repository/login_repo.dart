import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class LoginRepo {
  Future<ApiResults> loginData(
    String userid,
    String password,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().postData(endPoint: loginAPI, data: {
      'username': userid,
      'password': password,
    });
  }
}
