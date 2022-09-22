import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double? dimension;
  final double? strokeWidth;
  final bool center;

  const LoadingIndicator({
    Key? key,
    this.dimension,
    this.strokeWidth,
    this.center = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loader = SizedBox(
      width: dimension ?? 24,
      height: dimension ?? 24,
      child: CircularProgressIndicator(strokeWidth: strokeWidth ?? 1.8),
    );
    return center ? Center(child: _loader) : _loader;
  }
}
