import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_client/theme/app_theme.dart';

import '../../controllers/list_sales/listsales_screen_controller.dart';
import '../widgets/custom_appbar.dart';
import 'widgets/listItem_sales_widget.dart';

ListSalesScreenController listSalesScreenController =
    ListSalesScreenController();

class ListSalesScreen extends StatefulWidget {
  const ListSalesScreen({Key? key}) : super(key: key);

  @override
  State<ListSalesScreen> createState() => _ListSalesScreenState();
}

class _ListSalesScreenState extends State<ListSalesScreen> {
  @override
  void initState() {
    super.initState();
    listSalesScreenController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            customAppBarWidget("List Sales", context),
            Expanded(
              child: Obx(
                () => listSalesScreenController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : listSalesScreenController.data.isEmpty
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
                            itemCount: listSalesScreenController.data.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                listItemSalesWidget(
                                    listSalesScreenController.data[index],
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
