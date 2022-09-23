import 'package:flutter/material.dart';
import 'package:quiz_u/ui/common/widgets/loading_indicator.dart';
import 'async_indicators.dart';

typedef AsyncResultBuilder<T> = Widget Function(BuildContext context, T data);
typedef AsyncErrorIndicator = Widget Function(Object? error);

class ExtendedFutureBuilder<T> extends StatelessWidget {
  const ExtendedFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.loader,
    this.onError,
  }) : super(key: key);

  final Future<T> future;
  final AsyncResultBuilder<T> builder;
  final Widget? loader;
  final AsyncErrorIndicator? onError;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return loader ?? const LoadingIndicator();
        }

        if (snapshot.hasError) {
          return onError?.call(snapshot.error) ?? const ErrorMessageIndicator();
        }

        return builder.call(context, snapshot.data as T);
      },
    );
  }
}
