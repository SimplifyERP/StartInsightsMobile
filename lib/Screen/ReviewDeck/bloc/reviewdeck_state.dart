//

abstract class ReviewDeckStatus {}

class ReviewDeckInitialState extends ReviewDeckStatus {}

class ReviewDeckLoadingState extends ReviewDeckStatus {}

class ReviewDeckNointernetState extends ReviewDeckStatus {}

class GetReviewDeckInfoFailState extends ReviewDeckStatus {
  //final String mMessage;
  GetReviewDeckInfoFailState();
}

class GetReviewDeckInfoSuccessState extends ReviewDeckStatus {
  GetReviewDeckInfoSuccessState();
}
