import 'dart:convert';

import 'package:startinsights/Network/api_result_handler.dart';
import 'package:startinsights/Network/di.dart';
import 'package:startinsights/Network/endpoints.dart';
import 'package:startinsights/Network/my_dio.dart';
import 'package:startinsights/Screen/PitchRoom/web/newpitchroom.dart';

class PitchroomRepository {
  Future<ApiResults> getPitchroomData(
    String userId,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: getpitchroomlistAPI, data: {'user_id': userId});
  }

  Future<ApiResults> getuserswithroleData(
    String userId,
  ) async {
    return await sl<MyDio>().postData(endPoint: getuserswithroleAPI, data: {});
  }

  Future<ApiResults> CreateRoom(
    String userid,
    String pitchroomname,
    String aboutstartup,
    String coverimage,
  ) async {
    return await sl<MyDio>().postData(endPoint: createpitchroomAPI, data: {
      'pitch_room_name': pitchroomname,
      'about_startup': aboutstartup,
      'user_id': userid,
      'cover_image': coverimage
    });
  }

  Future<ApiResults> UpdateCreateRoom(
      String roomid,
      String notes,
      String aboutstartup,
      String mCompanyname,
      String mRoomname,
      String mCoverimage,
      List<UploadFiles> json) async {
    return await sl<MyDio>().postData(endPoint: updateRoomAPI, data: {
      'room_id': roomid,
      'notes': notes,
      'pitch_room_documents': jsonEncode(json),
    });
  }

  Future<ApiResults> mSharedUser(
      String roomid, String notes, List<String> json) async {
    return await sl<MyDio>().postData(endPoint: shareduserAPI, data: {
      'pitch_room_id': roomid,
      'notes': notes,
      'user_ids': jsonEncode(json),
    });
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
    final map = <String, dynamic>{};
    map['room_name'] = roomname;
    map['description'] = description;
    map['shared_user'] = shareduser;
    map['pitch_deck'] = pitchdeck;
    map['pitch_deck_doc_type'] = pitchdeckdoctype;
    map['projections'] = projections;
    map['projection_doc_type'] = projectiondoctype;
    map['executive_summary'] = executivesummary;
    map['executive_summary_doc_type'] = executivesummarydoctype;
    map['expiry_date'] = expirydate;

    return await sl<MyDio>().postData(endPoint: createpitchroomAPI, data: map

        /*{
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
    }*/

        );
  }
}
