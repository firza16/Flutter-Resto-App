import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/detail/bookmark_icon_provider.dart';
import 'package:resto_app/provider/detail/resto_detail_provider.dart';
import 'package:resto_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:resto_app/screen/detail/bookmark_icon_widget.dart';
import 'package:resto_app/static/resto_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String restoId;

  const DetailScreen({
    super.key,
    required this.restoId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestoDetailProvider>().fetchRestoDetail(widget.restoId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<RestoDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestoDetailLoadedState(data: var resto) =>
                    BookmarkIconWidget(resto: resto),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<RestoDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestoDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestoDetailLoadedState(data: var resto) =>
              BodyOfDetailScreenWidget(resto: resto),
            RestoDetailErrorState(error: var message) => Center(
                child: Text(message),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
