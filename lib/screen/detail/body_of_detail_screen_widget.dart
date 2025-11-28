import 'package:flutter/material.dart';
import 'package:resto_app/data/model/resto.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({
    super.key,
    required this.resto,
  });

  final Resto resto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: resto.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox.square(dimension: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resto.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        "${resto.address}, ${resto.city}",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox.square(dimension: 10),
                      Text(
                        "Category:",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox.square(dimension: 8),
                      Row(
                        children: resto.categories.map((c) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Chip(
                              label: Text(c.name),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Colors.pink,
                    ),
                    const SizedBox.square(dimension: 4),
                    Text(
                      resto.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              resto.description,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox.square(dimension: 24),

            // menu
            Text(
              "Menus",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox.square(dimension: 16),
            Text(
              "Foods",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resto.menus!.foods.map((food) {
                return ListTile(
                  leading: const Icon(Icons.fastfood),
                  title: Text(food.name),
                );
              }).toList(),
            ),

            const SizedBox.square(dimension: 16),
            Text(
              "Drink",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resto.menus!.drinks.map((food) {
                return ListTile(
                  leading: const Icon(Icons.local_drink),
                  title: Text(food.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
