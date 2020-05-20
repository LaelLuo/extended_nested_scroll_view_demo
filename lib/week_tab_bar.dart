import 'package:flutter/material.dart';
import 'color_res.dart';
import 'screen_adapter.dart';

class WeekTabBar extends StatefulWidget {
  final ValueNotifier<int> currentTabIndex;
  final double height;
  final ValueChanged<int> onTabIndexChanged;

  const WeekTabBar({Key key, @required this.currentTabIndex, @required this.height, this.onTabIndexChanged})
      : super(key: key);

  @override
  _WeekTabBarState createState() => _WeekTabBarState();
}

class _WeekTabBarState extends State<WeekTabBar> {
  final dayList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = DefaultTabController.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(60.w)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          dayList.length,
          (index) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.currentTabIndex.value = index;
              widget.onTabIndexChanged?.call(index);
            },
            child: ValueListenableBuilder<int>(
              valueListenable: widget.currentTabIndex,
              builder: (BuildContext context, int currentTabIndex, Widget child) {
                final isSelected = index == currentTabIndex;
                return Container(
                  child: Text(
                    dayList[index],
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? ColorRes.highLightDefaultColor : ColorRes.secondFontColor,
                    ),
                  ),
                  width: 130.w,
                  height: 60.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.w),
                    border: isSelected ? Border.all(color: ColorRes.highLightDefaultColor) : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
