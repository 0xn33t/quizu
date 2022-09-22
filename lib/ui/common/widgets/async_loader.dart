import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef AsyncLoaderBuilder = Widget Function(
    BuildContext context, AsyncLoaderState value, Widget? child);

class AsyncLoaderState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateState([bool? value]) {
    _isLoading = value ?? !_isLoading;
    notifyListeners();
  }
}

class AsyncLoaderConsumer extends Consumer<AsyncLoaderState> {
  AsyncLoaderConsumer({
    Key? key,
    required AsyncLoaderBuilder builder,
    Widget? child,
  }) : super(key: key, child: child, builder: builder);
}

class AsyncLoaderProvider extends StatelessWidget {
  final AsyncLoaderConsumer consumer;
  const AsyncLoaderProvider({Key? key, required this.consumer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AsyncLoaderState(),
      child: consumer,
    );
  }
}
