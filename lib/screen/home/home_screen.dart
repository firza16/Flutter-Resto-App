import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/home/resto_list_provider.dart';
import 'package:resto_app/screen/home/resto_card_widget.dart';
import 'package:resto_app/static/navigation_route.dart';
import 'package:resto_app/static/resto_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestoListProvider>().fetchrestoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant List"),
      ),

      body: Consumer<RestoListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestoListLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestoListLoadedState(data: var restoList) => ListView.builder(
                itemCount: restoList.length,
                itemBuilder: (context, index) {
                  final resto = restoList[index];

                  return RestoCard(
                    resto: resto,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: resto.id,
                      );
                    },
                  );
                },
              ),
            RestoListErrorState(error: var message) => Center(
                child: Text(message),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
