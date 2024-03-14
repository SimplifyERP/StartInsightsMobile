import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class DashboardRepo {
  Future<ApiResults> mDashboard() async {
    // email = 'vivekchamp84@gmail.com';
    // password = 'vivek@123';
    return await sl<MyDio>().getData(endPoint: DashboardAPI);
  }

  Future<ApiResults> ProfileUpdate(
    String firstname,
    String phoneno,
    String emailid,
    String designation,
    String companyname,
    String linkedin,
    String website,
    String profileimage,
    String password,
  ) async {
    return await sl<MyDio>().postData(endPoint: updateprofileAPI, data: {
      'full_name': firstname,
      'mobile_no': phoneno,
      'email_id': emailid,
      'designation': designation,
      'company_name': companyname,
      'linkedin': linkedin,
      'website': website,
      'profile_image': profileimage,
      'password': password
    });
  }
}
