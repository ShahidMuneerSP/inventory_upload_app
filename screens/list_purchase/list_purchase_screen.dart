import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_client/controllers/list_purchase/listpurchase_screen_controller.dart';
import 'package:inventory_client/screens/list_purchase/widgets/listItem_Purchase_widget.dart';
import 'package:inventory_client/theme/app_theme.dart';
import '../widgets/custom_appbar.dart';

ListPurchaseScreenController listPurchaseScreenController =
    ListPurchaseScreenController();

class ListPurchaseScreen extends StatefulWidget {
  const ListPurchaseScreen({Key? key}) : super(key: key);

  @override
  State<ListPurchaseScreen> createState() => _ListPurchaseScreenState();
}

class _ListPurchaseScreenState extends State<ListPurchaseScreen> {
  @override
  void initState() {
    super.initState();
    listPurchaseScreenController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            customAppBarWidget("List Purchase",context),
            Expanded(
              child: Obx(
                () => listPurchaseScreenController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      )
                    : listPurchaseScreenController.newdata.isEmpty
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
                        //purchase list cards
                        ListView.builder(
                            itemCount:
                                listPurchaseScreenController.newdata.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                listItemPurchaseWidget(
                                    listPurchaseScreenController.newdata[index],
                                    context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
