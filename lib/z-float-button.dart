import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
class ZFloatButton extends StatelessWidget {
  Widget zFloatButton;
 Widget child;

 String tooltip;

 Color foregroundColor;

 Color backgroundColor;


 Object heroTag;

 VoidCallback onPressed;

 double elevation;


 double highlightElevation;


 double disabledElevation;

 bool mini;

 ShapeBorder shape;


 Clip clipBehavior;

 bool isExtended;


 MaterialTapTargetSize materialTapTargetSize;

 BoxConstraints _sizeConstraints;

  static const double _defaultElevation = 6;
  static const double _defaultHighlightElevation = 12;
  static const ShapeBorder _defaultShape = CircleBorder();
  static const ShapeBorder _defaultExtendedShape = StadiumBorder();


 ZFloatButton({
    Key key,
    this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    @required this.onPressed,
    this.mini = false,
    this.shape,
    this.clipBehavior = Clip.none,
    this.materialTapTargetSize,
    this.isExtended = false,
  }) : assert(elevation == null || elevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(mini != null),
        assert(isExtended != null),
        _sizeConstraints = mini ? BoxConstraints.tightFor(
          width: 40.0,
          height: 40.0,
        ) : BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ),
        super(key: key);

  /// Creates a wider [StadiumBorder]-shaped floating action button with
  /// an optional [icon] and a [label].
  ///
  /// The [label] and [clipBehavior] arguments must non-null. Additionally,
  /// [elevation], [highlightElevation], and [disabledElevation] (if specified)
  /// must be non-negative.
  ZFloatButton.extended({
    Key key,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    @required this.onPressed,
    this.shape,
    this.isExtended = true,
    this.materialTapTargetSize,
    this.clipBehavior = Clip.none,
    Widget icon,
    @required Widget label,
  }) : assert(elevation == null || elevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(isExtended != null),
        assert(clipBehavior != null),
        _sizeConstraints = BoxConstraints(
          minHeight: 48.0,
          maxHeight: 48.0,
        ),
        mini = false,
        child = _ChildOverflowBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: icon == null
                ? <Widget>[
              const SizedBox(width: 20.0),
              label,
              const SizedBox(width: 20.0),
            ]
                : <Widget>[
              const SizedBox(width: 16.0),
              icon,
              const SizedBox(width: 8.0),
              label,
              const SizedBox(width: 20.0),
            ],
          ),
        ),
        super(key: key) {
          zFloatButton = FloatingActionButton(onPressed: this.onPressed,
          );
}

  @override
  Widget build(BuildContext context) {
    return zFloatButton;
  }
}
class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}
class _ChildOverflowBox extends SingleChildRenderObjectWidget {
  const _ChildOverflowBox({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  _RenderChildOverflowBox createRenderObject(BuildContext context) {
    return _RenderChildOverflowBox(
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderChildOverflowBox renderObject) {
    renderObject
      ..textDirection = Directionality.of(context);
  }
}
class _RenderChildOverflowBox extends RenderAligningShiftedBox {
  _RenderChildOverflowBox({
    RenderBox child,
    TextDirection textDirection,
  }) : super(child: child, alignment: Alignment.center, textDirection: textDirection);

  @override
  double computeMinIntrinsicWidth(double height) => 0.0;

  @override
  double computeMinIntrinsicHeight(double width) => 0.0;

  @override
  void performLayout() {
    if (child != null) {
      child.layout(const BoxConstraints(), parentUsesSize: true);
      size = Size(
        math.max(constraints.minWidth, math.min(constraints.maxWidth, child.size.width)),
        math.max(constraints.minHeight, math.min(constraints.maxHeight, child.size.height)),
      );
      alignChild();
    } else {
      size = constraints.biggest;
    }
  }
}