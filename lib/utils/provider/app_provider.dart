import 'package:flutter_salesman_module/utils/provider/channel_data_provider.dart';
import 'package:flutter_salesman_module/utils/provider/get_mission_upload.dart';
import 'package:flutter_salesman_module/utils/provider/guideline_filter_provider.dart';
import 'package:flutter_salesman_module/utils/provider/loader_provider.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload_mission_date.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => TabIndexProvider()),
  ChangeNotifierProvider(create: (_) => LoaderProvider()),
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => ChannelDataProvider()),
  ChangeNotifierProvider(create: (_) => MissionUploadDateProvider()),
  ChangeNotifierProvider(create: (_) => MissionUpload2Provider()),
  ChangeNotifierProvider(create: (_) => MissionUploadServerProvider()),
];
