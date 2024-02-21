import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';

class PitchroomRepository {
  Future<ApiResults> getPitchroomData(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: getpitchroomlistAPI, data: {});
  }

  Future<ApiResults> getuserswithroleData(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: getuserswithroleAPI, data: {});
  }

  Future<ApiResults> CreatePitchroom(
    String userId,
    String roomname,
    String description,
    String shareduser,
    String pitchdeck,
    String pitchdeckdoctype,
    String projections,
    String projectiondoctype,
    String executivesummary,
    String executivesummarydoctype,
    String expirydate,
  ) async {
    return await sl<MyDio>().postData(endPoint: createpitchroomAPI, data: {
      'room_name': roomname,
      'description': description,
      'shared_user': shareduser,
      'pitch_deck': pitchdeck,
      'pitch_deck_doc_type': pitchdeckdoctype,
      'projections': projections,
      'projection_doc_type': projectiondoctype,
      'executive_summary': executivesummary,
      'executive_summary_doc_type': executivesummarydoctype,
      'expiry_date': expirydate
    });
  }
}
