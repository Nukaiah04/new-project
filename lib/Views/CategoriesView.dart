import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/HW.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Controllers/CategoryController.dart';
import 'package:merchant_bill/Models/CategoryModel.dart';
import 'package:provider/provider.dart';

class Categoriesview extends StatefulWidget {
  const Categoriesview({super.key});

  @override
  State<Categoriesview> createState() => _CategoriesviewState();
}

class _CategoriesviewState extends State<Categoriesview> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  List headers = [
    'SN.O',
    'Category Name',
    'Created At',
    'Updated At',
    'Action'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, catCtrl, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Height(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: TxtStls.headerStle),
                const Spacer(),
                // SizedBox(
                //   width: 250,
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       hintText: "Search Category...",
                //       suffixIcon: const Icon(Icons.search, color: appColor),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //   ),
                // ),
                Width(),
                MaterialButton(
                  onPressed: () => showMyDialog(context),
                  color: appColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("ADD NEW", style: TxtStls.smallwhistle),
                ),
              ],
            ),
            Height(),
            Expanded(
                child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: DataTable(
                  columns: headers
                      .map((e) => DataColumn(
                          label: Text(e.toString(), style: TxtStls.appBarStle)))
                      .toList(),
                  rows: catCtrl.categorylist.asMap().entries
                      .map((e) => DataRow(cells: [
                            DataCell(
                                Text("${e.key+1}", style: TxtStls.txtStle)),
                            DataCell(
                                Text(e.value.categoryName.toString(), style: TxtStls.txtStle)),
                            DataCell(
                                Text(formatToIST(e.value.createdAt.toString()), style: TxtStls.txtStle)),
                            DataCell(
                                Text(formatToIST(e.value.updatedAt.toString()), style: TxtStls.txtStle)),
                            DataCell(Row(
                              children: [
                                IconButton(onPressed: (){}, icon: const Icon(Icons.edit_note_outlined),color: Colors.indigo ,),
                                IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline),color: Colors.red,),
                              ],
                            )),
                          ]))
                      .toList(),
                ),
              ),
            )),
          ]),
        );
      },
    );
  }
}


void showMyDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Consumer2<AuthenticationController, CategoryController>(
        builder: (context, authCtrl, catCtrl, child) {
          return AlertDialog(
            title: Text("Create New Category", style: TxtStls.headerStle),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Category Name",
                  hintText: "Enter category name",
                ),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              catCtrl.createLoad
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          catCtrl.CreateCategory(
                            context,
                            categoryName: nameController.text,
                          );
                        }
                      },
                      child: const Text("Create"),
                    ),
            ],
          );
        },
      );
    },
  );
}

String formatToIST(String utcDate) {
  final utcTime = DateTime.parse(utcDate);
  final istTime = utcTime.add(const Duration(hours: 5, minutes: 30));
  return DateFormat('dd MMM yyyy, hh:mm a').format(istTime);
}
