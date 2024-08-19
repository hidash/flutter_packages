import 'package:flutter/widgets.dart';

import 'rendering/uniform_grid.dart';

export 'rendering/uniform_grid.dart' show UniformGridSizeChangedCallback;

class UniformGrid extends MultiChildRenderObjectWidget {
  /// Render the same column width grid
  UniformGrid({
    super.key,
    super.children,
    required this.columnCount,
    this.borderSide = BorderSide.none,
    this.squareCell = false,
    this.withHeader = true,
    this.onSizeChanged,
    this.fixedSize,
  });

  /// The number of column
  final int columnCount;

  /// Define the [BorderSide] of the grid
  final BorderSide borderSide;

  /// The square cells which have height equal width (= GridWidth / columnCount)
  final bool squareCell;

  /// The top row is header row which have height different with other row
  final bool withHeader;

  /// Invoked when grid size or cell size changed
  final UniformGridSizeChangedCallback? onSizeChanged;

  /// Define the size of cell
  final Size? fixedSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderUniformGrid(
      columnCount: columnCount,
      borderSide: borderSide,
      squareCell: squareCell,
      withHeader: withHeader,
      onSizeChanged: onSizeChanged,
      fixedSize: fixedSize,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    (renderObject as RenderUniformGrid)
      ..columnCount = columnCount
      ..borderSide = borderSide
      ..squareCell = squareCell
      ..withHeader = withHeader
      ..onSizeChanged = onSizeChanged
      ..fixedSize = fixedSize;
  }
}
