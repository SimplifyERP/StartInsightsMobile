import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class ProfileRepo {
  Future<ApiResults> ProfileUpdate(
    String firstname,
    String userid,
    String phoneno,
    String designation,
    String companyname,
    String linkedin,
    String image,
    String usertype,
  ) async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().postData(endPoint: updateprofileAPI, data: {
      'user_id': userid,
      'full_name': firstname,
      'email_id': userid,
      'phone_no': phoneno,
      'company_name': companyname,
      'designation': designation,
      'linkedin': linkedin,
      'image': image,
      'user_type': usertype
    });
  }
}
