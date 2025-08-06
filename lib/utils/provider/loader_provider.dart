// loader_provider.dart
import 'package:flutter/foundation.dart';

class LoaderProvider with ChangeNotifier {
  final Map<String, bool> _loadingMap = {};

  bool isLoading(String key) => _loadingMap[key] ?? false;

  void show(String key) {
    _loadingMap[key] = true;
    notifyListeners();
  }

  void hide(String key) {
    _loadingMap[key] = false;
    notifyListeners();
  }

  void reset() {
    _loadingMap.clear();
    notifyListeners();
  }
}
