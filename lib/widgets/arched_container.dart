import 'package:flutter/material.dart';

class ArchedContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final Decoration? decoration;
  final double archRadius;
  final EdgeInsetsGeometry? padding;

  const ArchedContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.archRadius = 40.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: decoration ?? BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(archRadius),
          topRight: Radius.circular(archRadius),
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(archRadius),
          topRight: Radius.circular(archRadius),
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
