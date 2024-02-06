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

  String get mDashboard;
  String get mCommunityFeed;
  String get mPitchCraft;
  String get mMyServices;
  String get mServices;
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
}
