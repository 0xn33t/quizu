import 'package:flutter/material.dart';
import 'package:quiz_u/core/theme/styles.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.text,
    this.padding,
    this.trailing,
  });

  final String text;
  final EdgeInsetsGeometry? padding;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppEdges.content,
            vertical: AppEdges.extraLarge,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          if (trailing != null) ...[AppSpacers.horizontalContent, trailing!],
        ],
      ),
    );
  }
}

class ListTileBadge extends StatelessWidget {
  const ListTileBadge({
    super.key,
    required this.value,
    this.backgroundColor,
    this.textColor,
  });

  final String value;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 60),
      padding: const EdgeInsets.symmetric(
          horizontal: AppEdges.medium, vertical: AppEdges.small),
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.black.withOpacity(0.08),
          borderRadius: AppCorners.largeBorderRadius),
      child: Center(
        child: Text(
          value,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontWeight: FontWeight.w500, color: textColor),
        ),
      ),
    );
  }
}
