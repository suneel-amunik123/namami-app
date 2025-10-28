import 'package:flutter/material.dart';

/// Extension on nullable Widget to provide convenient padding methods
/// 
/// This extension adds various padding utilities to any Widget,
/// making it easier to apply consistent spacing throughout the app.
/// Works with nullable widgets for flexible usage.
extension PaddingExtensions on Widget? {
  /// Applies horizontal (left and right) padding to the widget
  /// 
  /// [padding] - The amount of padding to apply horizontally
  /// 
  /// Example:
  /// ```dart
  /// Text('Hello').horizontalPadding(16.0)
  /// ```
  Widget horizontalPadding(double padding) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: this);

  /// Applies equal padding to all sides of the widget
  /// 
  /// [padding] - The amount of padding to apply to all sides
  /// 
  /// Example:
  /// ```dart
  /// Text('Hello').allPadding(12.0)
  /// ```
  Widget allPadding(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  /// Applies vertical (top and bottom) padding to the widget
  /// 
  /// [padding] - The amount of padding to apply vertically
  /// 
  /// Example:
  /// ```dart
  /// Text('Hello').verticalPadding(8.0)
  /// ```
  Widget verticalPadding(double padding) =>
      Padding(padding: EdgeInsets.symmetric(vertical: padding), child: this);

  /// Applies symmetric padding with optional vertical and horizontal values
  /// 
  /// [vertical] - Optional vertical padding (defaults to 0.0)
  /// [horizontal] - Optional horizontal padding (defaults to 0.0)
  /// 
  /// Example:
  /// ```dart
  /// Text('Hello').symmetricPadding(vertical: 8.0, horizontal: 16.0)
  /// ```
  Widget symmetricPadding({double? vertical, double? horizontal}) => Padding(
      padding: EdgeInsets.symmetric(
          vertical: vertical ?? 0.0, horizontal: horizontal ?? 0.0),
      child: this);

  /// Applies padding to specific sides of the widget
  /// 
  /// [left] - Optional left padding (defaults to 0.0)
  /// [right] - Optional right padding (defaults to 0.0)
  /// [top] - Optional top padding (defaults to 0.0)
  /// [bottom] - Optional bottom padding (defaults to 0.0)
  /// 
  /// Example:
  /// ```dart
  /// Text('Hello').onlyPadding(left: 8.0, top: 16.0)
  /// ```
  Widget onlyPadding({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) =>
      Padding(
          padding: EdgeInsets.only(
              left: left ?? 0.0,
              right: right ?? 0.0,
              top: top ?? 0.0,
              bottom: bottom ?? 0.0),
          child: this);
}