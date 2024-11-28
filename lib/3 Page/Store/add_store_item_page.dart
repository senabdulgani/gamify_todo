import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/duraiton_picker.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_task_type.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/task_name.dart';
import 'package:gamify_todo/3%20Page/Store/Widget/set_credit.dart';
import 'package:gamify_todo/6%20Provider/add_store_item_providerr.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AddStoreItemPage extends StatefulWidget {
  const AddStoreItemPage({
    super.key,
  });

  @override
  State<AddStoreItemPage> createState() => _AddStoreItemPageState();
}

class _AddStoreItemPageState extends State<AddStoreItemPage> {
  late final addStoreItemProvider = context.read<AddStoreItemProvider>();
  late final storeProvider = context.read<StoreProvider>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddStoreItemProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Store Item"),
          leading: InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            Consumer(
              builder: (context, AddStoreItemProvider addStoreItemProvider, child) {
                return InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () {
                    // TODO: ardarda basıp yanlış kopyalar ekleyebiliyorum düzelt. bir kere basınca tekrar basılamasın tüm sayfaya olabilir.

                    if (addStoreItemProvider.taskNameController.text.trim().isEmpty) {
                      addStoreItemProvider.taskNameController.clear();

                      Helper().getMessage(
                        message: "Name cant be empty",
                        status: StatusEnum.WARNING,
                      );
                      return;
                    }

                    addStoreItemProvider.addStoreItem();

                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(Icons.check),
                  ),
                );
              },
            ),
          ],
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              TaskName(isStore: true),
              SetCredit(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DurationPickerWidget(isStore: true),
                  SizedBox(width: 20),
                  SelectTaskType(isStore: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
