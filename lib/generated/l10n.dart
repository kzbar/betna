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

  /// `betna`
  String get kAppName {
    return Intl.message('betna', name: 'kAppName', desc: '', args: []);
  }

  /// `.net`
  String get kAppName1 {
    return Intl.message('.net', name: 'kAppName1', desc: '', args: []);
  }

  /// `Add ad`
  String get kAddNewAd {
    return Intl.message('Add ad', name: 'kAddNewAd', desc: '', args: []);
  }

  /// `Cancel search`
  String get kCancelSearch {
    return Intl.message(
      'Cancel search',
      name: 'kCancelSearch',
      desc: '',
      args: [],
    );
  }

  /// `Number of ads {number}`
  String kNumberAds(Object number) {
    return Intl.message(
      'Number of ads $number',
      name: 'kNumberAds',
      desc: '',
      args: [number],
    );
  }

  /// `Old/Less`
  String get kOldLess {
    return Intl.message('Old/Less', name: 'kOldLess', desc: '', args: []);
  }

  /// `Latest/Highest`
  String get kLatestHighest {
    return Intl.message(
      'Latest/Highest',
      name: 'kLatestHighest',
      desc: '',
      args: [],
    );
  }

  /// `Search by {value}`
  String kSearchBy(Object value) {
    return Intl.message(
      'Search by $value',
      name: 'kSearchBy',
      desc: '',
      args: [value],
    );
  }

  /// `Number contracts {value}`
  String kNumberContracts(Object value) {
    return Intl.message(
      'Number contracts $value',
      name: 'kNumberContracts',
      desc: '',
      args: [value],
    );
  }

  /// `Email`
  String get kEmail {
    return Intl.message('Email', name: 'kEmail', desc: '', args: []);
  }

  /// `Password`
  String get kPassword {
    return Intl.message('Password', name: 'kPassword', desc: '', args: []);
  }

  /// `Call now`
  String get kCallNow {
    return Intl.message('Call now', name: 'kCallNow', desc: '', args: []);
  }

  /// `Welcome to our home site. The site is currently under construction. For more information, please contact the following number`
  String get kWelcomeMessage {
    return Intl.message(
      'Welcome to our home site. The site is currently under construction. For more information, please contact the following number',
      name: 'kWelcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get kLogin {
    return Intl.message('Login', name: 'kLogin', desc: '', args: []);
  }

  /// `This field cannot be empty.`
  String get kRequiredErrorText {
    return Intl.message(
      'This field cannot be empty.',
      name: 'kRequiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get kSetting {
    return Intl.message('Setting', name: 'kSetting', desc: '', args: []);
  }

  /// `Log out`
  String get kLogout {
    return Intl.message('Log out', name: 'kLogout', desc: '', args: []);
  }

  /// `Home`
  String get kHome {
    return Intl.message('Home', name: 'kHome', desc: '', args: []);
  }

  /// `Rooms`
  String get kRoom {
    return Intl.message('Rooms', name: 'kRoom', desc: '', args: []);
  }

  /// `Price`
  String get kPrice {
    return Intl.message('Price', name: 'kPrice', desc: '', args: []);
  }

  /// `Area`
  String get kArea {
    return Intl.message('Area', name: 'kArea', desc: '', args: []);
  }

  /// `Floor`
  String get kFloor {
    return Intl.message('Floor', name: 'kFloor', desc: '', args: []);
  }

  /// `Payment`
  String get kPayment {
    return Intl.message('Payment', name: 'kPayment', desc: '', args: []);
  }

  /// `Title {number}`
  String kTitle(Object number) {
    return Intl.message(
      'Title $number',
      name: 'kTitle',
      desc: '',
      args: [number],
    );
  }

  /// `Font Type`
  String get kFontType {
    return Intl.message('Font Type', name: 'kFontType', desc: '', args: []);
  }

  /// `Language`
  String get kLang {
    return Intl.message('Language', name: 'kLang', desc: '', args: []);
  }

  /// `Cash`
  String get kCash {
    return Intl.message('Cash', name: 'kCash', desc: '', args: []);
  }

  /// `Installment`
  String get kInstallment {
    return Intl.message(
      'Installment',
      name: 'kInstallment',
      desc: '',
      args: [],
    );
  }

  /// `Ad type`
  String get kType {
    return Intl.message('Ad type', name: 'kType', desc: '', args: []);
  }

  /// `For Rent`
  String get kRent {
    return Intl.message('For Rent', name: 'kRent', desc: '', args: []);
  }

  /// `For Sale`
  String get kSale {
    return Intl.message('For Sale', name: 'kSale', desc: '', args: []);
  }

  /// `Background`
  String get kWithBackground {
    return Intl.message(
      'Background',
      name: 'kWithBackground',
      desc: '',
      args: [],
    );
  }

  /// `With Logo`
  String get kWithLogo {
    return Intl.message('With Logo', name: 'kWithLogo', desc: '', args: []);
  }

  /// `Add a new project`
  String get kAddProject {
    return Intl.message(
      'Add a new project',
      name: 'kAddProject',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get kPaymentMethod {
    return Intl.message(
      'Payment method',
      name: 'kPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get kImages {
    return Intl.message('Images', name: 'kImages', desc: '', args: []);
  }

  /// `In side images`
  String get kInSideImages {
    return Intl.message(
      'In side images',
      name: 'kInSideImages',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get kGeneralInformation {
    return Intl.message(
      'General information',
      name: 'kGeneralInformation',
      desc: '',
      args: [],
    );
  }

  /// `property type `
  String get kTypeProperty {
    return Intl.message(
      'property type ',
      name: 'kTypeProperty',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Date`
  String get kDeliveryDate {
    return Intl.message(
      'Delivery Date',
      name: 'kDeliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Construction Year`
  String get kConstructionYear {
    return Intl.message(
      'Construction Year',
      name: 'kConstructionYear',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get kSelect {
    return Intl.message('Select', name: 'kSelect', desc: '', args: []);
  }

  /// `Detail information`
  String get kDetailInformation {
    return Intl.message(
      'Detail information',
      name: 'kDetailInformation',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get kSend {
    return Intl.message('Send', name: 'kSend', desc: '', args: []);
  }

  /// `Price starts`
  String get kPriceStarts {
    return Intl.message(
      'Price starts',
      name: 'kPriceStarts',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get kCity {
    return Intl.message('City', name: 'kCity', desc: '', args: []);
  }

  /// `Town`
  String get kTown {
    return Intl.message('Town', name: 'kTown', desc: '', args: []);
  }

  /// `Apartments and prices`
  String get kApartmentsPrices {
    return Intl.message(
      'Apartments and prices',
      name: 'kApartmentsPrices',
      desc: '',
      args: [],
    );
  }

  /// `Bath`
  String get kBath {
    return Intl.message('Bath', name: 'kBath', desc: '', args: []);
  }

  /// `Set Location`
  String get kSetLocation {
    return Intl.message(
      'Set Location',
      name: 'kSetLocation',
      desc: '',
      args: [],
    );
  }

  /// `For sale`
  String get kForSaleTitle {
    return Intl.message('For sale', name: 'kForSaleTitle', desc: '', args: []);
  }

  /// `Projects`
  String get kProjects1 {
    return Intl.message('Projects', name: 'kProjects1', desc: '', args: []);
  }

  /// `For Rent`
  String get kForRentTitle {
    return Intl.message('For Rent', name: 'kForRentTitle', desc: '', args: []);
  }

  /// `Page Not Found`
  String get kPageNotFound {
    return Intl.message(
      'Page Not Found',
      name: 'kPageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get kBackToHome {
    return Intl.message(
      'Back to Home',
      name: 'kBackToHome',
      desc: '',
      args: [],
    );
  }

  /// `whatsApp chat`
  String get kWhatsApp {
    return Intl.message('whatsApp chat', name: 'kWhatsApp', desc: '', args: []);
  }

  /// `Direct call`
  String get kDirectCall {
    return Intl.message('Direct call', name: 'kDirectCall', desc: '', args: []);
  }

  /// `Messenger chat`
  String get kMessenger {
    return Intl.message(
      'Messenger chat',
      name: 'kMessenger',
      desc: '',
      args: [],
    );
  }

  /// `Request call`
  String get kRequestCall {
    return Intl.message(
      'Request call',
      name: 'kRequestCall',
      desc: '',
      args: [],
    );
  }

  /// `Speed Dial`
  String get kSpeedDial {
    return Intl.message('Speed Dial', name: 'kSpeedDial', desc: '', args: []);
  }

  /// `Contact us now`
  String get kMessage1 {
    return Intl.message(
      'Contact us now',
      name: 'kMessage1',
      desc: '',
      args: [],
    );
  }

  /// `Special offers`
  String get kMessage2 {
    return Intl.message(
      'Special offers',
      name: 'kMessage2',
      desc: '',
      args: [],
    );
  }

  /// `Apartments for sale in Istanbul`
  String get kMessage3 {
    return Intl.message(
      'Apartments for sale in Istanbul',
      name: 'kMessage3',
      desc: '',
      args: [],
    );
  }

  /// `Investment projects`
  String get kMessage4 {
    return Intl.message(
      'Investment projects',
      name: 'kMessage4',
      desc: '',
      args: [],
    );
  }

  /// `Free real estate advice`
  String get kMessage5 {
    return Intl.message(
      'Free real estate advice',
      name: 'kMessage5',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get kChangeLang {
    return Intl.message(
      'Change Language',
      name: 'kChangeLang',
      desc: '',
      args: [],
    );
  }

  /// `Change Currency`
  String get kChangeCurrency {
    return Intl.message(
      'Change Currency',
      name: 'kChangeCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Header page adding`
  String get kHeaderPageTitle {
    return Intl.message(
      'Header page adding',
      name: 'kHeaderPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `All projects`
  String get kProjectAll {
    return Intl.message(
      'All projects',
      name: 'kProjectAll',
      desc: '',
      args: [],
    );
  }

  /// `Projects under construction`
  String get kProjectsUnderConstruction {
    return Intl.message(
      'Projects under construction',
      name: 'kProjectsUnderConstruction',
      desc: '',
      args: [],
    );
  }

  /// `Ready for housing projects`
  String get kReadyForHousingProjects {
    return Intl.message(
      'Ready for housing projects',
      name: 'kReadyForHousingProjects',
      desc: '',
      args: [],
    );
  }

  /// `Investment projects`
  String get kInvestmentProjects {
    return Intl.message(
      'Investment projects',
      name: 'kInvestmentProjects',
      desc: '',
      args: [],
    );
  }

  /// `All Houses`
  String get kAllHouses {
    return Intl.message('All Houses', name: 'kAllHouses', desc: '', args: []);
  }

  /// `Affordable Homes`
  String get kAffordableHomes {
    return Intl.message(
      'Affordable Homes',
      name: 'kAffordableHomes',
      desc: '',
      args: [],
    );
  }

  /// `Luxury Homes`
  String get kLuxuryHomes {
    return Intl.message(
      'Luxury Homes',
      name: 'kLuxuryHomes',
      desc: '',
      args: [],
    );
  }

  /// `See All listing`
  String get kSeeAllListing {
    return Intl.message(
      'See All listing',
      name: 'kSeeAllListing',
      desc: '',
      args: [],
    );
  }

  /// `There are no offers currently`
  String get kNoOffer {
    return Intl.message(
      'There are no offers currently',
      name: 'kNoOffer',
      desc: '',
      args: [],
    );
  }

  /// `{value} years ago`
  String kYearsAgo(Object value) {
    return Intl.message(
      '$value years ago',
      name: 'kYearsAgo',
      desc: '',
      args: [value],
    );
  }

  /// `1 year Ago`
  String get k1yearAgo {
    return Intl.message('1 year Ago', name: 'k1yearAgo', desc: '', args: []);
  }

  /// `Last Year`
  String get kLastYear {
    return Intl.message('Last Year', name: 'kLastYear', desc: '', args: []);
  }

  /// `{value} Months Ago`
  String kMonthsAgo(Object value) {
    return Intl.message(
      '$value Months Ago',
      name: 'kMonthsAgo',
      desc: '',
      args: [value],
    );
  }

  /// `{value} Days Ago`
  String kDaysAgo(Object value) {
    return Intl.message(
      '$value Days Ago',
      name: 'kDaysAgo',
      desc: '',
      args: [value],
    );
  }

  /// `{value} Weeks Ago`
  String kWeeksAgo(Object value) {
    return Intl.message(
      '$value Weeks Ago',
      name: 'kWeeksAgo',
      desc: '',
      args: [value],
    );
  }

  /// `{value} Minutes Ago`
  String kMinutesAgo(Object value) {
    return Intl.message(
      '$value Minutes Ago',
      name: 'kMinutesAgo',
      desc: '',
      args: [value],
    );
  }

  /// `{value} Hours Ago`
  String kHoursAgo(Object value) {
    return Intl.message(
      '$value Hours Ago',
      name: 'kHoursAgo',
      desc: '',
      args: [value],
    );
  }

  /// `1 Month Ago`
  String get k1MonthAgo {
    return Intl.message('1 Month Ago', name: 'k1MonthAgo', desc: '', args: []);
  }

  /// `Last Month`
  String get kLastMonth {
    return Intl.message('Last Month', name: 'kLastMonth', desc: '', args: []);
  }

  /// `1 Week Ago`
  String get k1WeekAgo {
    return Intl.message('1 Week Ago', name: 'k1WeekAgo', desc: '', args: []);
  }

  /// `Last Week`
  String get kLastWeek {
    return Intl.message('Last Week', name: 'kLastWeek', desc: '', args: []);
  }

  /// `1 Day Ago`
  String get k1DayAgo {
    return Intl.message('1 Day Ago', name: 'k1DayAgo', desc: '', args: []);
  }

  /// `Yesterday`
  String get kYesterday {
    return Intl.message('Yesterday', name: 'kYesterday', desc: '', args: []);
  }

  /// `1 Hour Ago`
  String get k1HourAgo {
    return Intl.message('1 Hour Ago', name: 'k1HourAgo', desc: '', args: []);
  }

  /// `An Hour Ago`
  String get kAnHourAgo {
    return Intl.message('An Hour Ago', name: 'kAnHourAgo', desc: '', args: []);
  }

  /// `1 Minute Ago`
  String get k1MinuteAgo {
    return Intl.message(
      '1 Minute Ago',
      name: 'k1MinuteAgo',
      desc: '',
      args: [],
    );
  }

  /// `Minute Ago`
  String get kAMinuteAgo {
    return Intl.message('Minute Ago', name: 'kAMinuteAgo', desc: '', args: []);
  }

  /// `Few Seconds Ago`
  String get kFewSecondsAgo {
    return Intl.message(
      'Few Seconds Ago',
      name: 'kFewSecondsAgo',
      desc: '',
      args: [],
    );
  }

  /// `Just Now`
  String get kJustNow {
    return Intl.message('Just Now', name: 'kJustNow', desc: '', args: []);
  }

  /// `New`
  String get kNew {
    return Intl.message('New', name: 'kNew', desc: '', args: []);
  }

  /// `Balcony`
  String get kBalcony {
    return Intl.message('Balcony', name: 'kBalcony', desc: '', args: []);
  }

  /// `Yes`
  String get kThereIs {
    return Intl.message('Yes', name: 'kThereIs', desc: '', args: []);
  }

  /// `No`
  String get kThereIsNot {
    return Intl.message('No', name: 'kThereIsNot', desc: '', args: []);
  }

  /// `Deposit`
  String get kDeposit {
    return Intl.message('Deposit', name: 'kDeposit', desc: '', args: []);
  }

  /// `Fee`
  String get kFee {
    return Intl.message('Fee', name: 'kFee', desc: '', args: []);
  }

  /// `Search by {value}`
  String kSearch(Object value) {
    return Intl.message(
      'Search by $value',
      name: 'kSearch',
      desc: '',
      args: [value],
    );
  }

  /// `Saved items`
  String get kPDFSaved {
    return Intl.message('Saved items', name: 'kPDFSaved', desc: '', args: []);
  }

  /// `new unused`
  String get kHouseNew {
    return Intl.message('new unused', name: 'kHouseNew', desc: '', args: []);
  }

  /// `Used`
  String get kHouseOld {
    return Intl.message('Used', name: 'kHouseOld', desc: '', args: []);
  }

  /// `Empty`
  String get kHouseState1 {
    return Intl.message('Empty', name: 'kHouseState1', desc: '', args: []);
  }

  /// `tenanted`
  String get kHouseState2 {
    return Intl.message('tenanted', name: 'kHouseState2', desc: '', args: []);
  }

  /// `property owner`
  String get kHouseState3 {
    return Intl.message(
      'property owner',
      name: 'kHouseState3',
      desc: '',
      args: [],
    );
  }

  /// `Ad no`
  String get kAdId {
    return Intl.message('Ad no', name: 'kAdId', desc: '', args: []);
  }

  /// `Date`
  String get kDateAdded {
    return Intl.message('Date', name: 'kDateAdded', desc: '', args: []);
  }

  /// `Modified date`
  String get kLastModified {
    return Intl.message(
      'Modified date',
      name: 'kLastModified',
      desc: '',
      args: [],
    );
  }

  /// `Total area`
  String get kAreaAll {
    return Intl.message('Total area', name: 'kAreaAll', desc: '', args: []);
  }

  /// `Net area`
  String get kAreaNet {
    return Intl.message('Net area', name: 'kAreaNet', desc: '', args: []);
  }

  /// `Explanation`
  String get kExplanation {
    return Intl.message(
      'Explanation',
      name: 'kExplanation',
      desc: '',
      args: [],
    );
  }

  /// `In side site`
  String get kInSideSite {
    return Intl.message(
      'In side site',
      name: 'kInSideSite',
      desc: '',
      args: [],
    );
  }

  /// `Age building`
  String get kAgeBuilding {
    return Intl.message(
      'Age building',
      name: 'kAgeBuilding',
      desc: '',
      args: [],
    );
  }

  /// `Floors`
  String get kFloors {
    return Intl.message('Floors', name: 'kFloors', desc: '', args: []);
  }

  /// `Bathrooms`
  String get kBathrooms {
    return Intl.message('Bathrooms', name: 'kBathrooms', desc: '', args: []);
  }

  /// `Types heating`
  String get kTypesHeating {
    return Intl.message(
      'Types heating',
      name: 'kTypesHeating',
      desc: '',
      args: [],
    );
  }

  /// `Property case`
  String get kPropertyCase {
    return Intl.message(
      'Property case',
      name: 'kPropertyCase',
      desc: '',
      args: [],
    );
  }

  /// `Internal features`
  String get kInternalFeatures {
    return Intl.message(
      'Internal features',
      name: 'kInternalFeatures',
      desc: '',
      args: [],
    );
  }

  /// `External features`
  String get kExternalFeatures {
    return Intl.message(
      'External features',
      name: 'kExternalFeatures',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get kView {
    return Intl.message('View', name: 'kView', desc: '', args: []);
  }

  /// `No`
  String get kNo {
    return Intl.message('No', name: 'kNo', desc: '', args: []);
  }

  /// `Yse`
  String get kYes {
    return Intl.message('Yse', name: 'kYes', desc: '', args: []);
  }

  /// `Ad details`
  String get kAdInfo {
    return Intl.message('Ad details', name: 'kAdInfo', desc: '', args: []);
  }

  /// `Neighborhood`
  String get kNeighborhood {
    return Intl.message(
      'Neighborhood',
      name: 'kNeighborhood',
      desc: '',
      args: [],
    );
  }

  /// `Transportation`
  String get kTransportation {
    return Intl.message(
      'Transportation',
      name: 'kTransportation',
      desc: '',
      args: [],
    );
  }

  /// `Project Type`
  String get kProjectType {
    return Intl.message(
      'Project Type',
      name: 'kProjectType',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get kShare {
    return Intl.message('Share', name: 'kShare', desc: '', args: []);
  }

  /// `Apartment Models`
  String get kRoomPlan {
    return Intl.message(
      'Apartment Models',
      name: 'kRoomPlan',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get kNext {
    return Intl.message('Next', name: 'kNext', desc: '', args: []);
  }

  /// `Add Photo`
  String get kAddPhoto {
    return Intl.message('Add Photo', name: 'kAddPhoto', desc: '', args: []);
  }

  /// `Lease contract information`
  String get kContractInformation {
    return Intl.message(
      'Lease contract information',
      name: 'kContractInformation',
      desc: '',
      args: [],
    );
  }

  /// `Monthly rent`
  String get kMonthlyRent {
    return Intl.message(
      'Monthly rent',
      name: 'kMonthlyRent',
      desc: '',
      args: [],
    );
  }

  /// `First payment`
  String get kDownPayment {
    return Intl.message(
      'First payment',
      name: 'kDownPayment',
      desc: '',
      args: [],
    );
  }

  /// `Date of contract`
  String get kContractDate {
    return Intl.message(
      'Date of contract',
      name: 'kContractDate',
      desc: '',
      args: [],
    );
  }

  /// `Contract Duration`
  String get kContractValidity {
    return Intl.message(
      'Contract Duration',
      name: 'kContractValidity',
      desc: '',
      args: [],
    );
  }

  /// `Rent for what`
  String get kRentForWhat {
    return Intl.message(
      'Rent for what',
      name: 'kRentForWhat',
      desc: '',
      args: [],
    );
  }

  /// `Rent type`
  String get kRentType {
    return Intl.message('Rent type', name: 'kRentType', desc: '', args: []);
  }

  /// `Payment method`
  String get kRentPaymentMethod {
    return Intl.message(
      'Payment method',
      name: 'kRentPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Things`
  String get kThings {
    return Intl.message('Things', name: 'kThings', desc: '', args: []);
  }

  /// `Notes`
  String get kNote {
    return Intl.message('Notes', name: 'kNote', desc: '', args: []);
  }

  /// `Add Thing`
  String get kAddThing {
    return Intl.message('Add Thing', name: 'kAddThing', desc: '', args: []);
  }

  /// `Owner Information`
  String get kOwnerInfo {
    return Intl.message(
      'Owner Information',
      name: 'kOwnerInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name Surname -owner`
  String get kOwnerNameSurName {
    return Intl.message(
      'Name Surname -owner',
      name: 'kOwnerNameSurName',
      desc: '',
      args: [],
    );
  }

  /// `ID-Owner No.`
  String get kOwnerID {
    return Intl.message('ID-Owner No.', name: 'kOwnerID', desc: '', args: []);
  }

  /// `Phone number-owner`
  String get kOwnerPhone {
    return Intl.message(
      'Phone number-owner',
      name: 'kOwnerPhone',
      desc: '',
      args: [],
    );
  }

  /// `Renter Information`
  String get kRenterInfo {
    return Intl.message(
      'Renter Information',
      name: 'kRenterInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name Surname -renter`
  String get kRenterNameSurName {
    return Intl.message(
      'Name Surname -renter',
      name: 'kRenterNameSurName',
      desc: '',
      args: [],
    );
  }

  /// `ID-Renter No.`
  String get kRenterId {
    return Intl.message('ID-Renter No.', name: 'kRenterId', desc: '', args: []);
  }

  /// `Phone number-renter`
  String get kRenterPhone {
    return Intl.message(
      'Phone number-renter',
      name: 'kRenterPhone',
      desc: '',
      args: [],
    );
  }

  /// `add renter`
  String get kAddRenters {
    return Intl.message('add renter', name: 'kAddRenters', desc: '', args: []);
  }

  /// `Do you want to delete {value}`
  String kDeleteMessage(Object value) {
    return Intl.message(
      'Do you want to delete $value',
      name: 'kDeleteMessage',
      desc: '',
      args: [value],
    );
  }

  /// `Contract list`
  String get kContractList {
    return Intl.message(
      'Contract list',
      name: 'kContractList',
      desc: '',
      args: [],
    );
  }

  /// `Rent list`
  String get kRentList {
    return Intl.message('Rent list', name: 'kRentList', desc: '', args: []);
  }

  /// `Sale list`
  String get kSaleList {
    return Intl.message('Sale list', name: 'kSaleList', desc: '', args: []);
  }

  /// `Users list`
  String get kUsersList {
    return Intl.message('Users list', name: 'kUsersList', desc: '', args: []);
  }

  /// `About`
  String get kAbout {
    return Intl.message('About', name: 'kAbout', desc: '', args: []);
  }

  /// `Contact`
  String get kContact {
    return Intl.message('Contact', name: 'kContact', desc: '', args: []);
  }

  /// `logo_no_background_en`
  String get kLogoPath {
    return Intl.message(
      'logo_no_background_en',
      name: 'kLogoPath',
      desc: '',
      args: [],
    );
  }

  /// `Your message`
  String get kMessage {
    return Intl.message('Your message', name: 'kMessage', desc: '', args: []);
  }

  /// `Want to buy?`
  String get kDoYouBuy {
    return Intl.message('Want to buy?', name: 'kDoYouBuy', desc: '', args: []);
  }

  /// `Want to sell ?`
  String get kDoYouSell {
    return Intl.message(
      'Want to sell ?',
      name: 'kDoYouSell',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get kOffers {
    return Intl.message('Offers', name: 'kOffers', desc: '', args: []);
  }

  /// `Description`
  String get kDescription {
    return Intl.message(
      'Description',
      name: 'kDescription',
      desc: '',
      args: [],
    );
  }

  /// `You can contact us through the following links by clicking on the appropriate communication icon for you`
  String get kMessageContact {
    return Intl.message(
      'You can contact us through the following links by clicking on the appropriate communication icon for you',
      name: 'kMessageContact',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us for help`
  String get kMessageContactToHelp {
    return Intl.message(
      'Contact Us for help',
      name: 'kMessageContactToHelp',
      desc: '',
      args: [],
    );
  }

  /// `Communication`
  String get kCommunication {
    return Intl.message(
      'Communication',
      name: 'kCommunication',
      desc: '',
      args: [],
    );
  }

  /// `Urgent sale`
  String get kUrgent {
    return Intl.message('Urgent sale', name: 'kUrgent', desc: '', args: []);
  }

  /// `Urgent`
  String get kUrgent1 {
    return Intl.message('Urgent', name: 'kUrgent1', desc: '', args: []);
  }

  /// `Opportunity`
  String get kUrgent2 {
    return Intl.message('Opportunity', name: 'kUrgent2', desc: '', args: []);
  }

  /// `Urgent Offers`
  String get kUrgentTitle {
    return Intl.message(
      'Urgent Offers',
      name: 'kUrgentTitle',
      desc: '',
      args: [],
    );
  }

  /// `The image has been saved successfully {path}`
  String kMessageSaveImageTrue(Object path) {
    return Intl.message(
      'The image has been saved successfully $path',
      name: 'kMessageSaveImageTrue',
      desc: '',
      args: [path],
    );
  }

  /// `Number of offers {count}`
  String kOfferLength(Object count) {
    return Intl.message(
      'Number of offers $count',
      name: 'kOfferLength',
      desc: '',
      args: [count],
    );
  }

  /// `Close`
  String get kClose {
    return Intl.message('Close', name: 'kClose', desc: '', args: []);
  }

  /// `The offers on the site are priced on the Turkish lira. When the currency changes from the Turkish currency to another currency, the exchange rate is roughly calculated on the basis of the exchange rates of the World Central Bank.`
  String get kNoteExchangeRate {
    return Intl.message(
      'The offers on the site are priced on the Turkish lira. When the currency changes from the Turkish currency to another currency, the exchange rate is roughly calculated on the basis of the exchange rates of the World Central Bank.',
      name: 'kNoteExchangeRate',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get kempty {
    return Intl.message('Empty', name: 'kempty', desc: '', args: []);
  }

  /// `Street / Detailed Address`
  String get kStreet {
    return Intl.message(
      'Street / Detailed Address',
      name: 'kStreet',
      desc: '',
      args: [],
    );
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

  /// `Usage Status`
  String get kSaleRequestTextField9 {
    return Intl.message(
      'Usage Status',
      name: 'kSaleRequestTextField9',
      desc: '',
      args: [],
    );
  }

  /// `Asking price (₺)`
  String get kSaleRequestTextField10 {
    return Intl.message(
      'Asking price (₺)',
      name: 'kSaleRequestTextField10',
      desc: '',
      args: [],
    );
  }

  /// `Name Surname`
  String get kSaleRequestTextField11 {
    return Intl.message(
      'Name Surname',
      name: 'kSaleRequestTextField11',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get kSaleRequestTextField12 {
    return Intl.message(
      'Phone number',
      name: 'kSaleRequestTextField12',
      desc: '',
      args: [],
    );
  }

  /// `Email address (optional)`
  String get kSaleRequestTextField13 {
    return Intl.message(
      'Email address (optional)',
      name: 'kSaleRequestTextField13',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get testfortest {
    return Intl.message('Hi', name: 'testfortest', desc: '', args: []);
  }

  /// `Add new`
  String get testfort333est {
    return Intl.message('Add new', name: 'testfort333est', desc: '', args: []);
  }

  /// `Add new`
  String get testfort333eeeeest {
    return Intl.message(
      'Add new',
      name: 'testfort333eeeeest',
      desc: '',
      args: [],
    );
  }

  /// `E-Contract`
  String get appName {
    return Intl.message('E-Contract', name: 'appName', desc: '', args: []);
  }

  /// `Sing In`
  String get singIn {
    return Intl.message('Sing In', name: 'singIn', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `continue`
  String get Continue {
    return Intl.message('continue', name: 'Continue', desc: '', args: []);
  }

  /// `To continue please enter your email & password`
  String get ToContinue {
    return Intl.message(
      'To continue please enter your email & password',
      name: 'ToContinue',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty..`
  String get fieldEmpty {
    return Intl.message(
      'This field cannot be empty..',
      name: 'fieldEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Location of property`
  String get LocationTile {
    return Intl.message(
      'Location of property',
      name: 'LocationTile',
      desc: '',
      args: [],
    );
  }

  /// `List rent`
  String get RentalList {
    return Intl.message('List rent', name: 'RentalList', desc: '', args: []);
  }

  /// `Advertising photos`
  String get adPhoto {
    return Intl.message(
      'Advertising photos',
      name: 'adPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Details Ad`
  String get Detail_Ad {
    return Intl.message('Details Ad', name: 'Detail_Ad', desc: '', args: []);
  }

  /// `Rooms`
  String get rooms {
    return Intl.message('Rooms', name: 'rooms', desc: '', args: []);
  }

  /// `Floor`
  String get floor {
    return Intl.message('Floor', name: 'floor', desc: '', args: []);
  }

  /// `Rent`
  String get rent {
    return Intl.message('Rent', name: 'rent', desc: '', args: []);
  }

  /// `Age building`
  String get ageBuilding {
    return Intl.message(
      'Age building',
      name: 'ageBuilding',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get Deposit {
    return Intl.message('Deposit', name: 'Deposit', desc: '', args: []);
  }

  /// `Furnished`
  String get state {
    return Intl.message('Furnished', name: 'state', desc: '', args: []);
  }

  /// `Inside site`
  String get inSideSite {
    return Intl.message('Inside site', name: 'inSideSite', desc: '', args: []);
  }

  /// `Fee`
  String get fee {
    return Intl.message('Fee', name: 'fee', desc: '', args: []);
  }

  /// `Ad Date`
  String get dateAd {
    return Intl.message('Ad Date', name: 'dateAd', desc: '', args: []);
  }

  /// `Net Area`
  String get net_area {
    return Intl.message('Net Area', name: 'net_area', desc: '', args: []);
  }

  /// `Area`
  String get area {
    return Intl.message('Area', name: 'area', desc: '', args: []);
  }

  /// `Balcony`
  String get balcony {
    return Intl.message('Balcony', name: 'balcony', desc: '', args: []);
  }

  /// `Ad No`
  String get adNo {
    return Intl.message('Ad No', name: 'adNo', desc: '', args: []);
  }

  /// `Ad information`
  String get Ad_information {
    return Intl.message(
      'Ad information',
      name: 'Ad_information',
      desc: '',
      args: [],
    );
  }

  /// `Ad photos`
  String get images {
    return Intl.message('Ad photos', name: 'images', desc: '', args: []);
  }

  /// `view all`
  String get viewAll {
    return Intl.message('view all', name: 'viewAll', desc: '', args: []);
  }

  /// `explanation`
  String get explanation {
    return Intl.message('explanation', name: 'explanation', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Ad information`
  String get AdInformation {
    return Intl.message(
      'Ad information',
      name: 'AdInformation',
      desc: '',
      args: [],
    );
  }

  /// `Must make an appointment {value}`
  String kYouShouldTakeDate(Object value) {
    return Intl.message(
      'Must make an appointment $value',
      name: 'kYouShouldTakeDate',
      desc: '',
      args: [value],
    );
  }

  /// `Take an appointment now`
  String get kTakeAppointment {
    return Intl.message(
      'Take an appointment now',
      name: 'kTakeAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Property viewing date`
  String get kTakeAppointmentToWatch {
    return Intl.message(
      'Property viewing date',
      name: 'kTakeAppointmentToWatch',
      desc: '',
      args: [],
    );
  }

  /// `Name Surname`
  String get kNameSurname {
    return Intl.message(
      'Name Surname',
      name: 'kNameSurname',
      desc: '',
      args: [],
    );
  }

  /// `Phone number with country code`
  String get kPhoneNumber {
    return Intl.message(
      'Phone number with country code',
      name: 'kPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Appointment date`
  String get kAppointmentDate {
    return Intl.message(
      'Appointment date',
      name: 'kAppointmentDate',
      desc: '',
      args: [],
    );
  }

  /// `Are you in Turkey?`
  String get kAskClientIsInTurkey {
    return Intl.message(
      'Are you in Turkey?',
      name: 'kAskClientIsInTurkey',
      desc: '',
      args: [],
    );
  }

  /// `Thank you, we will contact you to confirm and set the appointment time`
  String get kAppointmentMessageSend {
    return Intl.message(
      'Thank you, we will contact you to confirm and set the appointment time',
      name: 'kAppointmentMessageSend',
      desc: '',
      args: [],
    );
  }

  /// `RENTAL CONTRACT`
  String get kira_title {
    return Intl.message(
      'RENTAL CONTRACT',
      name: 'kira_title',
      desc: '',
      args: [],
    );
  }

  /// `Province`
  String get province {
    return Intl.message('Province', name: 'province', desc: '', args: []);
  }

  /// `District`
  String get district {
    return Intl.message('District', name: 'district', desc: '', args: []);
  }

  /// `neighborhood`
  String get neighborhood {
    return Intl.message(
      'neighborhood',
      name: 'neighborhood',
      desc: '',
      args: [],
    );
  }

  /// `Avenue/Street`
  String get AvenueStreet {
    return Intl.message(
      'Avenue/Street',
      name: 'AvenueStreet',
      desc: '',
      args: [],
    );
  }

  /// `Apartmant no:`
  String get apartman {
    return Intl.message('Apartmant no:', name: 'apartman', desc: '', args: []);
  }

  /// `Blok No`
  String get blokNo {
    return Intl.message('Blok No', name: 'blokNo', desc: '', args: []);
  }

  /// `RENTER - HOSTED BY`
  String get RENTERHOSTED {
    return Intl.message(
      'RENTER - HOSTED BY',
      name: 'RENTERHOSTED',
      desc: '',
      args: [],
    );
  }

  /// `Name Surname`
  String get nameSurname {
    return Intl.message(
      'Name Surname',
      name: 'nameSurname',
      desc: '',
      args: [],
    );
  }

  /// `ID number`
  String get id {
    return Intl.message('ID number', name: 'id', desc: '', args: []);
  }

  /// `Place of residence`
  String get placeResidenceOwner {
    return Intl.message(
      'Place of residence',
      name: 'placeResidenceOwner',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get Contact {
    return Intl.message('Contact', name: 'Contact', desc: '', args: []);
  }

  /// `Tenant`
  String get TENANT {
    return Intl.message('Tenant', name: 'TENANT', desc: '', args: []);
  }

  /// `Name Surname`
  String get TENANTnameSurname {
    return Intl.message(
      'Name Surname',
      name: 'TENANTnameSurname',
      desc: '',
      args: [],
    );
  }

  /// `ID number`
  String get TENANTid {
    return Intl.message('ID number', name: 'TENANTid', desc: '', args: []);
  }

  /// `Place of residence`
  String get TENANTplaceResidenceOwner {
    return Intl.message(
      'Place of residence',
      name: 'TENANTplaceResidenceOwner',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get TENANTContact {
    return Intl.message('Contact', name: 'TENANTContact', desc: '', args: []);
  }

  /// `Monthly rent`
  String get monthlyRent {
    return Intl.message(
      'Monthly rent',
      name: 'monthlyRent',
      desc: '',
      args: [],
    );
  }

  /// `Monthly rent summer`
  String get monthlyRentSummer {
    return Intl.message(
      'Monthly rent summer',
      name: 'monthlyRentSummer',
      desc: '',
      args: [],
    );
  }

  /// `Annual rent`
  String get annualRent {
    return Intl.message('Annual rent', name: 'annualRent', desc: '', args: []);
  }

  /// `Annual rent summer`
  String get annualRentSummer {
    return Intl.message(
      'Annual rent summer',
      name: 'annualRentSummer',
      desc: '',
      args: [],
    );
  }

  /// `Down payment`
  String get downpayment {
    return Intl.message(
      'Down payment',
      name: 'downpayment',
      desc: '',
      args: [],
    );
  }

  /// `Down payment summer`
  String get downpaymentSummer {
    return Intl.message(
      'Down payment summer',
      name: 'downpaymentSummer',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message('Deposit', name: 'deposit', desc: '', args: []);
  }

  /// `Deposit Summer`
  String get depositSummer {
    return Intl.message(
      'Deposit Summer',
      name: 'depositSummer',
      desc: '',
      args: [],
    );
  }

  /// `Beginning of rent`
  String get beginningofrent {
    return Intl.message(
      'Beginning of rent',
      name: 'beginningofrent',
      desc: '',
      args: [],
    );
  }

  /// `Current status of the rented`
  String get Current_status_aforementioned {
    return Intl.message(
      'Current status of the rented',
      name: 'Current_status_aforementioned',
      desc: '',
      args: [],
    );
  }

  /// `Rental period`
  String get rentalPeriod {
    return Intl.message(
      'Rental period',
      name: 'rentalPeriod',
      desc: '',
      args: [],
    );
  }

  /// `What will be used for the rented`
  String get WhatWillUsedForTheRented {
    return Intl.message(
      'What will be used for the rented',
      name: 'WhatWillUsedForTheRented',
      desc: '',
      args: [],
    );
  }

  /// `How to pay the rent`
  String get payRent {
    return Intl.message(
      'How to pay the rent',
      name: 'payRent',
      desc: '',
      args: [],
    );
  }

  /// `Final Result`
  String get finalResult {
    return Intl.message(
      'Final Result',
      name: 'finalResult',
      desc: '',
      args: [],
    );
  }

  /// `User Id`
  String get user_id {
    return Intl.message('User Id', name: 'user_id', desc: '', args: []);
  }

  /// `Lease Contracts`
  String get leaseContracts {
    return Intl.message(
      'Lease Contracts',
      name: 'leaseContracts',
      desc: '',
      args: [],
    );
  }

  /// `App Developer`
  String get applicationDeveloper {
    return Intl.message(
      'App Developer',
      name: 'applicationDeveloper',
      desc: '',
      args: [],
    );
  }

  /// `Things that were delivered with the house`
  String get furniture {
    return Intl.message(
      'Things that were delivered with the house',
      name: 'furniture',
      desc: '',
      args: [],
    );
  }

  /// `An example of a contract`
  String get example {
    return Intl.message(
      'An example of a contract',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `Writing a new contract`
  String get contract {
    return Intl.message(
      'Writing a new contract',
      name: 'contract',
      desc: '',
      args: [],
    );
  }

  /// `Attention ⚠︎ ⛔️`
  String get fieldEmptyTitle {
    return Intl.message(
      'Attention ⚠︎ ⛔️',
      name: 'fieldEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure that all data are entered`
  String get fieldEmptyMessage {
    return Intl.message(
      'Please ensure that all data are entered',
      name: 'fieldEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Close️`
  String get DISMISS {
    return Intl.message('Close️', name: 'DISMISS', desc: '', args: []);
  }

  /// `This field cannot be empty`
  String get fieldError {
    return Intl.message(
      'This field cannot be empty',
      name: 'fieldError',
      desc: '',
      args: [],
    );
  }

  /// `Show pdf`
  String get showPdf {
    return Intl.message('Show pdf', name: 'showPdf', desc: '', args: []);
  }

  /// `List is Empty`
  String get listEmpty {
    return Intl.message('List is Empty', name: 'listEmpty', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Yes`
  String get yse {
    return Intl.message('Yes', name: 'yse', desc: '', args: []);
  }

  /// `Do you want to delete the file !!`
  String get deleteFileMessage {
    return Intl.message(
      'Do you want to delete the file !!',
      name: 'deleteFileMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Monthly rent , Deposit `
  String get prices {
    return Intl.message(
      'Monthly rent , Deposit ',
      name: 'prices',
      desc: '',
      args: [],
    );
  }

  /// `rent: price,time,pay`
  String get rentTitleTimeState {
    return Intl.message(
      'rent: price,time,pay',
      name: 'rentTitleTimeState',
      desc: '',
      args: [],
    );
  }

  /// `Property location`
  String get houseLocation {
    return Intl.message(
      'Property location',
      name: 'houseLocation',
      desc: '',
      args: [],
    );
  }

  /// `add person`
  String get addPerson {
    return Intl.message('add person', name: 'addPerson', desc: '', args: []);
  }

  /// `RENT : `
  String get kira {
    return Intl.message('RENT : ', name: 'kira', desc: '', args: []);
  }

  /// `DATE : `
  String get date {
    return Intl.message('DATE : ', name: 'date', desc: '', args: []);
  }

  /// `FLAT : `
  String get flat {
    return Intl.message('FLAT : ', name: 'flat', desc: '', args: []);
  }

  /// `BLOK : `
  String get blok {
    return Intl.message('BLOK : ', name: 'blok', desc: '', args: []);
  }

  /// `Flat Numbers : `
  String get flatNumbers {
    return Intl.message(
      'Flat Numbers : ',
      name: 'flatNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Add Flat`
  String get flat_add {
    return Intl.message('Add Flat', name: 'flat_add', desc: '', args: []);
  }

  /// `Add Flat Images`
  String get flat_add_photo {
    return Intl.message(
      'Add Flat Images',
      name: 'flat_add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Flat List`
  String get flat_list {
    return Intl.message('Flat List', name: 'flat_list', desc: '', args: []);
  }

  /// `Site name : `
  String get site_name {
    return Intl.message('Site name : ', name: 'site_name', desc: '', args: []);
  }

  /// `Add Photo`
  String get add_photo {
    return Intl.message('Add Photo', name: 'add_photo', desc: '', args: []);
  }

  /// `uploading`
  String get uploading {
    return Intl.message('uploading', name: 'uploading', desc: '', args: []);
  }

  /// `flat photo`
  String get photoFlat {
    return Intl.message('flat photo', name: 'photoFlat', desc: '', args: []);
  }

  /// `flat photo Empty`
  String get noPhotoFlat {
    return Intl.message(
      'flat photo Empty',
      name: 'noPhotoFlat',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Apartment`
  String get daire {
    return Intl.message('Apartment', name: 'daire', desc: '', args: []);
  }

  /// `Build`
  String get bina {
    return Intl.message('Build', name: 'bina', desc: '', args: []);
  }

  /// `Phone`
  String get numara {
    return Intl.message('Phone', name: 'numara', desc: '', args: []);
  }

  /// `Date`
  String get tarih {
    return Intl.message('Date', name: 'tarih', desc: '', args: []);
  }

  /// `Rent`
  String get Kira {
    return Intl.message('Rent', name: 'Kira', desc: '', args: []);
  }

  /// `Update`
  String get edit {
    return Intl.message('Update', name: 'edit', desc: '', args: []);
  }

  /// `price`
  String get price {
    return Intl.message('price', name: 'price', desc: '', args: []);
  }

  /// `For Sale List`
  String get forSaleList {
    return Intl.message(
      'For Sale List',
      name: 'forSaleList',
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
