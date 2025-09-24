import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/custom_asset_image.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_button.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_text_style.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/app_font_family.dart';
import '../../utils/extentions/nav_extention.dart';
import '../../utils/route/routes.dart';
import 'widgets/copy_right.dart';
import '../../models/token_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _checkSavedUser();
  }

  Future<void> _checkSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString('logged_in_user');

    if (savedUser != null) {
      try {
        final map = jsonDecode(savedUser) as Map<String, dynamic>;
        final user = UserModel.fromJson(map);

        final loginProvider = Provider.of<LoginProvider>(
          context,
          listen: false,
        );
        loginProvider.setUser(user);

        if (mounted) {
          context.pushNamedAndRemoveUntil(
            Routes.mainScreen,
            predicate: (route) => false,
          );
        }
      } catch (e) {
        debugPrint('❌ Failed to load saved user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryWhitColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryWhitColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: CustomAssetImage(
                            imagePath: AppAssets.eyeWinIcLogo,
                            height: 100,
                            width: 120,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).salesman_login_button,
                          style: TextStyles.textTitleStyle,
                        ),
                        CustomTextField(
                          label: S.of(context).username_hint,
                          labelStyle: TextStyles.hintTextStyle,
                          hint: '',
                          controller: usernameController,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          label: S.of(context).password_hint,
                          hint: '',
                          labelStyle: TextStyles.hintTextStyle,
                          controller: passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        CustomContainer(
                          onTap:
                              loginProvider.loading
                                  ? null
                                  : () async {
                                    FocusScope.of(context).unfocus();
                                    final date =
                                        DateTime.now()
                                            .toUtc()
                                            .toIso8601String();

                                    final success = await loginProvider.login(
                                      usernameController.text.trim(),
                                      passwordController.text.trim(),
                                      date,
                                      context,
                                    );

                                    if (success && mounted) {
                                      context.pushNamedAndRemoveUntil(
                                        Routes.mainScreen,
                                        predicate: (route) => false,
                                      );
                                    }
                                  },
                          backgroundColor: AppColors.primaryRed,
                          borderRadius: loginProvider.loading ? 35 : 5,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width:
                              loginProvider.loading
                                  ? 35
                                  : MediaQuery.of(context).size.width,
                          child: Center(
                            child:
                                loginProvider.loading
                                    ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Text(
                                      S.of(context).login,
                                      style: TextStyle(
                                        color: AppColors.primaryWhitColor,
                                        fontSize: 16,
                                        fontFamily: AppFontFamily.robotoBold,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CopyRightWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
