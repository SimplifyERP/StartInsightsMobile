import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get mLoginTextOne;
  String get mLoginTextTwo;
  String get mLoginTextThree;
  String get mLoginTextFour;
  String get mWelcom;
  String get mAccountRegister;
  String get mLoginnow;
  String get mAlreadyaccount;
  String get mName;
  String get mEnterName;
  String get mEmailAddress;

  String get mEmailAddresshint;
  String get mVaildEmailAddresshint;

  String get mMobile;
  String get mEnterMobile;
  String get rupess => "₹";
  String get mType;
  String get mSelectType;
  String get mCreatePassword;
  String get mConfirmPassword;
  String get mEnterPassword;
  String get mEnterConfirmPassword;
  String get mConfirmPasswordnotmatch;
  String get mStaysignedin;
  String get mForgotpassword;
  String get mregister;
  String get mor;
  String get mContinuewithTwitter;
  String get mContinuewithGmail;
  String get mContinuewithFacebook;

  String get mPassword;
  String get mLogin;
  String get mnoaccount;

  String get mNotification;
  String get mLivechat;
  String get mUpgrade;

  String get mCommunityFeed;
  String get mPitchCraft;
  String get mMyServices;

  String get mStartupSchool;
  String get mBookanExpert;
  String get mHireourteam;
  String get mContactUs;
  String get mBAngelInvesting;
  String get mInvestmentDeals;

  String get mStartX;
  String get mCourses;
  String get mSavedCourses;

  String get mStart;
  String get mSave;
  String get mRemove;
  String get mMyCourses;
  String get mSlash;
  String get mBasicsofPitching;
  String get mDescription;
  String get mCourseDetails;
  String get mService;

  String get mEventStart;
  String get mEventend;
  String get mEventStarttime;
  String get mEventendtime;

  String get mEarnedBadges;
  String get mStartupAspirant;
  String get mYouearnedabadge;
  String get mKnowMore;

  String get mBenefits;
  String get mDocuments;
  String get mDeliverables;
  String get mdocumentsrequired;

  String get mCancel;
  String get mGetStarted;
  String get mMockPitch;
  String get mGold;
  String get mDocumentCreated;
  String get mStartupCourseCompleted;
  String get mServiceCompleted;
  String get mExpertBooked;
  String get mViewDetails;
  String get mAbout;
  String get mFounders;
  String get minvestmentdetails;
  String get mPreview;
  String get mnoPreview;
  String get mPurchase;
  String get mDownloadcerificate;
  String get mStartupDeals;
  String get mFeatured;
  String get mPopular;
  String get mGetDeal;
  String get myourredeem;
  String get mCopiedsuccessfully;
  String get mPitchRoom;
  String get mViewRoom;
  String get mShare;
  String get mCreateNew;
  String get mCreateNewRoom;
  String get mRoomName;
  String get mEnterRoomName;
  String get mShortDescription;
  String get mUploadDocument;
  String get mSelectfilesfromhere;
  String get mValidformet;
  String get morr;
  String get mSelectFiles;
  String get mSharethisroom;
  String get mPeople;
  String get mSubmit;
  String get mAddPeople;
  String get mbacktocourses;
  String get mcertification;
  String get mPrevious;
  String get mNext;
  String get mSelectpitchdeckfiles;
  String get mSelectexecutivesummaryfiles;
  String get mSelectprojectionsfiles;
  String get mok;
  String get mexpirydate;
  String get menterroomname;
  String get menterroomdescription;
  String get mselectpitchdeckfile;
  String get mselectprojectionsfile;
  String get mselectexecutivesummaryfile;
  String get maddpeoples;
  String get mselectroomexpiredate;
  String get mCaptable;
  String get mCaptableOverview;
  String get mCaptableDetails;

  String get mInvestorwise;
  String get mRoundwise;
  String get mAddFundingRound;

  String get mInvestorName;
  String get mTagName;
  String get mDateofAllotment;
  String get mInvestedRound;
  String get mAmountInvested;
  String get mDistinctiveShareNo;
  String get mShareCertificate;
  String get mSharesAllotted;
  String get mPricePerShare;
  String get mFullyDilutedShares;
  String get mClassOfShares;
  String get mFolioNumber;
  String get mShareholding;
  String get mCreationPersonID;

  String get mNameoftheround;
  String get mRoundType;
  String get mClosingdateoftheRound;
  String get mRoundDescription;
  String get mSelectSecurityPrefix;
  String get mAmountRaised;
  String get mPricepershare;
  String get mPreMoneyValuation;
  String get mDilutionforthisround;

  String get mtagname;
  String get mentertagname;
  String get mselectDateofAllotment;
  String get menterInvestedRound;
  String get menterAmountInvested;
  String get menterDistinctiveShareNo;
  String get menterSharesAllotted;
  String get menterPricePerShare;
  String get menterFullyDilutedShares;
  String get menterClassOfShares;
  String get menterFolioNumber;
  String get menterShareholding;
  String get mUploadedDocument;

  String get mpitchdeckfiles;
  String get mexecutivesummaryfiles;
  String get mprojectionsfiles;
  String get mshareduser;
  String get mInvestorOverview;
  String get mRoundwiseOverview;
  String get mInvestorCaptableDetails;
  String get mRoundwiseCaptableDetails;
  String get mpasswordMessage;
  String get mLogout;
  String get mprofile;
  String get mProfilePicture;
  String get mUpdateProfileDetails;
  String get mEmail;
  String get mLinkedInURL;
  String get mCompanyName;
  String get mDesignation;
  String get mEnterDesignation;

  String get mChangePassword;
  String get mCurrentPassword;
  String get mNewPassword;
  String get mRetypenewPassword;
  String get mAlreadyRedeemed;
  String get mlinkedin;
  String get mcompanyname;
  String get mentercompanyname;
  String get search;
  String get mvideomessage;

  String get mGeography;
  String get minvestors;
  String get mChecks;
  String get mStages;
  String get mInvestmentthesis;
  String get mOpenrate;

  String get mHireOurExperts;
  String get mHireOurExpertsMsg;
  String get mFundraisingExperts;

  //Sidemenu
  String get mDashboard;
  String get mFundraising;
  String get mResources;
  String get mServices;
  String get mTools;
  String get mHi;
  String get mWelcomeback;
  String get mRecommendedInvestors;
  String get mCheckyourFundability;
  String get mCheckyourScore;
  String get mReviewYouPitchDeck;
  String get mBuildyourPitchroom;
  String get mUploadyourpitchdeckordraganddrophere;
  String get mAcceptsPDFfilesupto;

  String get mSearchInvestors;
  String get mFundingCRM;
  String get mFundraisinglink;
  String get msearchhint;
  String get mSearchResult;

  String get mRoundsize;
  String get mEarlystage;
  String get mIndia;
  String get mInvestorsFound;
}
