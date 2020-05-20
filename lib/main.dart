import 'dart:ui' as ui;

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;

import 'child_page.dart';
import 'header_delegate.dart';
import 'keep_alive_wrapper.dart';
import 'week_tab_bar.dart';
import 'screen_adapter.dart';

const pictureUrl = 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=21157214,1564611442&fm=26&gp=0.jpg';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.formMediaQueryData(MediaQueryData.fromWindow(ui.window), width: 1080, height: 2220);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final double _weekTabBarHeight = 130.w;
  final ValueNotifier<int> _currentTabIndex = ValueNotifier<int>(DateTime.now().weekday - 1);
  final PageController _pageController = PageController(initialPage: DateTime.now().weekday - 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [buildHeader(context)],
        innerScrollPositionKeyBuilder: () {
          print('innerScrollPositionKeyBuilder: ${_currentTabIndex.value}');
          return Key(_currentTabIndex.value.toString());
        },
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (_currentTabIndex.value != index) _currentTabIndex.value = index;
          },
          children: List.generate(7, (index) {
            print('itemBuilder: $index');
            return NestedScrollViewInnerScrollPositionKeyWidget(
              Key(index.toString()),
              KeepAliveWrapper(child: ChildPage(index)),
            );
          }),
        ),
      ),
    );
  }

  SliverPersistentHeader buildHeader(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: HeaderDelegate(
        builder: (overflow) {
          return Stack(
            children: <Widget>[
              if (overflow)
                Container(color: Colors.white)
              else
                SizedBox.expand(child: Image.network(pictureUrl, fit: BoxFit.cover)),
              Align(
                alignment: Alignment.bottomCenter,
                child: WeekTabBar(
                  currentTabIndex: _currentTabIndex,
                  height: _weekTabBarHeight,
                  onTabIndexChanged: (index) => _pageController.jumpToPage(index),
                ),
              ),
            ],
          );
        },
        maxHeight: 660.w + _weekTabBarHeight,
        minHeight: _weekTabBarHeight,
      ),
    );
  }
}
