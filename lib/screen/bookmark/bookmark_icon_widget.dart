import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/resto.dart';
import 'package:resto_app/provider/bookmark/local_database_provider.dart';

class BookmarkIconWidget extends StatelessWidget {
  final Resto resto;

  const BookmarkIconWidget({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dbProvider = context.watch<LocalDatabaseProvider>();
    final isBookmarked = dbProvider.restoList?.any((r) => r.id == resto.id) ?? false;

    return IconButton(
      icon: Icon(
        isBookmarked ? Icons.favorite : Icons.favorite_border,
        color: Colors.red, // dua-duanya merah sesuai permintaan
      ),
      onPressed: () async {
        if (isBookmarked) {
          await dbProvider.removeRestoValueById(resto.id);
        } else {
          await dbProvider.saveRestoValue(resto);
        }

        // refresh daftar di provider supaya UI ikut berubah
        await dbProvider.loadAllRestoValue();
      },
    );
  }
}
