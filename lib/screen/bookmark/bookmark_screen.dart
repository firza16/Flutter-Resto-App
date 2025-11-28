import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/bookmark/local_database_provider.dart';
import 'package:resto_app/screen/home/resto_card_widget.dart';
import 'package:resto_app/screen/bookmark/bookmark_icon_widget.dart';
import 'package:resto_app/static/navigation_route.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<LocalDatabaseProvider>().loadAllRestoValue());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Restaurant List")),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.restoList ?? [];

          if (bookmarkList.isEmpty) {
            return const Center(child: Text("No Favorite List"));
          }

          return ListView.builder(
            itemCount: bookmarkList.length,
            itemBuilder: (context, index) {
              final resto = bookmarkList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: resto.id,
                          );
                        },
                        child: RestoCard(
                          resto: resto,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: resto.id,
                            );
                          },
                        ),
                      ),
                    ),
                    // trailing icon untuk hapus/toggle bookmark
                    BookmarkIconWidget(resto: resto),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
