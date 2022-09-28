import 'package:flutter/material.dart';
import 'package:quiz_u/core/theme/styles.dart';

class AppDecoratedBox extends StatelessWidget {
  const AppDecoratedBox({
    super.key,
    required this.child,
    this.frontColor,
    this.frontBorderColor,
    this.backColor,
    this.backBorderColor,
    this.transformValue = 6,
    this.radius = 40,
    this.padding,
    this.margin,
    this.constraints,
  });

  final Widget child;
  final Color? frontColor;
  final Color? frontBorderColor;
  final Color? backColor;
  final Color? backBorderColor;
  final double transformValue;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: constraints,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              transform:
                  Matrix4.translationValues(transformValue, transformValue, 0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: backBorderColor ?? Colors.black, width: 2),
                borderRadius: BorderRadius.circular(radius),
                color: backColor ??
                    Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              ),
            ),
          ),
          Container(
            constraints: constraints,
            padding: padding ?? const EdgeInsets.all(AppEdges.content),
            decoration: BoxDecoration(
              border: Border.all(
                color: frontBorderColor ?? Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(radius),
              color: frontColor ?? Colors.white,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class AppDecoratedContainer extends StatelessWidget {
  const AppDecoratedContainer({
    super.key,
    required this.child,
    this.borderColor,
    this.color,
    this.padding,
    this.margin,
    this.radius = AppCorners.small,
    this.shape = BoxShape.rectangle,
  });

  final Widget child;
  final Color? borderColor;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        shape: shape,
        border: Border.all(
          color: borderColor ?? Colors.black,
          width: 2,
        ),
        borderRadius:
            shape == BoxShape.rectangle ? BorderRadius.circular(radius) : null,
        color: color ?? Colors.white,
      ),
      child: child,
    );
  }
}
