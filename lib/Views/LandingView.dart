import 'package:flutter/material.dart';
import 'package:merchant_bill/Constants/ApiFunctions.dart';
import 'package:merchant_bill/Constants/Buttons.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Controllers/CategoryController.dart';
import 'package:merchant_bill/Controllers/ItemsController.dart';
import 'package:merchant_bill/Views/BusinessView.dart';
import 'package:merchant_bill/Views/CategoriesView.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/HW.dart';
import 'package:merchant_bill/Constants/Responsive.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';
import 'package:merchant_bill/Views/ItemsView.dart';
import 'package:merchant_bill/Views/MerchantView.dart';
import 'package:merchant_bill/Views/OrdersView.dart';
import 'package:provider/provider.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      ApiMethods.getKeys().whenComplete(() {
        if(mounted){
          Provider.of<CategoryController>(context, listen: false).GetAllCategory();
          Provider.of<ItemsController>(context, listen: false).GetAllItems();
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            Expanded(flex: 2, child: MySidemenu()),
            Expanded(
              flex: 8,
              child: Container(
                height: size.height,
                width: size.width,
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 10, left: 0),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bgColor,
                ),
                child: LoadBody(),
              ),
            )
          ],
        ),
      ),
    );
  }

  int selectedIndex = 1;

  Widget MySidemenu() {
    return Container(
      color: appColor,
      child: Column(
        children: [
          Image.network(
            "https://png.pngtree.com/png-vector/20220708/ourmid/pngtree-fast-food-logo-png-image_5763171.png",
            height: 130,
            width: 130,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
          ),
          const Divider(color: bgColor),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  MyTile(
                      icon: Icons.leaderboard,
                      label: "Business Space",
                      value: 0),
                  HalfHeight(),
                  MyTile(icon: Icons.category, label: "Categories", value: 1),
                  HalfHeight(),
                  MyTile(icon: Icons.fastfood, label: "Food Items", value: 2),
                  HalfHeight(),
                  MyTile(icon: Icons.shopping_cart, label: "Orders", value: 3),
                  HalfHeight(),
                  ApiMethods.userId==1?MyTile(icon: Icons.shopping_cart, label: "Orders", value: 4):const SizedBox.shrink(),
                  HalfHeight(),
                  InkWell(
                onTap: () {
                  showLogoUt(context);
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  duration: const Duration(milliseconds: 300),
                  decoration: const BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )),
                  curve: Curves.fastOutSlowIn,
                  child: Row(
                    mainAxisAlignment: Responsive.isDesktop(context)
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.exit_to_app, color: bgColor),
                      Width(),
                      Responsive.isDesktop(context)
                          ? Text("Log Out",
                          style: TxtStls.whistle)
                          : const SizedBox(),
                    ],
                  ),
                ),
              )
                ],
              ),
            ),
          )),
          const Divider(color: bgColor),
          Text(
            "© 2024 Yalagala Srinivas\nAll rights reserved",
            style: TxtStls.whistle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget MyTile({icon, label, value}) {
    return InkWell(
      onTap: () {
        selectedIndex = value;
        setState(() {});
      },
      child: AnimatedContainer(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: selectedIndex == value ? bgColor : appColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        curve: Curves.fastOutSlowIn,
        child: Row(
          mainAxisAlignment: Responsive.isDesktop(context)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: selectedIndex == value ? blackClr : bgColor),
            Width(),
            Responsive.isDesktop(context)
                ? Text(label,
                    style: selectedIndex == value
                        ? TxtStls.txtStle
                        : TxtStls.whistle)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  LoadBody() {
    if (selectedIndex == 0) {
      return const BusinessView();
    } else if (selectedIndex == 1) {
      return const Categoriesview();
    } else if (selectedIndex == 2) {
      return const ItemsView();
    } else if (selectedIndex == 3) {
      return Ordersview();
    }
    else if(selectedIndex==4){
      return const MerchantView();
    }
  }
}


void showLogoUt(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer<ItemsController>(builder: (context, itemCtrl, child) {
        return AlertDialog(
          backgroundColor: whiteClr,
          title: Text("Are you sure to Log Out?",
              style: TxtStls.headerStle),
          actions: <Widget>[
            Cflatbtn(
                color: Colors.red,
                title: "Cancel",
                onTap: () {
                  Navigator.of(context).pop();
                }),
            Cflatbtn(color: appColor, title: "Yes, LogOut", onTap: () {
              Provider.of<AuthenticationController>(context,listen: false).LogoUt(context);
            }),
          ],
        );
      });
    },
    barrierDismissible: false,
  );
}