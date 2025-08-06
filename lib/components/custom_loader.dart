// global_loader.dart
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/provider/loader_provider.dart';
import 'package:provider/provider.dart';

class GlobalLoader extends StatelessWidget {
  final String loaderKey;

  const GlobalLoader({super.key, required this.loaderKey});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LoaderProvider>().isLoading(loaderKey);

    if (!isLoading) return const SizedBox.shrink();

    return Container(
      alignment: Alignment.center, 
      child: const CircularProgressIndicator(),
    );
  }
}
