import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/AppInputs.dart';
import 'package:merchant_bill/Constants/Buttons.dart';
import 'package:merchant_bill/Constants/HW.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Controllers/CategoryController.dart';
import 'package:merchant_bill/Controllers/ItemsController.dart';
import 'package:merchant_bill/Models/ItemsModels.dart';
import 'package:provider/provider.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsController>(builder: (context, itemCtrl, child) {
      return Container(
          child: Column(
        children: [
          Height(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Items", style: TxtStls.headerStle),
              const Expanded(child: SizedBox()),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: TextFormField(
                  style: TxtStls.txtStle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: appColor,
                    ),
                    hintText: "Enter Item Name...",
                    hintStyle: TxtStls.txtStle,
                  ),
                ),
              ),
              Width(),
              MaterialButton(
                onPressed: () {
                  Provider.of<AuthenticationController>(context, listen: false)
                      .ClearImageData()
                      .whenComplete(() {
                    showItemDialog(context);
                  });
                },
                color: appColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text("ADD NEW", style: TxtStls.smallwhistle),
              )
            ],
          ),
          Height(),
          Expanded(
              child: LoadList(context,
                  list: itemCtrl.itemsList, from: "Items", crossAxisCount: 6))
        ],
      ));
    });
  }
}

Widget LoadList(context, {list, required crossAxisCount, required from}) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    ),
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (_, i) {
      var data = list[i];
      return ItemCard(context, data: data, from: from);
    },
  );
}

Widget ItemCard(context, {required ItemModels data, required from}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: whiteClr),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
            child: Image.network(
              // data.image.toString(),
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScqpfsrWwofQ0VAxKz8QCEweYrhv6L5mcNzw&s",
          height: 100,

        )),
        Text(data.productName.toString(), style: TxtStls.txtStle),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Cost : ₹${data.price}", style: TxtStls.txtStle),
            IconButton(
                onPressed: () {
                  if (from == "Business") {
                    Provider.of<ItemsController>(context, listen: false)
                        .AddtoCart(itemModels: data);
                  }
                },
                icon: Icon(from == "Business"
                    ? Icons.add_shopping_cart
                    : Icons.edit_note_sharp),
                color: appColor)
          ],
        ),
      ],
    ),
  );
}

void showItemDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  String? categoryId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer3<AuthenticationController, CategoryController,
              ItemsController>(
          builder: (context, authCtrl, catCtrl, itemCtrl, child) {
        return AlertDialog(
          backgroundColor: whiteClr,
          title: Text("Create New Item", style: TxtStls.headerStle),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Item Reference Image", style: TxtStls.txtStle),
                const SizedBox(height: 5),
                Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: appColor, width: 1),
                          image: DecorationImage(
                              image: authCtrl.image == null
                                  ? const AssetImage("assets/login.jpg")
                                  : MemoryImage(
                                  Uint8List.fromList(authCtrl.image)))),
                    ),
                    Positioned(
                        bottom: 5,
                        right: -5,
                        child: InkWell(
                          onTap: () {
                            authCtrl.OpenFiles();
                          },
                          child: const CircleAvatar(
                              maxRadius: 15,
                              backgroundColor: appColor,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: whiteClr,
                                size: 17,
                              )),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: categoryId,
                  hint: const Text('--Select an item'),
                  decoration: InputDecoration(
                    labelText: 'Select Category',
                    fillColor: whiteClr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                  items: catCtrl.categorylist.map((e) {
                    return DropdownMenuItem(
                      value: e.sId,
                      child: Text(e.categoryName.toString(),
                          style: TxtStls.txtStle),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    categoryId = value;
                  },
                  validator: (value){
                    if(value==null){
                      return "Please select category";
                    }
                    else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                NameField(
                    controller: nameController,
                    labelText: "Item Name",
                    hintText: "Enter the item name..."),
                const SizedBox(height: 20),
                NumberField(
                    controller: priceController,
                    labelText: "Item Price",
                    hintText: "Enter the item price...",
                    maxLength: 5),
              ],
            ),
          ),
          actions: <Widget>[
            Cflatbtn(
                color: Colors.red,
                title: "Cancel",
                onTap: () {
                  Navigator.of(context).pop();
                }),
            itemCtrl.createLoad
                ? const CircularProgressIndicator()
                : Cflatbtn(
                    color: appColor,
                    title: "Create",
                    onTap: () {
                      final postJson = {
                        "categoryId":categoryId.toString(),
                        "productName":nameController.text.toString(),
                        "price":double.parse(priceController.text.toString())

                      };
                      itemCtrl.CreateItem(context,postJson: postJson);
                      // if (_formKey.currentState!.validate()) {
                      //   itemCtrl.CreateItem(context,
                      //       itemName: nameController.text,
                      //       itemPrice: priceController.text,
                      //       categoryId: categoryId.toString(),
                      //       itemImage: authCtrl.image,
                      //       filename: authCtrl.filename);
                      // }
                    }),
          ],
        );
      });
    },
    barrierDismissible: false,
  );
}
