import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_client/theme/app_theme.dart';
import '../../controllers/list_inventory/list_inventory_screen_controlller.dart';
import '../widgets/custom_appbar.dart';
import 'widgets/listItemInventory_widget.dart';

ListInventoryScreenController listInventoryScreenController =
    ListInventoryScreenController();

class ListInventoryScreen extends StatefulWidget {
  const ListInventoryScreen({Key? key}) : super(key: key);

  @override
  State<ListInventoryScreen> createState() => _ListInventoryScreenState();
}

class _ListInventoryScreenState extends State<ListInventoryScreen> {
  @override
  void initState() {
    super.initState();
    listInventoryScreenController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            customAppBarWidget("List Inventory",context),
            Expanded(
              child: Obx(
                () => listInventoryScreenController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : listInventoryScreenController.data.isEmpty
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
                            itemCount:
                                listInventoryScreenController.data.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                listItemInventoryWidget(
                                    listInventoryScreenController.data[index],
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
