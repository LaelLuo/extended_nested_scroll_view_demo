import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget Function(bool isOverflow) builder;

  HeaderDelegate({this.maxHeight, this.minHeight, this.builder});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//    print('shrinkOffset: $shrinkOffset\t'
//        'maxHeight: $maxHeight\t'
//        'minExtent: $minExtent\t'
//        'top: ${MediaQueryData.fromWindow(ui.window).padding.top}');
    return builder(shrinkOffset >= maxHeight - minExtent);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight + MediaQueryData.fromWindow(ui.window).padding.top;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight;
  }
}
