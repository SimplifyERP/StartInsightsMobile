import 'dart:convert';

import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';
import 'package:startinsights/Screen/Service/web/searchlist.dart';

class PitchcraftListRepo {
  Future<ApiResults> getPitchcraftList(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: servicelistAPI, data: {
      'user_id': userId,
    });
  }

  Future<ApiResults> getServicedetails(
    String userId,
    String serviceid,
  ) async {
    return await sl<MyDio>().postData(endPoint: servicedetailsAPI, data: {
      'user_id': userId,
      'my_service_id': serviceid,
    });
  }

  Future<ApiResults> getPitchcraftservicedetails(
    String userId,
    String name,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: pitchcraftservicedetailsAPI, data: {
      'name': name,
    });
  }

  Future<ApiResults> Pitchcraftservicepayment(
    String userId,
    String pitchcraftid,
    String date,
    String paymentid,
    String amount,
  ) async {
    return await sl<MyDio>().postData(endPoint: makeservicepaymentAPI, data: {
      'service_id': pitchcraftid,
      'user': userId,
      'date': date,
      'payment_id': paymentid,
      'amount': amount,
    });
  }

  Future<ApiResults> myservicesdocupload(
      String myserviceid, List<UploadDoc> json) async {
    return await sl<MyDio>().postData(endPoint: servicesdocupload, data: {
      'my_service_id': myserviceid,
      'upload_doc': jsonEncode(json),
    });
  }
}
