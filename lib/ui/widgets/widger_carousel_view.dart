import 'package:flutter/material.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/ui/widgets/widget_item_card.dart';

class WidgetCarouselView extends StatelessWidget {
  final List<ObjectItem> itemList;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  const WidgetCarouselView({
    super.key,
    required this.itemList,
    required this.itemToShopDictionary,
  });

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController(initialItem: 3);

    return SizedBox(
      height: 220,
      child: CarouselView.weighted(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide.none,
        ),
        itemSnapping: true,
        onTap: null,
        enableSplash: false,
        controller: carouselController,
        flexWeights: [1, 3, 2, 1],
        children: List.generate(
          itemList.length,
          (index) => WidgetItemCard(
            index: index,
            item: itemList[index],
            itemToShopDictionary: itemToShopDictionary,
          ),
        ),
      ),
    );
  }
}
