import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class RegisterRepo {
  Future<ApiResults> createRegisterData(
    String firstname,
    String userid,
    String phoneno,
    String password,
    String usertype,
    String logintype,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().postData(endPoint: registerAPI, data: {
      'user_id': userid,
      'password': password,
      'user_type': usertype,
      'first_name': firstname,
      'phone_no': phoneno,
      'login_type': logintype
    });
  }
}
