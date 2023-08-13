import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_client/controllers/purchase/purchase_screen_controller.dart';

import '../../theme/app_theme.dart';
import '../purchase/widgets/widget_listItem.dart';
import 'widgets/widgets_appbar.dart';

PurchaseScreenController purchaseScreenController = PurchaseScreenController();

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  void initState() {
    purchaseScreenController.getData();
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
                () => purchaseScreenController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : purchaseScreenController.data.isEmpty
                        ? const Center(
                            child: Text(
                              "No data..",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(137, 1, 0, 0),
                              ),
                            ),
                          )
                        :
                        //purchase list cards
                        ListView.builder(
                            itemCount: purchaseScreenController.data.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => widgetListItem(
                                purchaseScreenController.data[index],
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
