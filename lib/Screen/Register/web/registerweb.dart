import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:startinsights/Localization/language/languages.dart';
import 'package:startinsights/Model/MastersResponse.dart';
import 'package:startinsights/Screen/Register/bloc/register_bloc.dart';
import 'package:startinsights/Screen/Register/bloc/register_state.dart';
import 'package:startinsights/Utils/MyColor.dart';
import 'package:startinsights/Utils/constant_methods.dart';
import 'package:startinsights/Utils/screens.dart';
import 'package:startinsights/Utils/utils.dart';
import 'package:startinsights/Widgets/auth_form_field.dart';
import 'package:startinsights/Widgets/mandatoryText.dart';
import 'package:startinsights/Widgets/primary_button.dart';

class RegisterWeb extends StatefulWidget {
  List<UserType> getUserType = <UserType>[];
  RegisterWeb({
    super.key,
    required this.getUserType,
  });

  @override
  State<RegisterWeb> createState() => _RegisterWebState();
}

class _RegisterWebState extends State<RegisterWeb> {
  @override
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController companynameController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  late RegisterBloc mRegisterBloc;
  bool checkedValue = false;

  var mTypeDropDownValue = "";
  bool passwordVisible = false;
  bool confirmpasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    companynameController.dispose();
    linkedinController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mRegisterBloc = RegisterBloc(mContext: context);

    void OnLoadNext() {
      Navigator.pushReplacementNamed(context, loginRoute);
    }

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        //Navigator.pop(context, false);

