import 'package:flutter/material.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/Buttons.dart';
import 'package:merchant_bill/Constants/HW.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Controllers/CategoryController.dart';
import 'package:merchant_bill/Controllers/ItemsController.dart';
import 'package:merchant_bill/Views/ItemsView.dart';
import 'package:provider/provider.dart';

class BusinessView extends StatefulWidget {
  const BusinessView({super.key});

  @override
  State<BusinessView> createState() => _BusinessViewState();
}

class _BusinessViewState extends State<BusinessView> {
  String? paymentType;
  List paymentTypeList = ["Cash", "Online", "Split"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<CategoryController, ItemsController>(
        builder: (context, catCtrl, itemCtrl, child) {
      return Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Height(),
          Row(
            children: [
              Text("Business Space", style: TxtStls.headerStle),
              const Expanded(child: SizedBox()),
              // Flexible(
              //   flex: 1,
              //   fit: FlexFit.tight,
              //   child: TextFormField(
              //     style: TxtStls.txtStle,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10)),
              //       suffixIcon: const Icon(
              //         Icons.search,
              //         color: appColor,
              //       ),
              //       hintText: "Enter Item Name...",
              //       hintStyle: TxtStls.txtStle,
              //     ),
              //   ),
              // )
            ],
          ),
          Height(),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: catCtrl.categorylist
                          .map((e) => InkWell(
                                onTap: () {
                                  catCtrl.ChangeCat(value: e.sId);
                                  itemCtrl.FilterItems(value: e.sId);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: catCtrl.categoryId.toString() ==
                                            e.sId.toString()
                                        ? appColor
                                        : whiteClr,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(e.categoryName.toString(),
                                      style:
                                          catCtrl.categoryId.toString() ==
                                                  e.sId.toString()
                                              ? TxtStls.whistle
                                              : TxtStls.txtStle),
                                ),
                              ))
                          .toList(),
                    ),
                    Height(),
                    Expanded(
                      child: LoadList(context,
                          list: itemCtrl.dashboardItemsList,
                          from: "Business",
                          crossAxisCount: 4),
                    ),
                  ],
                ),
              ),
              Width(),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cart Items",
                              style: TxtStls.headerStle,
                            ),
                            Text(
                              itemCtrl.cartList.length.toString(),
                              style: TxtStls.headerStle,
                            ),
                          ],
                        ),
                        const Divider(
                          color: appColor,
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (_, i) => HalfHeight(),
                            itemCount: itemCtrl.cartList.length,
                            itemBuilder: (_, i) {
                              final data = itemCtrl.cartList[i];
                              return Material(
                                color: whiteClr,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  leading: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScqpfsrWwofQ0VAxKz8QCEweYrhv6L5mcNzw&s",
                                    // data.image.toString(),
                                    height: 60,
                                    width: 60,
                                  ),
                                  title: Text(
                                    data.productName.toString(),
                                    style: TxtStls.txtStle,
                                  ),
                                  subtitle: Text(
                                    "₹ ${data.price.toString()}",
                                    style: TxtStls.txtStle,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            itemCtrl.DecreaseCount(
                                                itemCtrl.cartList,
                                                data.sId.toString());
                                          },
                                          icon: const Icon(Icons.remove_circle),
                                          color: Colors.grey),
                                      Text(data.qty.toString(),
                                          style: TxtStls.txtStle),
                                      IconButton(
                                          onPressed: () {
                                            itemCtrl.increaseItemCount(
                                                itemCtrl.cartList,
                                                data.sId.toString());
                                          },
                                          icon: const Icon(Icons.add_circle),
                                          color: appColor),
                                      IconButton(
                                          onPressed: () {
                                            itemCtrl.RemoveCart(
                                                value: data.sId.toString());
                                          },
                                          icon: const Icon(Icons.delete),
                                          color: Colors.red),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          color: appColor,
                        ),
                        HalfHeight(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: paymentTypeList
                                .map((e) => MaterialButton(
                                      elevation: 0.0,
                                      hoverElevation: 0.0,
                                      color: paymentType == e.toString()
                                          ? appColor
                                          : whiteClr,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPressed: () {
                                        setState(() {
                                          paymentType = e.toString();
                                        });
                                      },
                                      child: Text(e.toString(),
                                          style: paymentType == e.toString()
                                              ? TxtStls.smallwhistle
                                              : TxtStls.smalltxtStle),
                                    ))
                                .toList()),
                        HalfHeight(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total", style: TxtStls.headerStle),
                            Text(
                                itemCtrl
                                    .calculateTotalSum(itemCtrl.cartList)
                                    .toString(),
                                style: TxtStls.headerStle),
                          ],
                        ),
                        HalfHeight(),
                        fillButton(context, load: false, title: "Place Order",
                            onTap: () {
                          if (itemCtrl.cartList.isEmpty) {
                            WebToast.show(context,
                                message: "Add items to place order");
                          } else if (paymentType == null) {
                            WebToast.show(context,
                                message: "Please select payment mode");
                          } else {
                            showOrderConfirm(context);
                          }
                        }),
                      ],
                    ),
                  )),
            ],
          ))
        ],
      ));
    });
  }
}

void showOrderConfirm(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer<ItemsController>(builder: (context, itemCtrl, child) {
        return AlertDialog(
          backgroundColor: whiteClr,
          title: Text("Are you sure to confirm order ?",
              style: TxtStls.headerStle),
          actions: <Widget>[
            Cflatbtn(
                color: Colors.red,
                title: "Cancel",
                onTap: () {
                  Navigator.of(context).pop();
                }),
            Cflatbtn(color: appColor, title: "Confirm", onTap: () {}),
          ],
        );
      });
    },
    barrierDismissible: false,
  );
}
