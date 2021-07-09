import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:food_ordering_app/screens/customer/retaurant/ui/page/restaurant_screen.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RestaurantScreen.routeName, arguments: RestaurantScreenArgs(restaurant: restaurant)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(restaurant.imageUrl),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(restaurant.address),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