        OnLoadNext();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<RegisterBloc, RegisterStatus>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height +
                                                200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          gradient: const LinearGradient(
                                            colors: [mStartColor, mEndColor],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            tileMode: TileMode.repeated,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: Languages.of(
                                                                  context)!
                                                              .mLoginTextOne,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'ManropeBold',
                                                              fontSize: 26,
                                                              color:
                                                                  mBtnColor)),
                                                      TextSpan(
                                                          text: Languages.of(
                                                                  context)!
                                                              .mLoginTextTwo,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'ManropeBold',
                                                              fontSize: 26,
                                                              color:
                                                                  mBlackColor)),
                                                      TextSpan(
                                                          text: Languages.of(
                                                                  context)!
                                                              .mLoginTextThree,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'ManropeBold',
                                                              fontSize: 26,
                                                              color:
                                                                  mBtnColor)),
                                                      TextSpan(
                                                          text: Languages.of(
                                                                  context)!
                                                              .mLoginTextFour,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'ManropeBold',
                                                              fontSize: 26,
                                                              color:
                                                                  mBlackColor))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 7,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Image(
                                                  width: 400,
                                                  height: 400,
                                                  image: AssetImage(
                                                    "assets/loginicon.png",
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ))),
                                Expanded(
                                    flex: 5,
                                    child: SingleChildScrollView(
                                      child: Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 2.0,
                                                    left: 150.0,
                                                    right: 2.0),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          Languages.of(context)!
                                                              .mAccountRegister,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'ManropeBold',
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: mBlackColor,
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: Languages.of(
                                                                        context)!
                                                                    .mAlreadyaccount,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'ManropeLight',
                                                                    fontSize:
                                                                        24,
                                                                    color:
                                                                        mTextOneColor)),
                                                            const TextSpan(
                                                                text: " ",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'ManropeLight',
                                                                    fontSize:
                                                                        22,
                                                                    color:
                                                                        mTextOneColor)),
                                                            TextSpan(
                                                                text: Languages.of(
                                                                        context)!
                                                                    .mLoginnow,
                                                                recognizer: TapGestureRecognizer()
                                                                  ..onTap = () =>
                                                                      Navigator.pushReplacementNamed(
                                                                          context,
                                                                          loginRoute),
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'ManropeBold',
                                                                    fontSize:
                                                                        22,
                                                                    color:
                                                                        mBtnColor)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10,
                                                    left: 80,
                                                    right: 40),
                                                child: Column(children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MandatoryText(
                                                        mText: Languages.of(
                                                                context)!
                                                            .mName),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AuthFormField(
                                                      controller:
                                                          nameController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      hintText:
                                                          Languages.of(context)!
                                                              .mEnterName,
                                                      radius: 30,
                                                      maxLength: 80,
                                                      labelText:
                                                          Languages.of(context)!
                                                              .mEnterName,
                                                      mBorderView: false,
                                                      mImageView: true,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MandatoryText(
                                                        mText: Languages.of(
                                                                context)!
                                                            .mEmailAddress),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AuthFormField(
                                                      controller:
                                                          emailController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      hintText: Languages.of(
                                                              context)!
                                                          .mEmailAddresshint,
                                                      radius: 30,
                                                      maxLength: 80,
                                                      labelText: Languages.of(
                                                              context)!
                                                          .mEmailAddresshint,
                                                      mBorderView: false,
                                                      mImageView: true,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MandatoryText(
                                                        mText: Languages.of(
                                                                context)!
                                                            .mMobile),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AuthFormField(
                                                      controller:
                                                          mobileController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      hintText:
                                                          Languages.of(context)!
                                                              .mEnterMobile,
                                                      radius: 30,
                                                      maxLength: 10,
                                                      labelText:
                                                          Languages.of(context)!
                                                              .mEnterMobile,
                                                      mBorderView: false,
                                                      mImageView: true,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MandatoryText(
                                                        mText: Languages.of(
                                                                context)!
                                                            .mType),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: double.infinity,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: kTextBorder,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 0),
                                                      child:
                                                          DropdownButtonFormField(
                                                        hint: Text(
                                                            Languages.of(
                                                                    context)!
                                                                .mSelectType,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'OpenSansRegular')),
                                                        enableFeedback: true,

                                                        icon: const Icon(Icons
                                                            .arrow_drop_down_outlined),
                                                        iconSize: 30,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        // decoration: InputDecoration.collapsed(hintText: ''),
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              InputBorder.none,

                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 0,
                                                                  bottom: 10,
                                                                  left: 10,
                                                                  right:
                                                                      10), //this one
                                                        ),
                                                        dropdownColor:
                                                            Colors.white,

                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        elevation: 2,

                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            mTypeDropDownValue =
                                                                newValue!; //on selection, selectedDropDownValue i sUpdated
                                                          });
                                                        },

                                                        items: widget
                                                            .getUserType
                                                            .map((UserType
                                                                lang) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: lang.name,
                                                            child: Text(
                                                                lang.name!,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        'OpenSansRegular')),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MandatoryText(
                                                        mText: Languages.of(
                                                                context)!
                                                            .mCreatePassword),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller:
                                                            passwordController,
                                                        obscureText:
                                                            !passwordVisible,
                                                        maxLines: 1,
                                                        maxLength:
                                                            16, //This will obscure text dynamically
                                                        decoration:
                                                            InputDecoration(
                                                                counterText: "",
                                                                labelText:
                                                                    Languages.of(context)!
                                                                        .mPassword,
                                                                labelStyle: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        'ManropeMedium',
                                                                    color:
                                                                        kGray),
                                                                hintText: Languages.of(context)!
                                                                    .mPassword,
                                                                suffixIcon:
                                                                    IconButton(
                                                                  icon: Icon(
                                                                    // Based on passwordVisible state choose the icon
                                                                    passwordVisible
                                                                        ? Icons
                                                                            .visibility
                                                                        : Icons
                                                                            .visibility_off,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorDark,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // Update the state i.e. toogle the state of passwordVisible variable
                                                                    setState(
                                                                        () {
                                                                      passwordVisible =
                                                                          !passwordVisible;
                                                                    });
                                                                  },
                                                                ),
                                                                alignLabelWithHint:
                                                                    true,
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  color: kGray,
                                                                ),
                                                                isDense:
                                                                    true, // Added this

                                                                floatingLabelStyle:
                                                                    const TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                contentPadding:
                                                                    const EdgeInsets.fromLTRB(
                                                                        10,
                                                                        15,
                                                                        10,
                                                                        15),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8),
                                                                    borderSide: const BorderSide(
                                                                        color:
                                                                            kTextBorder,
                                                                        width: 1)),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              kTextBorder,
                                                                          width:
                                                                              1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: kTextBorder))))

                                                    /*AuthFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                maxLines: 1,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mPassword,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mPassword,
                                                mBorderView: false,
                                                mImageView: true,
                                              )*/
                                                    ,
                                                  ),
                                                  Text(
                                                      Languages.of(context)!
                                                          .mpasswordMessage,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'ManropeRegular',
                                                        fontSize: 12,
                                                        color: kGray,
                                                      )),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MandatoryText(
                                                        mText: Languages.of(
                                                                context)!
                                                            .mConfirmPassword),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller:
                                                            confirmpasswordController,
                                                        obscureText:
                                                            !confirmpasswordVisible,
                                                        maxLines: 1,
                                                        maxLength:
                                                            16, //This will obscure text dynamically
                                                        decoration:
                                                            InputDecoration(
                                                                counterText: "",
                                                                labelText:
                                                                    Languages.of(context)!
                                                                        .mPassword,
                                                                labelStyle: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        'ManropeMedium',
                                                                    color:
                                                                        kGray),
                                                                hintText: Languages.of(context)!
                                                                    .mPassword,
                                                                suffixIcon:
                                                                    IconButton(
                                                                  icon: Icon(
                                                                    confirmpasswordVisible
                                                                        ? Icons
                                                                            .visibility
                                                                        : Icons
                                                                            .visibility_off,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColorDark,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      confirmpasswordVisible =
                                                                          !confirmpasswordVisible;
                                                                    });
                                                                  },
                                                                ),
                                                                alignLabelWithHint:
                                                                    true,
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  color: kGray,
                                                                ),
                                                                isDense:
                                                                    true, // Added this

                                                                floatingLabelStyle:
                                                                    const TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                // floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                contentPadding:
                                                                    const EdgeInsets.fromLTRB(
                                                                        10,
                                                                        15,
                                                                        10,
                                                                        15),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8),
                                                                    borderSide: const BorderSide(
                                                                        color:
                                                                            kTextBorder,
                                                                        width: 1)),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              kTextBorder,
                                                                          width:
                                                                              1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: kTextBorder))))

                                                    /*AuthFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                maxLines: 1,
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.text,
                                                hintText: Languages.of(context)!
                                                    .mPassword,
                                                radius: 30,
                                                maxLength: 80,
                                                labelText:
                                                    Languages.of(context)!
                                                        .mPassword,
                                                mBorderView: false,
                                                mImageView: true,
                                              )*/
                                                    ,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MandatoryText(
                                                        mText: Languages.of(
                                                                context)!
                                                            .mcompanyname),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AuthFormField(
                                                      controller:
                                                          companynameController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      hintText: Languages.of(
                                                              context)!
                                                          .mentercompanyname,
                                                      radius: 30,
                                                      maxLength: 80,
                                                      labelText: Languages.of(
                                                              context)!
                                                          .mentercompanyname,
                                                      mBorderView: false,
                                                      mImageView: true,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      Languages.of(context)!
                                                          .mlinkedin,
                                                      style: const TextStyle(
                                                          color: mBlackColor,
                                                          fontFamily:
                                                              'ManropeRegular',
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AuthFormField(
                                                      controller:
                                                          linkedinController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      hintText:
                                                          Languages.of(context)!
                                                              .mlinkedin,
                                                      radius: 30,
                                                      maxLength: 80,
                                                      labelText:
                                                          Languages.of(context)!
                                                              .mlinkedin,
                                                      mBorderView: false,
                                                      mImageView: true,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                ]),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: 300,
                                                  child: PrimaryButton(
                                                      mButtonname:
                                                          Languages.of(context)!
                                                              .mregister,
                                                      onpressed: () {
                                                        if (nameController
                                                            .text.isEmpty) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mEnterName);
                                                        } else if (emailController
                                                            .text.isEmpty) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mVaildEmailAddresshint);
                                                        } else if (!emailController
                                                            .text
                                                            .isValidEmail()) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mVaildEmailAddresshint);
                                                        } else if (mobileController
                                                            .text.isEmpty) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mEnterMobile);
                                                        } else if (!isMobileNumberValid(
                                                            mobileController
                                                                .text)) {
                                                          ErrorToast(
                                                              context: context,
                                                              text:
                                                                  "Not Valid  Mobile");
                                                        } else if (mTypeDropDownValue
                                                            .isEmpty) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mSelectType);
                                                        } else if (passwordController
                                                            .text.isEmpty) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mEnterPassword);
                                                        } else if (!isPasswordValid(
                                                            passwordController
                                                                .text)) {
                                                          ErrorToast(
                                                              context: context,
                                                              text:
                                                                  "Not Valid  Password");
                                                        } else if (confirmpasswordController
                                                            .text.isEmpty) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mEnterConfirmPassword);
                                                        } else if (passwordController
                                                                .text !=
                                                            confirmpasswordController
                                                                .text) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mConfirmPasswordnotmatch);
                                                        } else if (companynameController
                                                            .text.isEmpty) {
                                                          ErrorToast(
                                                              context: context,
                                                              text: Languages.of(
                                                                      context)!
                                                                  .mentercompanyname);
                                                        } else {
                                                          mRegisterBloc
                                                              .register(
                                                            firstname:
                                                                nameController
                                                                    .text,
                                                            userid:
                                                                emailController
                                                                    .text,
                                                            phoneno:
                                                                mobileController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            usertype:
                                                                mTypeDropDownValue,
                                                            logintype: "Normal",
                                                            companyname:
                                                                companynameController
                                                                    .text,
                                                            linkedin:
                                                                linkedinController
                                                                    .text,
                                                          );
                                                        }
                                                      },
                                                      mSelectcolor: mBtnColor,
                                                      mTextColor: mWhiteColor),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Visibility(
                                                  visible: false,
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              left: 60.0,
                                                              right: 20.0),
                                                      child: const Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Dash(
                                                                direction: Axis
                                                                    .horizontal,
                                                                dashLength: 3,
                                                                length: 250,
                                                                dashColor:
                                                                    kGray),
                                                            Text(" OR "),
                                                            Dash(
                                                                direction: Axis
                                                                    .horizontal,
                                                                dashLength: 3,
                                                                length: 250,
                                                                dashColor:
                                                                    kGray)
                                                          ],
                                                        ),
                                                      ))),
                                            ],
                                          )),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
//const Column(children: [
//                             Align(
//                               alignment: Alignment.center,
//                               child: Image(
//                                 image: AssetImage(
//                                   "assets/loginbg.png",
//                                 ),
//                               ),
//                             ),
//                           ]
