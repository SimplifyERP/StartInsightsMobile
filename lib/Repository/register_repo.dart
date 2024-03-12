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
    String firstname,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().postData(endPoint: createUserFinishAPI, data: {
      'email_id': userid,
      'full_name': firstname,
      'mobile_no': phoneno,
      'type_of_user': usertype,
      'password': password
    });
  }

  Future<ApiResults> InvestorsAccount(
    String userid,
    String phoneno,
    String usertype,
    String password,
    String firstname,
    String verifycode,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>()
        .postData(endPoint: createInvestorsAccountAPI, data: {
      'email_id': userid,
      'full_name': firstname,
      'mobile_no': phoneno,
      'type_of_user': usertype,
      'password': password,
      'verify_code': verifycode
    });
  }
}
