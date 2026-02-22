// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Apartment for sale request – Istanbul`
  String get kSaleRequestTextFieldTitle {
    return Intl.message(
      'Apartment for sale request – Istanbul',
      name: 'kSaleRequestTextFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please provide property details and contact information. We will then contact you to assess the price and market the apartment.`
  String get kSaleRequestTextFieldDec {
    return Intl.message(
      'Please provide property details and contact information. We will then contact you to assess the price and market the apartment.',
      name: 'kSaleRequestTextFieldDec',
      desc: '',
      args: [],
    );
  }

  /// `The district (İlçe) in Istanbul`
  String get kSaleRequestTextField1 {
    return Intl.message(
      'The district (İlçe) in Istanbul',
      name: 'kSaleRequestTextField1',
      desc: '',
      args: [],
    );
  }

  /// `District/Neighborhood (Mahalle)`
  String get kSaleRequestTextField2 {
    return Intl.message(
      'District/Neighborhood (Mahalle)',
      name: 'kSaleRequestTextField2',
      desc: '',
      args: [],
    );
  }

  /// `Street / Detailed Address`
  String get kSaleRequestTextField3 {
    return Intl.message(
      'Street / Detailed Address',
      name: 'kSaleRequestTextField3',
      desc: '',
      args: [],
    );
  }

  /// `Number of rooms`
  String get kSaleRequestTextField4 {
    return Intl.message(
      'Number of rooms',
      name: 'kSaleRequestTextField4',
      desc: '',
      args: [],
    );
  }

  /// `Total area (m²)`
  String get kSaleRequestTextField5 {
    return Intl.message(
      'Total area (m²)',
      name: 'kSaleRequestTextField5',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get kSaleRequestTextField6 {
    return Intl.message(
      'Floor',
      name: 'kSaleRequestTextField6',
      desc: '',
      args: [],
    );
  }

  /// `Building age (in years)`
  String get kSaleRequestTextField7 {
    return Intl.message(
      'Building age (in years)',
      name: 'kSaleRequestTextField7',
      desc: '',
      args: [],
    );
  }

  /// `Within a residential complex?`
  String get kSaleRequestTextField8 {
    return Intl.message(
      'Within a residential complex?',
      name: 'kSaleRequestTextField8',
      desc: '',
      args: [],
    );
  }

  /// `Complex name`
  String get kSaleRequestTextField9 {
    return Intl.message(
      'Complex name',
      name: 'kSaleRequestTextField9',
      desc: '',
      args: [],
    );
  }

  /// `Usage Status`
  String get kSaleRequestTextField10 {
    return Intl.message(
      'Usage Status',
      name: 'kSaleRequestTextField10',
      desc: '',
      args: [],
    );
  }

  /// `Asking price (₺)`
  String get kSaleRequestTextField11 {
    return Intl.message(
      'Asking price (₺)',
      name: 'kSaleRequestTextField11',
      desc: '',
      args: [],
    );
  }

  /// `Name Surname`
  String get kSaleRequestTextField12 {
    return Intl.message(
      'Name Surname',
      name: 'kSaleRequestTextField12',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get kSaleRequestTextField13 {
    return Intl.message(
      'Phone number',
      name: 'kSaleRequestTextField13',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get kSaleRequestTextField14 {
    return Intl.message(
      'Email address',
      name: 'kSaleRequestTextField14',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the district (İlçe) in Istanbul`
  String get kSaleRequestTextFieldErrorMessage1 {
    return Intl.message(
      'Please enter the district (İlçe) in Istanbul',
      name: 'kSaleRequestTextFieldErrorMessage1',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the district/Neighborhood (Mahalle)`
  String get kSaleRequestTextFieldErrorMessage2 {
    return Intl.message(
      'Please enter the district/Neighborhood (Mahalle)',
      name: 'kSaleRequestTextFieldErrorMessage2',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Street / Detailed Address`
  String get kSaleRequestTextFieldErrorMessage3 {
    return Intl.message(
      'Please enter the Street / Detailed Address',
      name: 'kSaleRequestTextFieldErrorMessage3',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the number of rooms`
  String get kSaleRequestTextFieldErrorMessage4 {
    return Intl.message(
      'Please enter the number of rooms',
      name: 'kSaleRequestTextFieldErrorMessage4',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the total area (m²)`
  String get kSaleRequestTextFieldErrorMessage5 {
    return Intl.message(
      'Please enter the total area (m²)',
      name: 'kSaleRequestTextFieldErrorMessage5',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the floor`
  String get kSaleRequestTextFieldErrorMessage6 {
    return Intl.message(
      'Please enter the floor',
      name: 'kSaleRequestTextFieldErrorMessage6',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the building age (in years)`
  String get kSaleRequestTextFieldErrorMessage7 {
    return Intl.message(
      'Please enter the building age (in years)',
      name: 'kSaleRequestTextFieldErrorMessage7',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Within a residential complex?`
  String get kSaleRequestTextFieldErrorMessage8 {
    return Intl.message(
      'Please enter Within a residential complex?',
      name: 'kSaleRequestTextFieldErrorMessage8',
      desc: '',
      args: [],
    );
  }

  /// `Please enter complex name`
  String get kSaleRequestTextFieldErrorMessage9 {
    return Intl.message(
      'Please enter complex name',
      name: 'kSaleRequestTextFieldErrorMessage9',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the usage status`
  String get kSaleRequestTextFieldErrorMessage10 {
    return Intl.message(
      'Please enter the usage status',
      name: 'kSaleRequestTextFieldErrorMessage10',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the asking price (₺)`
  String get kSaleRequestTextFieldErrorMessage11 {
    return Intl.message(
      'Please enter the asking price (₺)',
      name: 'kSaleRequestTextFieldErrorMessage11',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the name surname`
  String get kSaleRequestTextFieldErrorMessage12 {
    return Intl.message(
      'Please enter the name surname',
      name: 'kSaleRequestTextFieldErrorMessage12',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the phone number`
  String get kSaleRequestTextFieldErrorMessage13 {
    return Intl.message(
      'Please enter the phone number',
      name: 'kSaleRequestTextFieldErrorMessage13',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address `
  String get kSaleRequestTextFieldErrorMessage14 {
    return Intl.message(
      'Please enter the email address ',
      name: 'kSaleRequestTextFieldErrorMessage14',
      desc: '',
      args: [],
    );
  }

  /// `The length of the phone number is illogical.`
  String get kSaleRequestTextFieldErrorPhone1 {
    return Intl.message(
      'The length of the phone number is illogical.',
      name: 'kSaleRequestTextFieldErrorPhone1',
      desc: '',
      args: [],
    );
  }

  /// `The number contains symbols that are not allowed.`
  String get kSaleRequestTextFieldErrorPhone2 {
    return Intl.message(
      'The number contains symbols that are not allowed.',
      name: 'kSaleRequestTextFieldErrorPhone2',
      desc: '',
      args: [],
    );
  }

  /// `The number must be in international format and begin with +`
  String get kSaleRequestTextFieldErrorPhone3 {
    return Intl.message(
      'The number must be in international format and begin with +',
      name: 'kSaleRequestTextFieldErrorPhone3',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get kSaleRequestTextFieldSendRequest {
    return Intl.message(
      'Send Request',
      name: 'kSaleRequestTextFieldSendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Your request has been successfully submitted. We will contact you soon.`
  String get kSaleRequestTextFieldSendRequestMessageSuccessfully {
    return Intl.message(
      'Your request has been successfully submitted. We will contact you soon.',
      name: 'kSaleRequestTextFieldSendRequestMessageSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your request could not be submitted. Please try again later.`
  String get kSaleRequestTextFieldSendRequestMessageFailed {
    return Intl.message(
      'Your request could not be submitted. Please try again later.',
      name: 'kSaleRequestTextFieldSendRequestMessageFailed',
      desc: '',
      args: [],
    );
  }

  /// `Request Sending`
  String get kSaleRequestTextFieldSendRequestMessageSending {
    return Intl.message(
      'Request Sending',
      name: 'kSaleRequestTextFieldSendRequestMessageSending',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get kSaleRequestTextFieldContactInformation {
    return Intl.message(
      'Contact information',
      name: 'kSaleRequestTextFieldContactInformation',
      desc: '',
      args: [],
    );
  }

  /// `Vacant`
  String get occupancyVacant {
    return Intl.message('Vacant', name: 'occupancyVacant', desc: '', args: []);
  }

  /// `Rented`
  String get occupancyRented {
    return Intl.message('Rented', name: 'occupancyRented', desc: '', args: []);
  }

  /// `Owner-occupied`
  String get occupancyOwner {
    return Intl.message(
      'Owner-occupied',
      name: 'occupancyOwner',
      desc: '',
      args: [],
    );
  }

  /// `Verification method via`
  String get kSaleRequestTextVerificationTitle {
    return Intl.message(
      'Verification method via',
      name: 'kSaleRequestTextVerificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get kSaleRequestTextVerificationMethod1 {
    return Intl.message(
      'Phone number',
      name: 'kSaleRequestTextVerificationMethod1',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get kSaleRequestTextVerificationMethod2 {
    return Intl.message(
      'Email address',
      name: 'kSaleRequestTextVerificationMethod2',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get kSaleRequestTextField15 {
    return Intl.message(
      'Verification code',
      name: 'kSaleRequestTextField15',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the Verification code`
  String get kSaleRequestTextFieldErrorMessage15 {
    return Intl.message(
      'Please enter the Verification code',
      name: 'kSaleRequestTextFieldErrorMessage15',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get kSaleRequestTextVerificationSend {
    return Intl.message(
      'Send code',
      name: 'kSaleRequestTextVerificationSend',
      desc: '',
      args: [],
    );
  }

  /// `Send code via SMS`
  String get kSaleRequestTextVerificationSendCodePhone {
    return Intl.message(
      'Send code via SMS',
      name: 'kSaleRequestTextVerificationSendCodePhone',
      desc: '',
      args: [],
    );
  }

  /// `Send code via email `
  String get kSaleRequestTextVerificationSendCodeEmail {
    return Intl.message(
      'Send code via email ',
      name: 'kSaleRequestTextVerificationSendCodeEmail',
      desc: '',
      args: [],
    );
  }

  /// `SMS code`
  String get kSaleRequestTextVerificationFieldPhone {
    return Intl.message(
      'SMS code',
      name: 'kSaleRequestTextVerificationFieldPhone',
      desc: '',
      args: [],
    );
  }

  /// `Verification code (email)`
  String get kSaleRequestTextVerificationFieldMail {
    return Intl.message(
      'Verification code (email)',
      name: 'kSaleRequestTextVerificationFieldMail',
      desc: '',
      args: [],
    );
  }

  /// `Confirm phone number`
  String get kSaleRequestTextVerificationFieldConfirmPhone {
    return Intl.message(
      'Confirm phone number',
      name: 'kSaleRequestTextVerificationFieldConfirmPhone',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Email`
  String get kSaleRequestTextVerificationFieldConfirmEmail {
    return Intl.message(
      'Confirm Email',
      name: 'kSaleRequestTextVerificationFieldConfirmEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone number verified`
  String get kSaleRequestTextVerificationOkPhone {
    return Intl.message(
      'Phone number verified',
      name: 'kSaleRequestTextVerificationOkPhone',
      desc: '',
      args: [],
    );
  }

  /// `Email verified`
  String get kSaleRequestTextVerificationOkEmail {
    return Intl.message(
      'Email verified',
      name: 'kSaleRequestTextVerificationOkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address first.`
  String get kSaleRequestTextVerificationEmailMessage1 {
    return Intl.message(
      'Enter your email address first.',
      name: 'kSaleRequestTextVerificationEmailMessage1',
      desc: '',
      args: [],
    );
  }

  /// `A verification code has been sent to your email.`
  String get kSaleRequestTextVerificationEmailMessage2 {
    return Intl.message(
      'A verification code has been sent to your email.',
      name: 'kSaleRequestTextVerificationEmailMessage2',
      desc: '',
      args: [],
    );
  }

  /// `Email code could not be sent.`
  String get kSaleRequestTextVerificationEmailMessage3 {
    return Intl.message(
      'Email code could not be sent.',
      name: 'kSaleRequestTextVerificationEmailMessage3',
      desc: '',
      args: [],
    );
  }

  /// `There is a previous order registered with this email address. If you wish to modify the order, please contact the support team.`
  String get kSaleRequestTextVerificationEmailMessage4 {
    return Intl.message(
      'There is a previous order registered with this email address. If you wish to modify the order, please contact the support team.',
      name: 'kSaleRequestTextVerificationEmailMessage4',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number first.`
  String get kSaleRequestTextVerificationPhoneMessage1 {
    return Intl.message(
      'Enter your phone number first.',
      name: 'kSaleRequestTextVerificationPhoneMessage1',
      desc: '',
      args: [],
    );
  }

  /// `SMS sending failed Invalid format`
  String get kSaleRequestTextVerificationPhoneMessage2 {
    return Intl.message(
      'SMS sending failed Invalid format',
      name: 'kSaleRequestTextVerificationPhoneMessage2',
      desc: '',
      args: [],
    );
  }

  /// `An SMS code has been sent, enter it and then press Confirm on your phone`
  String get kSaleRequestTextVerificationPhoneMessage3 {
    return Intl.message(
      'An SMS code has been sent, enter it and then press Confirm on your phone',
      name: 'kSaleRequestTextVerificationPhoneMessage3',
      desc: '',
      args: [],
    );
  }

  /// `Send the SMS code first.`
  String get kSaleRequestTextVerificationPhoneMessage4 {
    return Intl.message(
      'Send the SMS code first.',
      name: 'kSaleRequestTextVerificationPhoneMessage4',
      desc: '',
      args: [],
    );
  }

  /// `Enter the SMS code.`
  String get kSaleRequestTextVerificationPhoneMessage5 {
    return Intl.message(
      'Enter the SMS code.',
      name: 'kSaleRequestTextVerificationPhoneMessage5',
      desc: '',
      args: [],
    );
  }

  /// `The phone number has been successfully verified.`
  String get kSaleRequestTextVerificationPhoneMessage6 {
    return Intl.message(
      'The phone number has been successfully verified.',
      name: 'kSaleRequestTextVerificationPhoneMessage6',
      desc: '',
      args: [],
    );
  }

  /// `Invalid SMS code`
  String get kSaleRequestTextVerificationPhoneMessage7 {
    return Intl.message(
      'Invalid SMS code',
      name: 'kSaleRequestTextVerificationPhoneMessage7',
      desc: '',
      args: [],
    );
  }

  /// `The phone number could not be read after verification.`
  String get kSaleRequestTextVerificationPhoneMessage8 {
    return Intl.message(
      'The phone number could not be read after verification.',
      name: 'kSaleRequestTextVerificationPhoneMessage8',
      desc: '',
      args: [],
    );
  }

  /// `Invalid or expired SMS code:`
  String get kSaleRequestTextVerificationPhoneMessage9 {
    return Intl.message(
      'Invalid or expired SMS code:',
      name: 'kSaleRequestTextVerificationPhoneMessage9',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error during verification`
  String get kSaleRequestTextVerificationPhoneMessage10 {
    return Intl.message(
      'Unexpected error during verification',
      name: 'kSaleRequestTextVerificationPhoneMessage10',
      desc: '',
      args: [],
    );
  }

  /// `Choose a verification method (phone or email)`
  String get kSaleRequestTextVerificationMessage1 {
    return Intl.message(
      'Choose a verification method (phone or email)',
      name: 'kSaleRequestTextVerificationMessage1',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your phone number before submitting the request.`
  String get kSaleRequestTextVerificationMessage2 {
    return Intl.message(
      'Please confirm your phone number before submitting the request.',
      name: 'kSaleRequestTextVerificationMessage2',
      desc: '',
      args: [],
    );
  }

  /// `The verified phone number could not be read.`
  String get kSaleRequestTextVerificationMessage3 {
    return Intl.message(
      'The verified phone number could not be read.',
      name: 'kSaleRequestTextVerificationMessage3',
      desc: '',
      args: [],
    );
  }

  /// `Send the verification code to the email first.`
  String get kSaleRequestTextVerificationMessage4 {
    return Intl.message(
      'Send the verification code to the email first.',
      name: 'kSaleRequestTextVerificationMessage4',
      desc: '',
      args: [],
    );
  }

  /// `The email code is incorrect.`
  String get kSaleRequestTextVerificationMessage5 {
    return Intl.message(
      'The email code is incorrect.',
      name: 'kSaleRequestTextVerificationMessage5',
      desc: '',
      args: [],
    );
  }

  /// `The request was sent after successful verification.`
  String get kSaleRequestTextVerificationMessage6 {
    return Intl.message(
      'The request was sent after successful verification.',
      name: 'kSaleRequestTextVerificationMessage6',
      desc: '',
      args: [],
    );
  }

  /// `Your request has been successfully sent 🎉`
  String get kSaleRequestSuccessfulMessageTitle {
    return Intl.message(
      'Your request has been successfully sent 🎉',
      name: 'kSaleRequestSuccessfulMessageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Thank you! Your request to sell the apartment has been received. We will contact you soon to review the details.`
  String get kSaleRequestSuccessfulMessageTitle2 {
    return Intl.message(
      'Thank you! Your request to sell the apartment has been received. We will contact you soon to review the details.',
      name: 'kSaleRequestSuccessfulMessageTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get kSaleRequestSuccessfulMessageButtonReturn {
    return Intl.message(
      'Home',
      name: 'kSaleRequestSuccessfulMessageButtonReturn',
      desc: '',
      args: [],
    );
  }

  /// `Sell your apartment with ease and professionalism`
  String get kBetnaHomePageSlide1Title {
    return Intl.message(
      'Sell your apartment with ease and professionalism',
      name: 'kBetnaHomePageSlide1Title',
      desc: '',
      args: [],
    );
  }

  /// `Send your apartment details in minutes, and the Betna team will contact you to evaluate the property and help you get the best offer.`
  String get kBetnaHomePageSlide1Subtitle {
    return Intl.message(
      'Send your apartment details in minutes, and the Betna team will contact you to evaluate the property and help you get the best offer.',
      name: 'kBetnaHomePageSlide1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Real Estate Sales Service`
  String get kBetnaHomePageSlide1Badge {
    return Intl.message(
      'Real Estate Sales Service',
      name: 'kBetnaHomePageSlide1Badge',
      desc: '',
      args: [],
    );
  }

  /// `Real estate offers ready for purchase`
  String get kBetnaHomePageSlide2Title {
    return Intl.message(
      'Real estate offers ready for purchase',
      name: 'kBetnaHomePageSlide2Title',
      desc: '',
      args: [],
    );
  }

  /// `We have a selection of apartments and properties for sale in different areas of Istanbul to suit your budget.`
  String get kBetnaHomePageSlide2Subtitle {
    return Intl.message(
      'We have a selection of apartments and properties for sale in different areas of Istanbul to suit your budget.',
      name: 'kBetnaHomePageSlide2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Offers for Sale`
  String get kBetnaHomePageSlide2Badge {
    return Intl.message(
      'Offers for Sale',
      name: 'kBetnaHomePageSlide2Badge',
      desc: '',
      args: [],
    );
  }

  /// `Real estate appraisal and specialized consultation`
  String get kBetnaHomePageSlide3Title {
    return Intl.message(
      'Real estate appraisal and specialized consultation',
      name: 'kBetnaHomePageSlide3Title',
      desc: '',
      args: [],
    );
  }

  /// `Our experts provide you with a realistic valuation of your property's price based on market data and professional analysis.`
  String get kBetnaHomePageSlide3Subtitle {
    return Intl.message(
      'Our experts provide you with a realistic valuation of your property\'s price based on market data and professional analysis.',
      name: 'kBetnaHomePageSlide3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Evaluation and Consulting`
  String get kBetnaHomePageSlide3Badge {
    return Intl.message(
      'Evaluation and Consulting',
      name: 'kBetnaHomePageSlide3Badge',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get kBetnaHomePageSocialWhatsapp {
    return Intl.message(
      'WhatsApp',
      name: 'kBetnaHomePageSocialWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get kBetnaHomePageSocialInstagram {
    return Intl.message(
      'Instagram',
      name: 'kBetnaHomePageSocialInstagram',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get kBetnaHomePageSocialFacebook {
    return Intl.message(
      'Facebook',
      name: 'kBetnaHomePageSocialFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get kBetnaHomePageSocialWebsite {
    return Intl.message(
      'Location',
      name: 'kBetnaHomePageSocialWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Sell your property easily`
  String get kBetnaHomePageInfoCard1Title {
    return Intl.message(
      'Sell your property easily',
      name: 'kBetnaHomePageInfoCard1Title',
      desc: '',
      args: [],
    );
  }

  /// `Send your apartment details in minutes, and our team will follow up.`
  String get kBetnaHomePageInfoCard1Subtitle {
    return Intl.message(
      'Send your apartment details in minutes, and our team will follow up.',
      name: 'kBetnaHomePageInfoCard1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Experience in Istanbul`
  String get kBetnaHomePageInfoCard2Title {
    return Intl.message(
      'Experience in Istanbul',
      name: 'kBetnaHomePageInfoCard2Title',
      desc: '',
      args: [],
    );
  }

  /// `Deep understanding of real estate market in Istanbul`
  String get kBetnaHomePageInfoCard2Subtitle {
    return Intl.message(
      'Deep understanding of real estate market in Istanbul',
      name: 'kBetnaHomePageInfoCard2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Reliability and Security`
  String get kBetnaHomePageInfoCard3Title {
    return Intl.message(
      'Reliability and Security',
      name: 'kBetnaHomePageInfoCard3Title',
      desc: '',
      args: [],
    );
  }

  /// `We deal with transparency in valuation, contracts, and client follow-up.`
  String get kBetnaHomePageInfoCard3Subtitle {
    return Intl.message(
      'We deal with transparency in valuation, contracts, and client follow-up.',
      name: 'kBetnaHomePageInfoCard3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `© {year} Betna. All rights reserved.`
  String kBetnaHomePageFooter(int year) {
    return Intl.message(
      '© $year Betna. All rights reserved.',
      name: 'kBetnaHomePageFooter',
      desc: '',
      args: [year],
    );
  }

  /// `Browse Offers`
  String get kBetnaHomePageBrowseOffers {
    return Intl.message(
      'Browse Offers',
      name: 'kBetnaHomePageBrowseOffers',
      desc: '',
      args: [],
    );
  }

  /// `Sale Request`
  String get kBetnaHomePageSubmitSaleRequest {
    return Intl.message(
      'Sale Request',
      name: 'kBetnaHomePageSubmitSaleRequest',
      desc: '',
      args: [],
    );
  }

  /// `Betna Real Estate`
  String get kBetnaHomePageHeroIllustrationText {
    return Intl.message(
      'Betna Real Estate',
      name: 'kBetnaHomePageHeroIllustrationText',
      desc: '',
      args: [],
    );
  }

  /// `Reliable real estate service in Istanbul`
  String get kBetnaHomePageHeroTextBlockBadge {
    return Intl.message(
      'Reliable real estate service in Istanbul',
      name: 'kBetnaHomePageHeroTextBlockBadge',
      desc: '',
      args: [],
    );
  }

  /// `Sell your apartment with ease and professionalism\nwith Betna Real Estate`
  String get kBetnaHomePageHeroTextBlockTitle {
    return Intl.message(
      'Sell your apartment with ease and professionalism\nwith Betna Real Estate',
      name: 'kBetnaHomePageHeroTextBlockTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find your dream home, sell your property, or let us manage your investments with our comprehensive real estate services in Istanbul.`
  String get kBetnaHomePageHeroTextBlockSubtitle {
    return Intl.message(
      'Find your dream home, sell your property, or let us manage your investments with our comprehensive real estate services in Istanbul.',
      name: 'kBetnaHomePageHeroTextBlockSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `VIEW PROPERTIES`
  String get kBetnaHomePageHeroPrimaryButton {
    return Intl.message(
      'VIEW PROPERTIES',
      name: 'kBetnaHomePageHeroPrimaryButton',
      desc: '',
      args: [],
    );
  }

  /// `SELL / MANAGE`
  String get kBetnaHomePageHeroSecondaryButton {
    return Intl.message(
      'SELL / MANAGE',
      name: 'kBetnaHomePageHeroSecondaryButton',
      desc: '',
      args: [],
    );
  }

  /// `Free consultation soon`
  String get kBetnaHomePageHeroTextBlockFreeConsultation {
    return Intl.message(
      'Free consultation soon',
      name: 'kBetnaHomePageHeroTextBlockFreeConsultation',
      desc: '',
      args: [],
    );
  }

  /// `Real estate in Istanbul`
  String get kBetnaHomePageHeroIllustrationTag {
    return Intl.message(
      'Real estate in Istanbul',
      name: 'kBetnaHomePageHeroIllustrationTag',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get kCountry {
    return Intl.message('Country', name: 'kCountry', desc: '', args: []);
  }

  /// `City`
  String get kCity {
    return Intl.message('City', name: 'kCity', desc: '', args: []);
  }

  /// `District`
  String get kDistrict {
    return Intl.message('District', name: 'kDistrict', desc: '', args: []);
  }

  /// `OUR EXPERTISE`
  String get kServicesOurExpertise {
    return Intl.message(
      'OUR EXPERTISE',
      name: 'kServicesOurExpertise',
      desc: '',
      args: [],
    );
  }

  /// `Premium Real Estate Services`
  String get kServicesPremiumServices {
    return Intl.message(
      'Premium Real Estate Services',
      name: 'kServicesPremiumServices',
      desc: '',
      args: [],
    );
  }

  /// `Property Sales`
  String get kServicesPropertySales {
    return Intl.message(
      'Property Sales',
      name: 'kServicesPropertySales',
      desc: '',
      args: [],
    );
  }

  /// `We help you sell your property quickly and at the best market price with our comprehensive marketing strategies and extensive buyer network.`
  String get kServicesPropertySalesDesc {
    return Intl.message(
      'We help you sell your property quickly and at the best market price with our comprehensive marketing strategies and extensive buyer network.',
      name: 'kServicesPropertySalesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Property Management`
  String get kServicesPropertyManagement {
    return Intl.message(
      'Property Management',
      name: 'kServicesPropertyManagement',
      desc: '',
      args: [],
    );
  }

  /// `Entrust us with your property. We handle everything from tenant screening to maintenance, maximizing your ROI and protecting your investment.`
  String get kServicesPropertyManagementDesc {
    return Intl.message(
      'Entrust us with your property. We handle everything from tenant screening to maintenance, maximizing your ROI and protecting your investment.',
      name: 'kServicesPropertyManagementDesc',
      desc: '',
      args: [],
    );
  }

  /// `CONTACT US`
  String get kServicesContactUs {
    return Intl.message(
      'CONTACT US',
      name: 'kServicesContactUs',
      desc: '',
      args: [],
    );
  }

  /// `Properties`
  String get kBetnaHomePageProperties {
    return Intl.message(
      'Properties',
      name: 'kBetnaHomePageProperties',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get kBetnaHomePageAbout {
    return Intl.message(
      'About Us',
      name: 'kBetnaHomePageAbout',
      desc: '',
      args: [],
    );
  }

  /// `CONTACT`
  String get kBetnaHomePageContact {
    return Intl.message(
      'CONTACT',
      name: 'kBetnaHomePageContact',
      desc: '',
      args: [],
    );
  }

  /// `WHY\nBETNA`
  String get kBetnaHomePageWhyBetna {
    return Intl.message(
      'WHY\nBETNA',
      name: 'kBetnaHomePageWhyBetna',
      desc: '',
      args: [],
    );
  }

  /// `WHY BETNA`
  String get kBetnaHomePageWhyBetnaRow {
    return Intl.message(
      'WHY BETNA',
      name: 'kBetnaHomePageWhyBetnaRow',
      desc: '',
      args: [],
    );
  }

  /// `Istanbul's most trusted real estate partner for buying, selling, and comprehensive property management across every district.`
  String get kBetnaHomePageWhyBetnaDesc {
    return Intl.message(
      'Istanbul\'s most trusted real estate partner for buying, selling, and comprehensive property management across every district.',
      name: 'kBetnaHomePageWhyBetnaDesc',
      desc: '',
      args: [],
    );
  }

  /// `ALL`
  String get kBetnaHomePageFilterAll {
    return Intl.message(
      'ALL',
      name: 'kBetnaHomePageFilterAll',
      desc: '',
      args: [],
    );
  }

  /// `FOR SALE`
  String get kBetnaHomePageFilterForSale {
    return Intl.message(
      'FOR SALE',
      name: 'kBetnaHomePageFilterForSale',
      desc: '',
      args: [],
    );
  }

  /// `PROJECTS`
  String get kBetnaHomePageFilterProjects {
    return Intl.message(
      'PROJECTS',
      name: 'kBetnaHomePageFilterProjects',
      desc: '',
      args: [],
    );
  }

  /// `Location (e.g. Beşiktaş)`
  String get kBetnaHomePageFilterLocationHint {
    return Intl.message(
      'Location (e.g. Beşiktaş)',
      name: 'kBetnaHomePageFilterLocationHint',
      desc: '',
      args: [],
    );
  }

  /// `Max Price`
  String get kBetnaHomePageFilterMaxPrice {
    return Intl.message(
      'Max Price',
      name: 'kBetnaHomePageFilterMaxPrice',
      desc: '',
      args: [],
    );
  }

  /// `SELECTED`
  String get kBetnaHomePageSelected {
    return Intl.message(
      'SELECTED',
      name: 'kBetnaHomePageSelected',
      desc: '',
      args: [],
    );
  }

  /// `COLLECTIONS`
  String get kBetnaHomePageCollections {
    return Intl.message(
      'COLLECTIONS',
      name: 'kBetnaHomePageCollections',
      desc: '',
      args: [],
    );
  }

  /// `VIEW ALL`
  String get kBetnaHomePageViewAll {
    return Intl.message(
      'VIEW ALL',
      name: 'kBetnaHomePageViewAll',
      desc: '',
      args: [],
    );
  }

  /// `READY TO SELL YOUR\nPROPERTY?`
  String get kBetnaHomePageCtaTitle {
    return Intl.message(
      'READY TO SELL YOUR\nPROPERTY?',
      name: 'kBetnaHomePageCtaTitle',
      desc: '',
      args: [],
    );
  }

  /// `Our team evaluates your apartment and markets it to the right buyers. Fill out a simple form and we'll contact you within 24 hours.`
  String get kBetnaHomePageCtaDesc {
    return Intl.message(
      'Our team evaluates your apartment and markets it to the right buyers. Fill out a simple form and we\'ll contact you within 24 hours.',
      name: 'kBetnaHomePageCtaDesc',
      desc: '',
      args: [],
    );
  }

  /// `WHATSAPP US`
  String get kBetnaHomePageWhatsappUs {
    return Intl.message(
      'WHATSAPP US',
      name: 'kBetnaHomePageWhatsappUs',
      desc: '',
      args: [],
    );
  }

  /// `Premium real estate services\nin Istanbul, Turkey.`
  String get kBetnaHomePageFooterDesc {
    return Intl.message(
      'Premium real estate services\nin Istanbul, Turkey.',
      name: 'kBetnaHomePageFooterDesc',
      desc: '',
      args: [],
    );
  }

  /// `INSTAGRAM`
  String get kBetnaHomePageInstagram {
    return Intl.message(
      'INSTAGRAM',
      name: 'kBetnaHomePageInstagram',
      desc: '',
      args: [],
    );
  }

  /// `FACEBOOK`
  String get kBetnaHomePageFacebook {
    return Intl.message(
      'FACEBOOK',
      name: 'kBetnaHomePageFacebook',
      desc: '',
      args: [],
    );
  }

  /// `WHATSAPP`
  String get kBetnaHomePageWhatsapp {
    return Intl.message(
      'WHATSAPP',
      name: 'kBetnaHomePageWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `SCROLL`
  String get kBetnaHomePageScrollDown {
    return Intl.message(
      'SCROLL',
      name: 'kBetnaHomePageScrollDown',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get kAboutPageTitle {
    return Intl.message(
      'About Us',
      name: 'kAboutPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `About Betna`
  String get kAboutUsSectionTitle {
    return Intl.message(
      'About Betna',
      name: 'kAboutUsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `BETNA REAL ESTATE is a premier consultancy and brokerage firm delivering trusted, professional, and comprehensive real estate services. Specializing in residential and commercial properties, we offer an extensive portfolio of properties for sale and rent tailored to meet your unique needs. Whether you are searching for your dream home or a strategic workplace, our dedicated team is here to guide you every step of the way. Built on the core principles of unwavering trust, absolute transparency, and unparalleled customer satisfaction, we are committed to turning your real estate goals into reality.`
  String get kAboutUsSectionText {
    return Intl.message(
      'BETNA REAL ESTATE is a premier consultancy and brokerage firm delivering trusted, professional, and comprehensive real estate services. Specializing in residential and commercial properties, we offer an extensive portfolio of properties for sale and rent tailored to meet your unique needs. Whether you are searching for your dream home or a strategic workplace, our dedicated team is here to guide you every step of the way. Built on the core principles of unwavering trust, absolute transparency, and unparalleled customer satisfaction, we are committed to turning your real estate goals into reality.',
      name: 'kAboutUsSectionText',
      desc: '',
      args: [],
    );
  }

  /// `Real Estate Projects`
  String get kProjectsSectionTitle {
    return Intl.message(
      'Real Estate Projects',
      name: 'kProjectsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Discover our collection of premium projects across Istanbul.`
  String get kProjectsSectionText {
    return Intl.message(
      'Discover our collection of premium projects across Istanbul.',
      name: 'kProjectsSectionText',
      desc: '',
      args: [],
    );
  }

  /// `Resale Properties`
  String get kResaleSectionTitle {
    return Intl.message(
      'Resale Properties',
      name: 'kResaleSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find your next home or investment in our resale properties.`
  String get kResaleSectionText {
    return Intl.message(
      'Find your next home or investment in our resale properties.',
      name: 'kResaleSectionText',
      desc: '',
      args: [],
    );
  }

  /// `Find Your Dream Ready-to-Move Home`
  String get kResaleSectionSubtitle {
    return Intl.message(
      'Find Your Dream Ready-to-Move Home',
      name: 'kResaleSectionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `EİDS Authorization Guide`
  String get kEidsPageTitle {
    return Intl.message(
      'EİDS Authorization Guide',
      name: 'kEidsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Important Notice for Property Owners`
  String get kEidsPageSubtitle {
    return Intl.message(
      'Important Notice for Property Owners',
      name: 'kEidsPageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `After February 15, ads cannot be published without authorization!`
  String get kEidsPageWarning {
    return Intl.message(
      'After February 15, ads cannot be published without authorization!',
      name: 'kEidsPageWarning',
      desc: '',
      args: [],
    );
  }

  /// `How to Authorize Real Estate Ads via EİDS?`
  String get kEidsPageQuestion {
    return Intl.message(
      'How to Authorize Real Estate Ads via EİDS?',
      name: 'kEidsPageQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Log in to e-Devlet.`
  String get kEidsStep1 {
    return Intl.message(
      'Log in to e-Devlet.',
      name: 'kEidsStep1',
      desc: '',
      args: [],
    );
  }

  /// `Type "EİDS Taşınmaz İlanı Yetkilendirme" in the search bar.`
  String get kEidsStep2 {
    return Intl.message(
      'Type "EİDS Taşınmaz İlanı Yetkilendirme" in the search bar.',
      name: 'kEidsStep2',
      desc: '',
      args: [],
    );
  }

  /// `Select the property you want to advertise.`
  String get kEidsStep3 {
    return Intl.message(
      'Select the property you want to advertise.',
      name: 'kEidsStep3',
      desc: '',
      args: [],
    );
  }

  /// `Add the real estate agency you want to authorize (using Authorization Document No).`
  String get kEidsStep4 {
    return Intl.message(
      'Add the real estate agency you want to authorize (using Authorization Document No).',
      name: 'kEidsStep4',
      desc: '',
      args: [],
    );
  }

  /// `Betna Gayrimenkul Authorization Document No: `
  String get kEidsStep4Note {
    return Intl.message(
      'Betna Gayrimenkul Authorization Document No: ',
      name: 'kEidsStep4Note',
      desc: '',
      args: [],
    );
  }

  /// `Set the authorization period (minimum 3 months).`
  String get kEidsStep5 {
    return Intl.message(
      'Set the authorization period (minimum 3 months).',
      name: 'kEidsStep5',
      desc: '',
      args: [],
    );
  }

  /// `Approve and save.`
  String get kEidsStep6 {
    return Intl.message(
      'Approve and save.',
      name: 'kEidsStep6',
      desc: '',
      args: [],
    );
  }

  /// `The ad site will publish the ad with verified authorization.`
  String get kEidsStep7 {
    return Intl.message(
      'The ad site will publish the ad with verified authorization.',
      name: 'kEidsStep7',
      desc: '',
      args: [],
    );
  }

  /// `It is not possible to publish an ad without authorization.`
  String get kEidsFooterNote {
    return Intl.message(
      'It is not possible to publish an ad without authorization.',
      name: 'kEidsFooterNote',
      desc: '',
      args: [],
    );
  }

  /// `IMPORTANT`
  String get kEidsImportant {
    return Intl.message(
      'IMPORTANT',
      name: 'kEidsImportant',
      desc: '',
      args: [],
    );
  }

  /// `Go to e-Devlet`
  String get kEidsGoToEDevlet {
    return Intl.message(
      'Go to e-Devlet',
      name: 'kEidsGoToEDevlet',
      desc: '',
      args: [],
    );
  }

  /// `SOLD`
  String get kPropertySold {
    return Intl.message('SOLD', name: 'kPropertySold', desc: '', args: []);
  }

  /// `No properties match your filters.`
  String get kNoPropertiesMatch {
    return Intl.message(
      'No properties match your filters.',
      name: 'kNoPropertiesMatch',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
