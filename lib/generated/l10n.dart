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

  /// `EYE Win`
  String get app_name {
    return Intl.message('EYE Win', name: 'app_name', desc: '', args: []);
  }

  /// `Total Rebate:`
  String get total_rebate {
    return Intl.message(
      'Total Rebate:',
      name: 'total_rebate',
      desc: '',
      args: [],
    );
  }

  /// `{monthly_balance} Balance to Achieve Target`
  String monthly_balance(Object monthly_balance) {
    return Intl.message(
      '$monthly_balance Balance to Achieve Target',
      name: 'monthly_balance',
      desc: '',
      args: [monthly_balance],
    );
  }

  /// `Quarter {quarterly_balance} Balance to Achieve Target`
  String quarterly_balance(Object quarterly_balance) {
    return Intl.message(
      'Quarter $quarterly_balance Balance to Achieve Target',
      name: 'quarterly_balance',
      desc: '',
      args: [quarterly_balance],
    );
  }

  /// `Semester {biannual_balance} Balance to Achieve Target`
  String biannual_balance(Object biannual_balance) {
    return Intl.message(
      'Semester $biannual_balance Balance to Achieve Target',
      name: 'biannual_balance',
      desc: '',
      args: [biannual_balance],
    );
  }

  /// `Yearly Balance to Achieve Target`
  String get yearly_balance {
    return Intl.message(
      'Yearly Balance to Achieve Target',
      name: 'yearly_balance',
      desc: '',
      args: [],
    );
  }

  /// `Period {tri_balance} Balance to Achieve Target`
  String tri_balance(Object tri_balance) {
    return Intl.message(
      'Period $tri_balance Balance to Achieve Target',
      name: 'tri_balance',
      desc: '',
      args: [tri_balance],
    );
  }

  /// `Period {bi_monthly_balance} Balance to Achieve Target`
  String bi_monthly_balance(Object bi_monthly_balance) {
    return Intl.message(
      'Period $bi_monthly_balance Balance to Achieve Target',
      name: 'bi_monthly_balance',
      desc: '',
      args: [bi_monthly_balance],
    );
  }

  /// `Secondary Displays`
  String get secondary_displays {
    return Intl.message(
      'Secondary Displays',
      name: 'secondary_displays',
      desc: '',
      args: [],
    );
  }

  /// `Primary Displays`
  String get primary_displays {
    return Intl.message(
      'Primary Displays',
      name: 'primary_displays',
      desc: '',
      args: [],
    );
  }

  /// `Pictures`
  String get pictures {
    return Intl.message('Pictures', name: 'pictures', desc: '', args: []);
  }

  /// `Settings`
  String get action_settings {
    return Intl.message(
      'Settings',
      name: 'action_settings',
      desc: '',
      args: [],
    );
  }

  /// `See picture`
  String get see_picture {
    return Intl.message('See picture', name: 'see_picture', desc: '', args: []);
  }

  /// `Capture Price`
  String get capture_price {
    return Intl.message(
      'Capture Price',
      name: 'capture_price',
      desc: '',
      args: [],
    );
  }

  /// `Shelf Price`
  String get shelf_price {
    return Intl.message('Shelf Price', name: 'shelf_price', desc: '', args: []);
  }

  /// `Save Price`
  String get save_price {
    return Intl.message('Save Price', name: 'save_price', desc: '', args: []);
  }

  /// `Log In Failed`
  String get login_failed {
    return Intl.message(
      'Log In Failed',
      name: 'login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connection_error {
    return Intl.message(
      'Connection Error',
      name: 'connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again.`
  String get defaul_internet_connection_error {
    return Intl.message(
      'Please check your internet connection and try again.',
      name: 'defaul_internet_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Offline Mode`
  String get offline_mode_connection_error {
    return Intl.message(
      'Offline Mode',
      name: 'offline_mode_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be performed while in offline mode.`
  String get offline_mode_internet_connection_error {
    return Intl.message(
      'This action cannot be performed while in offline mode.',
      name: 'offline_mode_internet_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get error_has_occured_title {
    return Intl.message(
      'Warning',
      name: 'error_has_occured_title',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please contact your Administrator for help and support.`
  String get error_hasoccured_msg {
    return Intl.message(
      'Something went wrong. Please contact your Administrator for help and support.',
      name: 'error_hasoccured_msg',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning_title {
    return Intl.message('Warning', name: 'warning_title', desc: '', args: []);
  }

  /// `Log In Again`
  String get login_again {
    return Intl.message(
      'Log In Again',
      name: 'login_again',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please log in again.`
  String get session_expired {
    return Intl.message(
      'Your session has expired. Please log in again.',
      name: 'session_expired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password. Review your credentials and try again.`
  String get invalid_credentials {
    return Intl.message(
      'Invalid username or password. Review your credentials and try again.',
      name: 'invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get request_timeout_title {
    return Intl.message(
      'Connection Error',
      name: 'request_timeout_title',
      desc: '',
      args: [],
    );
  }

  /// `A connection error has occurred. Try working in Offline Mode. Please contact your Administrator for help and support.`
  String get request_timeout_msg {
    return Intl.message(
      'A connection error has occurred. Try working in Offline Mode. Please contact your Administrator for help and support.',
      name: 'request_timeout_msg',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please contact your Administrator for help and support.`
  String get internal_server_error {
    return Intl.message(
      'Something went wrong. Please contact your Administrator for help and support.',
      name: 'internal_server_error',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later or contact your Administrator for help and support.`
  String get server_not_found_error {
    return Intl.message(
      'Something went wrong. Please try again later or contact your Administrator for help and support.',
      name: 'server_not_found_error',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Close`
  String get back {
    return Intl.message('Close', name: 'back', desc: '', args: []);
  }

  /// `Okay`
  String get ok {
    return Intl.message('Okay', name: 'ok', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `You cannot use your credentials to login to this app.`
  String get not_user_role {
    return Intl.message(
      'You cannot use your credentials to login to this app.',
      name: 'not_user_role',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get time_sync_error_title {
    return Intl.message(
      'Connection Error',
      name: 'time_sync_error_title',
      desc: '',
      args: [],
    );
  }

  /// `Please check the date and time of your device and try again.`
  String get time_sync_error {
    return Intl.message(
      'Please check the date and time of your device and try again.',
      name: 'time_sync_error',
      desc: '',
      args: [],
    );
  }

  /// `Storage Full`
  String get storage_full {
    return Intl.message(
      'Storage Full',
      name: 'storage_full',
      desc: '',
      args: [],
    );
  }

  /// `There is not enough storage on your device for EYE2 to operate. To use EYE2, free up at least {storage_full_text} MB.\n\nTo free space, you can delete apps you no longer use and images / large videos from your gallery.`
  String storage_full_text(Object storage_full_text) {
    return Intl.message(
      'There is not enough storage on your device for EYE2 to operate. To use EYE2, free up at least $storage_full_text MB.\n\nTo free space, you can delete apps you no longer use and images / large videos from your gallery.',
      name: 'storage_full_text',
      desc: '',
      args: [storage_full_text],
    );
  }

  /// `Your device’s battery is low. EYE2 will stop working when your battery reaches 5%.`
  String get battery_warning_level_10 {
    return Intl.message(
      'Your device’s battery is low. EYE2 will stop working when your battery reaches 5%.',
      name: 'battery_warning_level_10',
      desc: '',
      args: [],
    );
  }

  /// `Your device’s battery is critically low. EYE2 will now close. Recharge your device to be able to use EYE2.`
  String get battery_warning_level_5 {
    return Intl.message(
      'Your device’s battery is critically low. EYE2 will now close. Recharge your device to be able to use EYE2.',
      name: 'battery_warning_level_5',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message('days', name: 'days', desc: '', args: []);
  }

  /// `hours`
  String get hours {
    return Intl.message('hours', name: 'hours', desc: '', args: []);
  }

  /// `mins`
  String get mins {
    return Intl.message('mins', name: 'mins', desc: '', args: []);
  }

  /// `secs`
  String get secs {
    return Intl.message('secs', name: 'secs', desc: '', args: []);
  }

  /// `Loading…`
  String get loading {
    return Intl.message('Loading…', name: 'loading', desc: '', args: []);
  }

  /// `Select Image`
  String get select_image {
    return Intl.message(
      'Select Image',
      name: 'select_image',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Username`
  String get username_hint {
    return Intl.message('Username', name: 'username_hint', desc: '', args: []);
  }

  /// `Password`
  String get password_hint {
    return Intl.message('Password', name: 'password_hint', desc: '', args: []);
  }

  /// `Version {version_nb}`
  String version_nb(Object version_nb) {
    return Intl.message(
      'Version $version_nb',
      name: 'version_nb',
      desc: '',
      args: [version_nb],
    );
  }

  /// `This field is required`
  String get required_field {
    return Intl.message(
      'This field is required',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Logging in…`
  String get logging_in {
    return Intl.message('Logging in…', name: 'logging_in', desc: '', args: []);
  }

  /// `Preparing card`
  String get preparing_card {
    return Intl.message(
      'Preparing card',
      name: 'preparing_card',
      desc: '',
      args: [],
    );
  }

  /// `No storage card`
  String get no_storage_card {
    return Intl.message(
      'No storage card',
      name: 'no_storage_card',
      desc: '',
      args: [],
    );
  }

  /// `Not enough space`
  String get not_enough_space {
    return Intl.message(
      'Not enough space',
      name: 'not_enough_space',
      desc: '',
      args: [],
    );
  }

  /// `Perfect Store Guidelines`
  String get perfect_store_guidelines {
    return Intl.message(
      'Perfect Store Guidelines',
      name: 'perfect_store_guidelines',
      desc: '',
      args: [],
    );
  }

  /// `Perfect Store Guidelines`
  String get guidelines {
    return Intl.message(
      'Perfect Store Guidelines',
      name: 'guidelines',
      desc: '',
      args: [],
    );
  }

  /// `Points Guidelines`
  String get points_guidelines {
    return Intl.message(
      'Points Guidelines',
      name: 'points_guidelines',
      desc: '',
      args: [],
    );
  }

  /// `My Customers`
  String get my_customers {
    return Intl.message(
      'My Customers',
      name: 'my_customers',
      desc: '',
      args: [],
    );
  }

  /// `My Suppliers`
  String get my_suppliers {
    return Intl.message(
      'My Suppliers',
      name: 'my_suppliers',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message('Product', name: 'product', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Place`
  String get place {
    return Intl.message('Place', name: 'place', desc: '', args: []);
  }

  /// `Promo`
  String get promo {
    return Intl.message('Promo', name: 'promo', desc: '', args: []);
  }

  /// `Search for a customer…`
  String get search_customer {
    return Intl.message(
      'Search for a customer…',
      name: 'search_customer',
      desc: '',
      args: [],
    );
  }

  /// `Search for a Supplier…`
  String get search_supplier {
    return Intl.message(
      'Search for a Supplier…',
      name: 'search_supplier',
      desc: '',
      args: [],
    );
  }

  /// `Importing missions…`
  String get importing_channels_data {
    return Intl.message(
      'Importing missions…',
      name: 'importing_channels_data',
      desc: '',
      args: [],
    );
  }

  /// `Download completed`
  String get download_complete {
    return Intl.message(
      'Download completed',
      name: 'download_complete',
      desc: '',
      args: [],
    );
  }

  /// `Downloading missions…`
  String get downloading_channels_data {
    return Intl.message(
      'Downloading missions…',
      name: 'downloading_channels_data',
      desc: '',
      args: [],
    );
  }

  /// `Take pictures of all your categories`
  String get take_pictures {
    return Intl.message(
      'Take pictures of all your categories',
      name: 'take_pictures',
      desc: '',
      args: [],
    );
  }

  /// `Add a Watchout`
  String get add_watchout {
    return Intl.message(
      'Add a Watchout',
      name: 'add_watchout',
      desc: '',
      args: [],
    );
  }

  /// `Pictures Taken`
  String get pictures_taken {
    return Intl.message(
      'Pictures Taken',
      name: 'pictures_taken',
      desc: '',
      args: [],
    );
  }

  /// `Picture Taken`
  String get picture_taken {
    return Intl.message(
      'Picture Taken',
      name: 'picture_taken',
      desc: '',
      args: [],
    );
  }

  /// `Guidelines`
  String get guidelines_ps {
    return Intl.message(
      'Guidelines',
      name: 'guidelines_ps',
      desc: '',
      args: [],
    );
  }

  /// `SKUs`
  String get skus {
    return Intl.message('SKUs', name: 'skus', desc: '', args: []);
  }

  /// `Not Available`
  String get not_available {
    return Intl.message(
      'Not Available',
      name: 'not_available',
      desc: '',
      args: [],
    );
  }

  /// `All {all_skus_available} SKUs available!`
  String all_skus_available(Object all_skus_available) {
    return Intl.message(
      'All $all_skus_available SKUs available!',
      name: 'all_skus_available',
      desc: '',
      args: [all_skus_available],
    );
  }

  /// `Search`
  String get search_title {
    return Intl.message('Search', name: 'search_title', desc: '', args: []);
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `PTS`
  String get pts {
    return Intl.message('PTS', name: 'pts', desc: '', args: []);
  }

  /// `Filter your Perfect Store Guidelines:`
  String get filter_perfect_store_guidelines {
    return Intl.message(
      'Filter your Perfect Store Guidelines:',
      name: 'filter_perfect_store_guidelines',
      desc: '',
      args: [],
    );
  }

  /// `Filter your Points Guidelines:`
  String get filter_points_guidelines {
    return Intl.message(
      'Filter your Points Guidelines:',
      name: 'filter_points_guidelines',
      desc: '',
      args: [],
    );
  }

  /// `Clusters`
  String get channels {
    return Intl.message('Clusters', name: 'channels', desc: '', args: []);
  }

  /// `KPIs`
  String get kpis {
    return Intl.message('KPIs', name: 'kpis', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Locations`
  String get locations {
    return Intl.message('Locations', name: 'locations', desc: '', args: []);
  }

  /// `Complete your mission`
  String get complete_mission {
    return Intl.message(
      'Complete your mission',
      name: 'complete_mission',
      desc: '',
      args: [],
    );
  }

  /// `Your mission is uploaded`
  String get mission_uploaded {
    return Intl.message(
      'Your mission is uploaded',
      name: 'mission_uploaded',
      desc: '',
      args: [],
    );
  }

  /// `Perfect Store`
  String get perfect_store {
    return Intl.message(
      'Perfect Store',
      name: 'perfect_store',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get sales {
    return Intl.message('Sales', name: 'sales', desc: '', args: []);
  }

  /// `Score Range`
  String get score_range {
    return Intl.message('Score Range', name: 'score_range', desc: '', args: []);
  }

  /// `Sales Value`
  String get sales_value {
    return Intl.message('Sales Value', name: 'sales_value', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `Visited`
  String get visited {
    return Intl.message('Visited', name: 'visited', desc: '', args: []);
  }

  /// `© {copy_right}, eQuality SARL`
  String copy_right(Object copy_right) {
    return Intl.message(
      '© $copy_right, eQuality SARL',
      name: 'copy_right',
      desc: '',
      args: [copy_right],
    );
  }

  /// `Store Audit:`
  String get store_check {
    return Intl.message(
      'Store Audit:',
      name: 'store_check',
      desc: '',
      args: [],
    );
  }

  /// `MAX POINTS TO EARN THIS VISIT:`
  String get max_points_to_earn {
    return Intl.message(
      'MAX POINTS TO EARN THIS VISIT:',
      name: 'max_points_to_earn',
      desc: '',
      args: [],
    );
  }

  /// `Your mission is already completed.`
  String get view_only_mission_completed {
    return Intl.message(
      'Your mission is already completed.',
      name: 'view_only_mission_completed',
      desc: '',
      args: [],
    );
  }

  /// `You have enough\npoints to claim a gift!`
  String get you_have_enough_points {
    return Intl.message(
      'You have enough\npoints to claim a gift!',
      name: 'you_have_enough_points',
      desc: '',
      args: [],
    );
  }

  /// `POINTS NEEDED TO WIN A BIGGER GIFT:`
  String get points_needed_for_bigger_gift {
    return Intl.message(
      'POINTS NEEDED TO WIN A BIGGER GIFT:',
      name: 'points_needed_for_bigger_gift',
      desc: '',
      args: [],
    );
  }

  /// `POINTS NEEDED TO WIN A GIFT:`
  String get points_needed_for_gift {
    return Intl.message(
      'POINTS NEEDED TO WIN A GIFT:',
      name: 'points_needed_for_gift',
      desc: '',
      args: [],
    );
  }

  /// `Perfect Store Score`
  String get perfect_store_score {
    return Intl.message(
      'Perfect Store Score',
      name: 'perfect_store_score',
      desc: '',
      args: [],
    );
  }

  /// `Last visit:`
  String get last_visit {
    return Intl.message('Last visit:', name: 'last_visit', desc: '', args: []);
  }

  /// `Score`
  String get score {
    return Intl.message('Score', name: 'score', desc: '', args: []);
  }

  /// `Last sale on {last_sales_on}:`
  String last_sales_on(Object last_sales_on) {
    return Intl.message(
      'Last sale on $last_sales_on:',
      name: 'last_sales_on',
      desc: '',
      args: [last_sales_on],
    );
  }

  /// `Total Points`
  String get total_points {
    return Intl.message(
      'Total Points',
      name: 'total_points',
      desc: '',
      args: [],
    );
  }

  /// `Claim Your Gift!`
  String get claim_your_gift {
    return Intl.message(
      'Claim Your Gift!',
      name: 'claim_your_gift',
      desc: '',
      args: [],
    );
  }

  /// `You have`
  String get you_have {
    return Intl.message('You have', name: 'you_have', desc: '', args: []);
  }

  /// `unclaimed points.`
  String get unclaimed_points {
    return Intl.message(
      'unclaimed points.',
      name: 'unclaimed_points',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to claim this gift?`
  String get are_you_sure_claim {
    return Intl.message(
      'Are you sure you want to claim this gift?',
      name: 'are_you_sure_claim',
      desc: '',
      args: [],
    );
  }

  /// `claim`
  String get claim {
    return Intl.message('claim', name: 'claim', desc: '', args: []);
  }

  /// `{you_need_points_to_redeem} more points needed to claim this gift.`
  String you_need_points_to_redeem(Object you_need_points_to_redeem) {
    return Intl.message(
      '$you_need_points_to_redeem more points needed to claim this gift.',
      name: 'you_need_points_to_redeem',
      desc: '',
      args: [you_need_points_to_redeem],
    );
  }

  /// `{points_to_redeem} pts more to claim`
  String points_to_redeem(Object points_to_redeem) {
    return Intl.message(
      '$points_to_redeem pts more to claim',
      name: 'points_to_redeem',
      desc: '',
      args: [points_to_redeem],
    );
  }

  /// `Claiming your gift..`
  String get claiming_your_gift {
    return Intl.message(
      'Claiming your gift..',
      name: 'claiming_your_gift',
      desc: '',
      args: [],
    );
  }

  /// `Your Total Points for {your_total_points_year}`
  String your_total_points_year(Object your_total_points_year) {
    return Intl.message(
      'Your Total Points for $your_total_points_year',
      name: 'your_total_points_year',
      desc: '',
      args: [your_total_points_year],
    );
  }

  /// `Your gift is claimed`
  String get your_gift_is_claimed {
    return Intl.message(
      'Your gift is claimed',
      name: 'your_gift_is_claimed',
      desc: '',
      args: [],
    );
  }

  /// `Your earned points for this visit:`
  String get earned_points_this_visit {
    return Intl.message(
      'Your earned points for this visit:',
      name: 'earned_points_this_visit',
      desc: '',
      args: [],
    );
  }

  /// `Change Filter`
  String get change_filter {
    return Intl.message(
      'Change Filter',
      name: 'change_filter',
      desc: '',
      args: [],
    );
  }

  /// `Perfect Store\nGuidelines`
  String get perfect_store_guidelines_2_lines {
    return Intl.message(
      'Perfect Store\nGuidelines',
      name: 'perfect_store_guidelines_2_lines',
      desc: '',
      args: [],
    );
  }

  /// `Perfect Store Guidelines`
  String get prg_prefect_store {
    return Intl.message(
      'Perfect Store Guidelines',
      name: 'prg_prefect_store',
      desc: '',
      args: [],
    );
  }

  /// `Store Reward`
  String get prg_store_reward {
    return Intl.message(
      'Store Reward',
      name: 'prg_store_reward',
      desc: '',
      args: [],
    );
  }

  /// `Store Location`
  String get prg_store_location {
    return Intl.message(
      'Store Location',
      name: 'prg_store_location',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get sure_logout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'sure_logout',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Points Balance`
  String get points_balance {
    return Intl.message(
      'Points Balance',
      name: 'points_balance',
      desc: '',
      args: [],
    );
  }

  /// `Claim This Gift!`
  String get claim_this_gift {
    return Intl.message(
      'Claim This Gift!',
      name: 'claim_this_gift',
      desc: '',
      args: [],
    );
  }

  /// `Filter Your Products:`
  String get filter_your_products {
    return Intl.message(
      'Filter Your Products:',
      name: 'filter_your_products',
      desc: '',
      args: [],
    );
  }

  /// `Filter Your Products:`
  String get filter_your_prices {
    return Intl.message(
      'Filter Your Products:',
      name: 'filter_your_prices',
      desc: '',
      args: [],
    );
  }

  /// `Filter Your Place Guidelines:`
  String get filter_your_places {
    return Intl.message(
      'Filter Your Place Guidelines:',
      name: 'filter_your_places',
      desc: '',
      args: [],
    );
  }

  /// `Filter Your Promotion Guidelines:`
  String get filter_your_promos {
    return Intl.message(
      'Filter Your Promotion Guidelines:',
      name: 'filter_your_promos',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your Missions`
  String get upload_your_missions_all {
    return Intl.message(
      'Upload Your Missions',
      name: 'upload_your_missions_all',
      desc: '',
      args: [],
    );
  }

  /// `Upload Complete!`
  String get upload_complete {
    return Intl.message(
      'Upload Complete!',
      name: 'upload_complete',
      desc: '',
      args: [],
    );
  }

  /// `products`
  String get products {
    return Intl.message('products', name: 'products', desc: '', args: []);
  }

  /// `Uploading…`
  String get uploading {
    return Intl.message('Uploading…', name: 'uploading', desc: '', args: []);
  }

  /// `Points For`
  String get points_for {
    return Intl.message('Points For', name: 'points_for', desc: '', args: []);
  }

  /// `Salesman Login`
  String get salesman_login_button {
    return Intl.message(
      'Salesman Login',
      name: 'salesman_login_button',
      desc: '',
      args: [],
    );
  }

  /// `Retailer Login`
  String get retailer_login_button {
    return Intl.message(
      'Retailer Login',
      name: 'retailer_login_button',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name_hint {
    return Intl.message(
      'Full name',
      name: 'full_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number`
  String get mobile_hint {
    return Intl.message(
      'Mobile number',
      name: 'mobile_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add a Supplier`
  String get add_supplier {
    return Intl.message(
      'Add a Supplier',
      name: 'add_supplier',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verification_code {
    return Intl.message(
      'Verification code',
      name: 'verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Enter your code:`
  String get enter_code {
    return Intl.message(
      'Enter your code:',
      name: 'enter_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your code`
  String get enter_code_warning {
    return Intl.message(
      'Please enter your code',
      name: 'enter_code_warning',
      desc: '',
      args: [],
    );
  }

  /// `Wrong verification code, please try again.`
  String get enter_code_not_match {
    return Intl.message(
      'Wrong verification code, please try again.',
      name: 'enter_code_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Updating…`
  String get downloading_distributors {
    return Intl.message(
      'Updating…',
      name: 'downloading_distributors',
      desc: '',
      args: [],
    );
  }

  /// `Updating…`
  String get importing_distributors_data {
    return Intl.message(
      'Updating…',
      name: 'importing_distributors_data',
      desc: '',
      args: [],
    );
  }

  /// `Link retailer`
  String get action_link_retailer {
    return Intl.message(
      'Link retailer',
      name: 'action_link_retailer',
      desc: '',
      args: [],
    );
  }

  /// `Unlink retailer`
  String get action_unlink_retailer {
    return Intl.message(
      'Unlink retailer',
      name: 'action_unlink_retailer',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to link {link_retailer_alert} to {link_retailer_alert_to}?`
  String link_retailer_alert(
    Object link_retailer_alert,
    Object link_retailer_alert_to,
  ) {
    return Intl.message(
      'Are you sure you want to link $link_retailer_alert to $link_retailer_alert_to?',
      name: 'link_retailer_alert',
      desc: '',
      args: [link_retailer_alert, link_retailer_alert_to],
    );
  }

  /// `Are you sure you want to unlink {unlink_retailer_alert} from {unlink_retailer_alert_from}?`
  String unlink_retailer_alert(
    Object unlink_retailer_alert,
    Object unlink_retailer_alert_from,
  ) {
    return Intl.message(
      'Are you sure you want to unlink $unlink_retailer_alert from $unlink_retailer_alert_from?',
      name: 'unlink_retailer_alert',
      desc: '',
      args: [unlink_retailer_alert, unlink_retailer_alert_from],
    );
  }

  /// `Do you want to link {want_link_retailer}?`
  String want_link_retailer(Object want_link_retailer) {
    return Intl.message(
      'Do you want to link $want_link_retailer?',
      name: 'want_link_retailer',
      desc: '',
      args: [want_link_retailer],
    );
  }

  /// `Logout`
  String get action_logout {
    return Intl.message('Logout', name: 'action_logout', desc: '', args: []);
  }

  /// `Linked successfully`
  String get linked_successfully {
    return Intl.message(
      'Linked successfully',
      name: 'linked_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Done!`
  String get unlinked_successfully {
    return Intl.message(
      'Done!',
      name: 'unlinked_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Linking {linking_retailer}`
  String linking_retailer(Object linking_retailer) {
    return Intl.message(
      'Linking $linking_retailer',
      name: 'linking_retailer',
      desc: '',
      args: [linking_retailer],
    );
  }

  /// `Unlinking {unlinking_retailer}`
  String unlinking_retailer(Object unlinking_retailer) {
    return Intl.message(
      'Unlinking $unlinking_retailer',
      name: 'unlinking_retailer',
      desc: '',
      args: [unlinking_retailer],
    );
  }

  /// `Click on the above button to add a new supplier…`
  String get no_available_suppliers {
    return Intl.message(
      'Click on the above button to add a new supplier…',
      name: 'no_available_suppliers',
      desc: '',
      args: [],
    );
  }

  /// `Show this image to your supplier…`
  String get show_qr_to_supplier {
    return Intl.message(
      'Show this image to your supplier…',
      name: 'show_qr_to_supplier',
      desc: '',
      args: [],
    );
  }

  /// `Engage customer to download EYE Win!`
  String get engage_customer {
    return Intl.message(
      'Engage customer to download EYE Win!',
      name: 'engage_customer',
      desc: '',
      args: [],
    );
  }

  /// `Linked with {linked_with}.`
  String linked_with(Object linked_with) {
    return Intl.message(
      'Linked with $linked_with.',
      name: 'linked_with',
      desc: '',
      args: [linked_with],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get just_now {
    return Intl.message('Just now', name: 'just_now', desc: '', args: []);
  }

  /// `a minute ago`
  String get a_minute_ago {
    return Intl.message(
      'a minute ago',
      name: 'a_minute_ago',
      desc: '',
      args: [],
    );
  }

  /// `{minutes_ago} minutes ago`
  String minutes_ago(Object minutes_ago) {
    return Intl.message(
      '$minutes_ago minutes ago',
      name: 'minutes_ago',
      desc: '',
      args: [minutes_ago],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `An hour ago`
  String get an_hour_ago {
    return Intl.message('An hour ago', name: 'an_hour_ago', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `1 week ago`
  String get one_week_ago {
    return Intl.message('1 week ago', name: 'one_week_ago', desc: '', args: []);
  }

  /// `{days_ago} days ago`
  String days_ago(Object days_ago) {
    return Intl.message(
      '$days_ago days ago',
      name: 'days_ago',
      desc: '',
      args: [days_ago],
    );
  }

  /// `{weeks_ago} weeks ago`
  String weeks_ago(Object weeks_ago) {
    return Intl.message(
      '$weeks_ago weeks ago',
      name: 'weeks_ago',
      desc: '',
      args: [weeks_ago],
    );
  }

  /// `Not all pictures taken!`
  String get not_all_pictures_taken {
    return Intl.message(
      'Not all pictures taken!',
      name: 'not_all_pictures_taken',
      desc: '',
      args: [],
    );
  }

  /// `Prices displayed in the guidelines are recommended shelf prices. Pricing decisions remain at the sole discretion of the Distributor and Retailer.`
  String get prices_recommended_sentence {
    return Intl.message(
      'Prices displayed in the guidelines are recommended shelf prices. Pricing decisions remain at the sole discretion of the Distributor and Retailer.',
      name: 'prices_recommended_sentence',
      desc: '',
      args: [],
    );
  }

  /// `You already visited {already_completed_mission_today} today.`
  String already_completed_mission_today(
    Object already_completed_mission_today,
  ) {
    return Intl.message(
      'You already visited $already_completed_mission_today today.',
      name: 'already_completed_mission_today',
      desc: '',
      args: [already_completed_mission_today],
    );
  }

  /// `Powered by`
  String get powered_by {
    return Intl.message('Powered by', name: 'powered_by', desc: '', args: []);
  }

  /// `Document Guidelines`
  String get documents {
    return Intl.message(
      'Document Guidelines',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `{document_count_1} Document Guideline`
  String document_count_1(Object document_count_1) {
    return Intl.message(
      '$document_count_1 Document Guideline',
      name: 'document_count_1',
      desc: '',
      args: [document_count_1],
    );
  }

  /// `{document_count_many} Document Guidelines`
  String document_count_many(Object document_count_many) {
    return Intl.message(
      '$document_count_many Document Guidelines',
      name: 'document_count_many',
      desc: '',
      args: [document_count_many],
    );
  }

  /// `No active reward programs available.`
  String get no_reward_prg {
    return Intl.message(
      'No active reward programs available.',
      name: 'no_reward_prg',
      desc: '',
      args: [],
    );
  }

  /// `No sales information available.`
  String get no_sales_data {
    return Intl.message(
      'No sales information available.',
      name: 'no_sales_data',
      desc: '',
      args: [],
    );
  }

  /// `Reward Programs`
  String get reward_programs {
    return Intl.message(
      'Reward Programs',
      name: 'reward_programs',
      desc: '',
      args: [],
    );
  }

  /// `By KPI`
  String get reward_type_id_by_kpi {
    return Intl.message(
      'By KPI',
      name: 'reward_type_id_by_kpi',
      desc: '',
      args: [],
    );
  }

  /// `Joint KPIs`
  String get reward_type_id_joint_kpi {
    return Intl.message(
      'Joint KPIs',
      name: 'reward_type_id_joint_kpi',
      desc: '',
      args: [],
    );
  }

  /// `Inaya`
  String get gift_type_id_inaya {
    return Intl.message(
      'Inaya',
      name: 'gift_type_id_inaya',
      desc: '',
      args: [],
    );
  }

  /// `Rebate %`
  String get gift_type_id_rebate_percentage {
    return Intl.message(
      'Rebate %',
      name: 'gift_type_id_rebate_percentage',
      desc: '',
      args: [],
    );
  }

  /// `Rebate $`
  String get gift_type_id_rebate_cash {
    return Intl.message(
      'Rebate \$',
      name: 'gift_type_id_rebate_cash',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get gift_type_id_other {
    return Intl.message(
      'Other',
      name: 'gift_type_id_other',
      desc: '',
      args: [],
    );
  }

  /// `more…`
  String get pdf_button_text {
    return Intl.message('more…', name: 'pdf_button_text', desc: '', args: []);
  }

  /// `Your Sales Performance`
  String get kpi_sales {
    return Intl.message(
      'Your Sales Performance',
      name: 'kpi_sales',
      desc: '',
      args: [],
    );
  }

  /// `Product Availability`
  String get kpi_product {
    return Intl.message(
      'Product Availability',
      name: 'kpi_product',
      desc: '',
      args: [],
    );
  }

  /// `Promotion Guidelines`
  String get kpi_promo {
    return Intl.message(
      'Promotion Guidelines',
      name: 'kpi_promo',
      desc: '',
      args: [],
    );
  }

  /// `Pricing Guidelines`
  String get kpi_price {
    return Intl.message(
      'Pricing Guidelines',
      name: 'kpi_price',
      desc: '',
      args: [],
    );
  }

  /// `Placement Guidelines`
  String get kpi_place {
    return Intl.message(
      'Placement Guidelines',
      name: 'kpi_place',
      desc: '',
      args: [],
    );
  }

  /// `Thank You`
  String get close_btn {
    return Intl.message('Thank You', name: 'close_btn', desc: '', args: []);
  }

  /// `You met all the requirements of this guideline this month.`
  String get kpi_product_desc {
    return Intl.message(
      'You met all the requirements of this guideline this month.',
      name: 'kpi_product_desc',
      desc: '',
      args: [],
    );
  }

  /// `You met all the requirements of this guideline this month.`
  String get kpi_promo_desc {
    return Intl.message(
      'You met all the requirements of this guideline this month.',
      name: 'kpi_promo_desc',
      desc: '',
      args: [],
    );
  }

  /// `You met all the requirements of this guideline this month.`
  String get kpi_price_desc {
    return Intl.message(
      'You met all the requirements of this guideline this month.',
      name: 'kpi_price_desc',
      desc: '',
      args: [],
    );
  }

  /// `You met all the requirements of this guideline this month.`
  String get kpi_place_desc {
    return Intl.message(
      'You met all the requirements of this guideline this month.',
      name: 'kpi_place_desc',
      desc: '',
      args: [],
    );
  }

  /// `You were not evaluated on this guideline this month.`
  String get kpi_product_desc_no_data {
    return Intl.message(
      'You were not evaluated on this guideline this month.',
      name: 'kpi_product_desc_no_data',
      desc: '',
      args: [],
    );
  }

  /// `You were not evaluated on this guideline this month.`
  String get kpi_promo_desc_no_data {
    return Intl.message(
      'You were not evaluated on this guideline this month.',
      name: 'kpi_promo_desc_no_data',
      desc: '',
      args: [],
    );
  }

  /// `You were not evaluated on this guideline this month.`
  String get kpi_price_desc_no_data {
    return Intl.message(
      'You were not evaluated on this guideline this month.',
      name: 'kpi_price_desc_no_data',
      desc: '',
      args: [],
    );
  }

  /// `You were not evaluated on this guideline this month.`
  String get kpi_place_desc_no_data {
    return Intl.message(
      'You were not evaluated on this guideline this month.',
      name: 'kpi_place_desc_no_data',
      desc: '',
      args: [],
    );
  }

  /// `Target:`
  String get target {
    return Intl.message('Target:', name: 'target', desc: '', args: []);
  }

  /// `Actual:`
  String get you {
    return Intl.message('Actual:', name: 'you', desc: '', args: []);
  }

  /// `Remaining:`
  String get remaining {
    return Intl.message('Remaining:', name: 'remaining', desc: '', args: []);
  }

  /// `+/-:`
  String get plusminus {
    return Intl.message('+/-:', name: 'plusminus', desc: '', args: []);
  }

  /// `January`
  String get month_1 {
    return Intl.message('January', name: 'month_1', desc: '', args: []);
  }

  /// `February`
  String get month_2 {
    return Intl.message('February', name: 'month_2', desc: '', args: []);
  }

  /// `March`
  String get month_3 {
    return Intl.message('March', name: 'month_3', desc: '', args: []);
  }

  /// `April`
  String get month_4 {
    return Intl.message('April', name: 'month_4', desc: '', args: []);
  }

  /// `May`
  String get month_5 {
    return Intl.message('May', name: 'month_5', desc: '', args: []);
  }

  /// `June`
  String get month_6 {
    return Intl.message('June', name: 'month_6', desc: '', args: []);
  }

  /// `July`
  String get month_7 {
    return Intl.message('July', name: 'month_7', desc: '', args: []);
  }

  /// `August`
  String get month_8 {
    return Intl.message('August', name: 'month_8', desc: '', args: []);
  }

  /// `September`
  String get month_9 {
    return Intl.message('September', name: 'month_9', desc: '', args: []);
  }

  /// `October`
  String get month_10 {
    return Intl.message('October', name: 'month_10', desc: '', args: []);
  }

  /// `November`
  String get month_11 {
    return Intl.message('November', name: 'month_11', desc: '', args: []);
  }

  /// `December`
  String get month_12 {
    return Intl.message('December', name: 'month_12', desc: '', args: []);
  }

  /// `Rebate:`
  String get rebate {
    return Intl.message('Rebate:', name: 'rebate', desc: '', args: []);
  }

  /// `Reward:`
  String get earned_rebate {
    return Intl.message('Reward:', name: 'earned_rebate', desc: '', args: []);
  }

  /// `Rebate ({rebate_currency}):`
  String rebate_currency(Object rebate_currency) {
    return Intl.message(
      'Rebate ($rebate_currency):',
      name: 'rebate_currency',
      desc: '',
      args: [rebate_currency],
    );
  }

  /// `Quarter {group_nb}`
  String group_nb(Object group_nb) {
    return Intl.message(
      'Quarter $group_nb',
      name: 'group_nb',
      desc: '',
      args: [group_nb],
    );
  }

  /// `Period {group_nb1}`
  String group_nb1(Object group_nb1) {
    return Intl.message(
      'Period $group_nb1',
      name: 'group_nb1',
      desc: '',
      args: [group_nb1],
    );
  }

  /// `Semester {group_nb2}`
  String group_nb2(Object group_nb2) {
    return Intl.message(
      'Semester $group_nb2',
      name: 'group_nb2',
      desc: '',
      args: [group_nb2],
    );
  }

  /// `The below SKUs were not on shelf at these dates.`
  String get product_issues {
    return Intl.message(
      'The below SKUs were not on shelf at these dates.',
      name: 'product_issues',
      desc: '',
      args: [],
    );
  }

  /// `The below pricing guidelines for these SKUs were not implemented at these dates.`
  String get price_issues {
    return Intl.message(
      'The below pricing guidelines for these SKUs were not implemented at these dates.',
      name: 'price_issues',
      desc: '',
      args: [],
    );
  }

  /// `The below placement guidelines were not implemented at these dates.`
  String get place_issues {
    return Intl.message(
      'The below placement guidelines were not implemented at these dates.',
      name: 'place_issues',
      desc: '',
      args: [],
    );
  }

  /// `The below promotion guidelines were not implemented at these dates.`
  String get promo_issues {
    return Intl.message(
      'The below promotion guidelines were not implemented at these dates.',
      name: 'promo_issues',
      desc: '',
      args: [],
    );
  }

  /// ` - `
  String get not_applicable {
    return Intl.message(' - ', name: 'not_applicable', desc: '', args: []);
  }

  /// `Upgrading EYE Win…`
  String get upgrading_database {
    return Intl.message(
      'Upgrading EYE Win…',
      name: 'upgrading_database',
      desc: '',
      args: [],
    );
  }

  /// `Actual Sales:`
  String get actual_sales {
    return Intl.message(
      'Actual Sales:',
      name: 'actual_sales',
      desc: '',
      args: [],
    );
  }

  /// `You are trying to access the Retailer account of EYE WIN. In order to get the best experience, kindly delete the application and download the latest version from the store.`
  String get reinstall_app_msg {
    return Intl.message(
      'You are trying to access the Retailer account of EYE WIN. In order to get the best experience, kindly delete the application and download the latest version from the store.',
      name: 'reinstall_app_msg',
      desc: '',
      args: [],
    );
  }

  /// `Unable to capture your GPS location. Please try again.`
  String get unable_to_capture_gps_location {
    return Intl.message(
      'Unable to capture your GPS location. Please try again.',
      name: 'unable_to_capture_gps_location',
      desc: '',
      args: [],
    );
  }

  /// `You appear to be far from the expected location.`
  String get branch_location_is_far {
    return Intl.message(
      'You appear to be far from the expected location.',
      name: 'branch_location_is_far',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed_map {
    return Intl.message('Proceed', name: 'proceed_map', desc: '', args: []);
  }

  /// `Brand`
  String get brand {
    return Intl.message('Brand', name: 'brand', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Watchouts`
  String get watchouts {
    return Intl.message('Watchouts', name: 'watchouts', desc: '', args: []);
  }

  /// `Export Database`
  String get export_db {
    return Intl.message(
      'Export Database',
      name: 'export_db',
      desc: '',
      args: [],
    );
  }

  /// `Import Database`
  String get import_db {
    return Intl.message(
      'Import Database',
      name: 'import_db',
      desc: '',
      args: [],
    );
  }

  /// `Delete Database`
  String get delete_db {
    return Intl.message(
      'Delete Database',
      name: 'delete_db',
      desc: '',
      args: [],
    );
  }

  /// `Database`
  String get db {
    return Intl.message('Database', name: 'db', desc: '', args: []);
  }

  /// `Set`
  String get set {
    return Intl.message('Set', name: 'set', desc: '', args: []);
  }

  /// `Share EYEWIN Database`
  String get share_db {
    return Intl.message(
      'Share EYEWIN Database',
      name: 'share_db',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure that you want to delete the database?`
  String get sure_delete_db {
    return Intl.message(
      'Are you sure that you want to delete the database?',
      name: 'sure_delete_db',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Are you sure you want to delete this Watchout?`
  String get sure_delete_watchout {
    return Intl.message(
      'Are you sure you want to delete this Watchout?',
      name: 'sure_delete_watchout',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a price`
  String get please_enter_a_valid_price {
    return Intl.message(
      'Please enter a price',
      name: 'please_enter_a_valid_price',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Select a Category first.`
  String get select_category_first {
    return Intl.message(
      'Select a Category first.',
      name: 'select_category_first',
      desc: '',
      args: [],
    );
  }

  /// `Brands`
  String get brands {
    return Intl.message('Brands', name: 'brands', desc: '', args: []);
  }

  /// `Promo Activity`
  String get promo_activity_type {
    return Intl.message(
      'Promo Activity',
      name: 'promo_activity_type',
      desc: '',
      args: [],
    );
  }

  /// `Kindly fill the required fields`
  String get kindly_fill_required_fields {
    return Intl.message(
      'Kindly fill the required fields',
      name: 'kindly_fill_required_fields',
      desc: '',
      args: [],
    );
  }

  /// `New Watchout >`
  String get new_watchout {
    return Intl.message(
      'New Watchout >',
      name: 'new_watchout',
      desc: '',
      args: [],
    );
  }

  /// `Your Watchouts`
  String get your_watchouts {
    return Intl.message(
      'Your Watchouts',
      name: 'your_watchouts',
      desc: '',
      args: [],
    );
  }

  /// `No Watchouts Yet`
  String get no_watchouts_yet {
    return Intl.message(
      'No Watchouts Yet',
      name: 'no_watchouts_yet',
      desc: '',
      args: [],
    );
  }

  /// `Saving Picture…`
  String get saving_picture {
    return Intl.message(
      'Saving Picture…',
      name: 'saving_picture',
      desc: '',
      args: [],
    );
  }

  /// `No Price To Share`
  String get no_price_to_share {
    return Intl.message(
      'No Price To Share',
      name: 'no_price_to_share',
      desc: '',
      args: [],
    );
  }

  /// `Your Comments`
  String get your_comments {
    return Intl.message(
      'Your Comments',
      name: 'your_comments',
      desc: '',
      args: [],
    );
  }

  /// `Watchout Taken.`
  String get watchout_taken {
    return Intl.message(
      'Watchout Taken.',
      name: 'watchout_taken',
      desc: '',
      args: [],
    );
  }

  /// `Watchouts Taken.`
  String get watchouts_taken {
    return Intl.message(
      'Watchouts Taken.',
      name: 'watchouts_taken',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded`
  String get uploaded {
    return Intl.message('Uploaded', name: 'uploaded', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `You cannot add more than 3 pictures.`
  String get you_cannot_add_more_3_pics {
    return Intl.message(
      'You cannot add more than 3 pictures.',
      name: 'you_cannot_add_more_3_pics',
      desc: '',
      args: [],
    );
  }

  /// `Please choose another Category`
  String get please_choose_another_category {
    return Intl.message(
      'Please choose another Category',
      name: 'please_choose_another_category',
      desc: '',
      args: [],
    );
  }

  /// `No Activity To Share`
  String get no_activity_to_share {
    return Intl.message(
      'No Activity To Share',
      name: 'no_activity_to_share',
      desc: '',
      args: [],
    );
  }

  /// `You did not complete all required information.`
  String get you_did_not_complete_required_info {
    return Intl.message(
      'You did not complete all required information.',
      name: 'you_did_not_complete_required_info',
      desc: '',
      args: [],
    );
  }

  /// `Text limit reached`
  String get text_limit_reached {
    return Intl.message(
      'Text limit reached',
      name: 'text_limit_reached',
      desc: '',
      args: [],
    );
  }

  /// `Questions`
  String get generic_questions {
    return Intl.message(
      'Questions',
      name: 'generic_questions',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure that all`
  String get are_you_sure_to_set_all_available {
    return Intl.message(
      'Are you sure that all',
      name: 'are_you_sure_to_set_all_available',
      desc: '',
      args: [],
    );
  }

  /// `Answer Questions`
  String get answer_questions {
    return Intl.message(
      'Answer Questions',
      name: 'answer_questions',
      desc: '',
      args: [],
    );
  }

  /// `Answer`
  String get answer_question_numb {
    return Intl.message(
      'Answer',
      name: 'answer_question_numb',
      desc: '',
      args: [],
    );
  }

  /// `Answer`
  String get answer_questions_numb {
    return Intl.message(
      'Answer',
      name: 'answer_questions_numb',
      desc: '',
      args: [],
    );
  }

  /// `Questions`
  String get questions_numb {
    return Intl.message(
      'Questions',
      name: 'questions_numb',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question_numb {
    return Intl.message('Question', name: 'question_numb', desc: '', args: []);
  }

  /// `Not yet visited`
  String get not_yet_visited {
    return Intl.message(
      'Not yet visited',
      name: 'not_yet_visited',
      desc: '',
      args: [],
    );
  }

  /// `SKUs are available?`
  String get all_available {
    return Intl.message(
      'SKUs are available?',
      name: 'all_available',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message('Events', name: 'events', desc: '', args: []);
  }

  /// `Questions Answered`
  String get generic_question_taken {
    return Intl.message(
      'Questions Answered',
      name: 'generic_question_taken',
      desc: '',
      args: [],
    );
  }

  /// `Questions Answered`
  String get generic_questions_taken {
    return Intl.message(
      'Questions Answered',
      name: 'generic_questions_taken',
      desc: '',
      args: [],
    );
  }

  /// `Enter your comments…`
  String get enter_your_comments {
    return Intl.message(
      'Enter your comments…',
      name: 'enter_your_comments',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Enter Price…`
  String get enter_price {
    return Intl.message(
      'Enter Price…',
      name: 'enter_price',
      desc: '',
      args: [],
    );
  }

  /// `Stay Here`
  String get stay_here {
    return Intl.message('Stay Here', name: 'stay_here', desc: '', args: []);
  }

  /// `Delete this Watchout`
  String get delete_this_watchout {
    return Intl.message(
      'Delete this Watchout',
      name: 'delete_this_watchout',
      desc: '',
      args: [],
    );
  }

  /// `Branding`
  String get branding {
    return Intl.message('Branding', name: 'branding', desc: '', args: []);
  }

  /// `Collect Price`
  String get collect_price {
    return Intl.message(
      'Collect Price',
      name: 'collect_price',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your Mission`
  String get upload_your_mission {
    return Intl.message(
      'Upload Your Mission',
      name: 'upload_your_mission',
      desc: '',
      args: [],
    );
  }

  /// `Welcome,`
  String get welcome {
    return Intl.message('Welcome,', name: 'welcome', desc: '', args: []);
  }

  /// `Your Account Number:`
  String get your_account_number {
    return Intl.message(
      'Your Account Number:',
      name: 'your_account_number',
      desc: '',
      args: [],
    );
  }

  /// `Your Payment Terms:`
  String get your_payment_terms {
    return Intl.message(
      'Your Payment Terms:',
      name: 'your_payment_terms',
      desc: '',
      args: [],
    );
  }

  /// `Order from`
  String get order_from {
    return Intl.message('Order from', name: 'order_from', desc: '', args: []);
  }

  /// `Send a message to`
  String get send_a_message_to {
    return Intl.message(
      'Send a message to',
      name: 'send_a_message_to',
      desc: '',
      args: [],
    );
  }

  /// `View All...`
  String get view_all {
    return Intl.message('View All...', name: 'view_all', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Loading Customers…`
  String get loading_customers {
    return Intl.message(
      'Loading Customers…',
      name: 'loading_customers',
      desc: '',
      args: [],
    );
  }

  /// `Sales Target:`
  String get sales_target {
    return Intl.message(
      'Sales Target:',
      name: 'sales_target',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enter_password {
    return Intl.message(
      'Enter Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `0%`
  String get zero_percent {
    return Intl.message('0%', name: 'zero_percent', desc: '', args: []);
  }

  /// `Balance`
  String get prg_balance {
    return Intl.message('Balance', name: 'prg_balance', desc: '', args: []);
  }

  /// `Target`
  String get prg_target {
    return Intl.message('Target', name: 'prg_target', desc: '', args: []);
  }

  /// `Sales`
  String get prg_sales {
    return Intl.message('Sales', name: 'prg_sales', desc: '', args: []);
  }

  /// `Program ends:`
  String get prg_ends {
    return Intl.message('Program ends:', name: 'prg_ends', desc: '', args: []);
  }

  /// `days`
  String get prg_days {
    return Intl.message('days', name: 'prg_days', desc: '', args: []);
  }

  /// `Sales Target:`
  String get prg_sales_target {
    return Intl.message(
      'Sales Target:',
      name: 'prg_sales_target',
      desc: '',
      args: [],
    );
  }

  /// `Reward:`
  String get prg_rebate {
    return Intl.message('Reward:', name: 'prg_rebate', desc: '', args: []);
  }

  /// `You must sell these products.`
  String get prd_guideline_desc {
    return Intl.message(
      'You must sell these products.',
      name: 'prd_guideline_desc',
      desc: '',
      args: [],
    );
  }

  /// `Price following these guidelines.`
  String get price_guideline_desc {
    return Intl.message(
      'Price following these guidelines.',
      name: 'price_guideline_desc',
      desc: '',
      args: [],
    );
  }

  /// `You must implement these promotion guidelines.`
  String get promo_guideline_desc {
    return Intl.message(
      'You must implement these promotion guidelines.',
      name: 'promo_guideline_desc',
      desc: '',
      args: [],
    );
  }

  /// `Display products following these guidelines.`
  String get place_guideline_desc {
    return Intl.message(
      'Display products following these guidelines.',
      name: 'place_guideline_desc',
      desc: '',
      args: [],
    );
  }

  /// `Check if these products are available.`
  String get prd_guideline_header {
    return Intl.message(
      'Check if these products are available.',
      name: 'prd_guideline_header',
      desc: '',
      args: [],
    );
  }

  /// `Check these pricing guidelines.`
  String get price_guideline_header {
    return Intl.message(
      'Check these pricing guidelines.',
      name: 'price_guideline_header',
      desc: '',
      args: [],
    );
  }

  /// `Check these promotion guidelines.`
  String get promo_guideline_header {
    return Intl.message(
      'Check these promotion guidelines.',
      name: 'promo_guideline_header',
      desc: '',
      args: [],
    );
  }

  /// `Check these placement guidelines.`
  String get place_guideline_header {
    return Intl.message(
      'Check these placement guidelines.',
      name: 'place_guideline_header',
      desc: '',
      args: [],
    );
  }

  /// `Add more info...`
  String get action_link_info {
    return Intl.message(
      'Add more info...',
      name: 'action_link_info',
      desc: '',
      args: [],
    );
  }

  /// `Shop Name`
  String get shop_name {
    return Intl.message('Shop Name', name: 'shop_name', desc: '', args: []);
  }

  /// `Enter your shop name...`
  String get add_shop_name {
    return Intl.message(
      'Enter your shop name...',
      name: 'add_shop_name',
      desc: '',
      args: [],
    );
  }

  /// `Please add your shop name.`
  String get alert_add_shop_name {
    return Intl.message(
      'Please add your shop name.',
      name: 'alert_add_shop_name',
      desc: '',
      args: [],
    );
  }

  /// `Please add your shop image.`
  String get alert_add_shop_image {
    return Intl.message(
      'Please add your shop image.',
      name: 'alert_add_shop_image',
      desc: '',
      args: [],
    );
  }

  /// `Capturing your current location...`
  String get fetching_your_location {
    return Intl.message(
      'Capturing your current location...',
      name: 'fetching_your_location',
      desc: '',
      args: [],
    );
  }

  /// `Please enable Location services for your device.`
  String get enable_location_btn {
    return Intl.message(
      'Please enable Location services for your device.',
      name: 'enable_location_btn',
      desc: '',
      args: [],
    );
  }

  /// `Please enable Location Permissions for EYE WIN under App Permissions in your device's Settings.`
  String get enable_location_settings {
    return Intl.message(
      'Please enable Location Permissions for EYE WIN under App Permissions in your device\'s Settings.',
      name: 'enable_location_settings',
      desc: '',
      args: [],
    );
  }

  /// `Shop Sign Picture`
  String get picture {
    return Intl.message(
      'Shop Sign Picture',
      name: 'picture',
      desc: '',
      args: [],
    );
  }

  /// `You cannot add more than 1 picture.`
  String get you_cannot_add_more_1_pic {
    return Intl.message(
      'You cannot add more than 1 picture.',
      name: 'you_cannot_add_more_1_pic',
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
      Locale.fromSubtags(languageCode: 'fr'),
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
