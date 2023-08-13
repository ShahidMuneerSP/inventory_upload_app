import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/inventory/inventoryScreen_controller.dart';
import '../../theme/app_theme.dart';
import 'widgets/widget_appBar.dart';
import 'widgets/widget_listItem.dart';

InventoryScreenController inventoryScreenController =
    InventoryScreenController();

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    inventoryScreenController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            widgetAppBar(),
            Expanded(
              child: Obx(
                () => inventoryScreenController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : inventoryScreenController.data.isEmpty
                        ? const Center(
                            child: Text(
                              "No data..",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        :
                        //inventory list cards
                        ListView.builder(
                            itemCount: inventoryScreenController.data.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => widgetListItem(
                                inventoryScreenController.data[index],
                                index,
                                context),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
