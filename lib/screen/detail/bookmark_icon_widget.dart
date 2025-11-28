import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/resto.dart';
import 'package:resto_app/provider/bookmark/local_database_provider.dart';
import 'package:resto_app/provider/detail/bookmark_icon_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Resto resto;

  const BookmarkIconWidget({
    super.key,
    required this.resto,
  });

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    super.initState();
    // todo-03-action-02: change this provider using LocalDatabaseProvider
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() async {
      // todo-03-action-03: change this action using LocalDatabaseProvider
      await localDatabaseProvider.loadRestoValueById(widget.resto.id);
      final value = localDatabaseProvider.checkItemBookmark(widget.resto.id);
      bookmarkIconProvider.isBookmarked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // todo-03-action-04: change this action using LocalDatabaseProvider
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        // todo-03-action-05: change this action using LocalDatabaseProvider
        if (isBookmarked) {
          await localDatabaseProvider.removeRestoValueById(widget.resto.id);
        } else {
          await localDatabaseProvider.saveRestoValue(widget.resto);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
        // todo-03-action-06: add this action to load the page
        localDatabaseProvider.loadAllRestoValue();
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.favorite
            : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}
