import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:food_ordering_app/util/formatter_util.dart';
import 'package:intl/intl.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final int count;
  final bool readOnly;
  final Function incrementCallback;
  final Function decrementCallback;
  const FoodCard({Key key, this.food, this.count = 0, this.incrementCallback, this.decrementCallback, this.readOnly = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(food.imageUrl),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(food.description),
                  SizedBox(height: 5),
                  Text(
                    FormatterUtil.getFormattedPrice(food.price),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (!readOnly) ...[
                    Divider(),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          child: Icon(
                            Icons.remove,
                            color: Theme.of(context).primaryColor,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: decrementCallback,
                        ),
                        Text("$count"),
                        TextButton(
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: incrementCallback,
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
