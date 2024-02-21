//

import 'package:startinsights/Model/PitchroomlistResponse.dart';

abstract class PitchroomStatus {}

class PitchroomInitialState extends PitchroomStatus {}

class PitchroomLoadingState extends PitchroomStatus {}

class PitchroomNointernetState extends PitchroomStatus {}

class GetPitchroomInfoFailState extends PitchroomStatus {
  //final String mMessage;
  GetPitchroomInfoFailState();
}

class GetPitchroomInfoSuccessState extends PitchroomStatus {
  final List<PitchRoomDetail> mPitchRoomDetail;
  GetPitchroomInfoSuccessState(this.mPitchRoomDetail);
}
