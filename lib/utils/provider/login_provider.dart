import 'dart:convert';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/utils/extentions/nav_extention.dart';
import 'package:flutter_salesman_module/utils/route/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_salesman_module/api/login_api.dart';
import 'package:flutter_salesman_module/models/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';

class LoginProvider extends ChangeNotifier {
  static const _kUserKey = 'logged_in_user';

  UserModel? _user;
  bool _loading = false;
  String? _error;

  UserModel? get user => _user;
  bool get loading => _loading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  LoginProvider() {
    //  _loadFromPrefs();
  }

  Future<bool> login(
    String username,
    String password,
    String date,
    BuildContext context,
  ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final formatted = GlobalMethods.getFormattedGmtDate();

      final result = await LoginApi.getLoginToken(
        username,
        password,
        formatted,
      );
      _user = result;

      await _saveToPrefs(_user!);

      _loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      final errorMessage = e.toString();
      _error = errorMessage;

      _loading = false;

      String message;
      if (errorMessage.contains("401")) {
        message = S.of(context).invalid_credentials;
        GlobalMethods.showApiErrorMessage(
          context,
          S.of(context).login_failed,
          message,
        );
      } else {
        final rawError = _error ?? "Unknown error";
        message = GlobalMethods.extractErrorMessage(rawError);
        GlobalMethods.showApiErrorMessage(context, "Error", message);
      }

      notifyListeners();
      return false;
    }
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    //_user = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kUserKey);
    context.pushNamedAndRemoveUntil(
      Routes.logInScreen,
      predicate: (route) => false,
    );
    notifyListeners();
  }

  Future<void> _saveToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(user.toJson());

    await prefs.setString(_kUserKey, json);
  }
}
