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
    String companyname,
    String linkedin,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().postData(endPoint: registerAPI, data: {
      'user_id': userid,
      'password': password,
      'user_type': usertype,
      'first_name': firstname,
      'phone_no': phoneno,
      'login_type': logintype,
      'linkedin': companyname,
      'company_name': linkedin
    });
  }

  Future<ApiResults> CreateAccount(
    String firstname,
    String phoneno,
    String emailid,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().postData(endPoint: createUserAPI, data: {
      'full_name': firstname,
      'mobile_no': phoneno,
      'email_id': emailid
    });
  }

  Future<ApiResults> CreateAccountFinish(
    String userid,
    String phoneno,
    String usertype,
    String password,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().postData(endPoint: createUserFinishAPI, data: {
      'user_id': userid,
      'phone_no': phoneno,
      'user_type': usertype,
      'password': password
    });
  }
}
