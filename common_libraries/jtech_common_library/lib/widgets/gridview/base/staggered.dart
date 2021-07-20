import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/*
* 分割方式包装类
* @author wuxubaiyang
* @Time 2021/7/20 下午4:11
*/
class JStaggeredTile {
  //当前创建的分割方式
  final StaggeredTile staggered;

  //填充
  JStaggeredTile.fit(int crossAxisCellCount)
      : staggered = StaggeredTile.fit(crossAxisCellCount);

  //根据数量分割
  JStaggeredTile.count(int crossAxisCellCount, double mainAxisCellCount)
      : staggered = StaggeredTile.count(crossAxisCellCount, mainAxisCellCount);

  //根据固定高度分割
  JStaggeredTile.extent(int crossAxisCellCount, double mainAxisExtent)
      : staggered = StaggeredTile.extent(crossAxisCellCount, mainAxisExtent);
}
