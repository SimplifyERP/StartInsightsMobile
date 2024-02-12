import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class BookanexpertListRepository {
  Future<ApiResults> getBookanexpertList(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: bookanexpertlistAPI, data: {});
  }

  Future<ApiResults> getexpertBooking(
    String expertId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: expertbookingAPI, data: {'expert_id': expertId});
  }

  Future<ApiResults> mExpertBookingpayment(
    String expertname,
    String servicedate,
    String starttime,
    String endtime,
    String bookingid,
    String userId,
    String paymentid,
    String amount,
  ) async {
    return await sl<MyDio>().postData(endPoint: createservicelistAPI, data: {
      'expert_name': expertname,
      'service_date': servicedate,
      'start_time': starttime,
      'end_time': endtime,
      'booking_id': bookingid,
      'user': userId,
      'payment_id': paymentid,
      'amount': amount
    });
  }
}
