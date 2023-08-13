import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inventory_client/controllers/sales/salesScreen_controller.dart';

import '../../theme/app_theme.dart';
import 'widgets/widget_appBar.dart';
import 'widgets/widget_listItem.dart';

///page controller
SalesScreenController salesScreenController = SalesScreenController();

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  void initState() {
    super.initState();
    salesScreenController.getData();
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
                () => salesScreenController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : salesScreenController.data.isEmpty
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
                        //sales list cards
                        ListView.builder(
                            itemCount: salesScreenController.data.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => widgetListItem(
                                salesScreenController.data[index],
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
