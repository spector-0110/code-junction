import 'package:app_w/features/home/widgets/drawer.dart';
import 'package:app_w/features/home/widgets/grid_items.dart';
import 'package:flutter/material.dart';

final gridItems = [
  'codeChef',
  'codeForces',
  'leetCode',
  'gitHub',
];

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget drawer = const MyDrawer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text('Code Junction'),
      ),
      body: SafeArea(
        child: GridView.count(
          mainAxisSpacing: 40,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   childAspectRatio: 3 / 2,
          //   mainAxisSpacing: 30,
          //   crossAxisSpacing: 30,
          // ),
          children: [
            for (final items in gridItems)
              GridItems(onSelectCategory: () {}, title: items)
          ],
        ),
      ),
    );
  }
}
