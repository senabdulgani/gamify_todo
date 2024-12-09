import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/3%20Page/Store/Widget/store_item.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        leading: const SizedBox(),
        actions: [
          Text(user!.userCredit.toString(), style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 2),
          const Icon(Icons.monetization_on),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: context.watch<StoreProvider>().storeItemList.length,
        itemBuilder: (context, index) {
          return StoreItem(
            storeItemModel: context.read<StoreProvider>().storeItemList[index],
          );
        },
      ),
    );
  }
}
