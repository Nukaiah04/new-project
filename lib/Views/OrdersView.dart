import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/HW.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';
import 'package:merchant_bill/Controllers/OrdersController.dart';
import 'package:merchant_bill/Models/OrdersModels.dart';
import 'package:provider/provider.dart';

class Ordersview extends StatefulWidget {
  @override
  _OrdersviewState createState() => _OrdersviewState();
}

class _OrdersviewState extends State<Ordersview> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((time) {
      Provider.of<OrdersController>(context, listen: false).getAllOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<OrdersController>(
      builder: (context,orderCtrl,child) {
        return Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Height(),
              Text("Orders", style: TxtStls.headerStle),
              Height(),
              Expanded(
                child: Container(
                  width: size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: PaginatedDataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'Order ID',
                            style: TxtStls.styl15,
                          ),
                        ),
                        DataColumn(
                          label: Text('Date', style: TxtStls.styl15),
                        ),
                        DataColumn(
                          label: Text('Items', style: TxtStls.styl15),
                        ),
                        DataColumn(
                          label: Text('Amount', style: TxtStls.styl15),
                        ),
                        DataColumn(
                          label: Text('Mode', style: TxtStls.styl15),
                        ),
                        DataColumn(
                          label: Text('Action', style: TxtStls.styl15),
                        ),
                      ],
                      source: OrderDataSource(orderCtrl.ordersList),
                    ),
                  ),
                ),
              ),
              Height(),
            ],
          ),
        );
      }
    );
  }
}

class OrderDataSource extends DataTableSource {
  final List<OrdersGetAllModels> orders;

  OrderDataSource(this.orders);

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) return null;
    final order = orders[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(
          order.sId.toString(),
          style: TxtStls.txtStle,
        )),
        DataCell(Text(DateFormat("dd/MM At hh:mm aa").format(DateTime.parse(order.orderDate.toString()).toLocal()), style: TxtStls.txtStle)),
        DataCell(Text(order.items!.length.toString(), style: TxtStls.txtStle)),
        DataCell(Text('₹${order.totalAmount.toString()}', style: TxtStls.txtStle)),
        DataCell(Text(order.paymentType.toString(), style: TxtStls.txtStle)),
        DataCell(Row(
          children: [
            IconButton(icon:Icon(Icons.edit_note_sharp),onPressed: (){},),
            IconButton(icon:Icon(Icons.remove_red_eye),onPressed: (){},)
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;
}

class Order {
  final String id;
  final String product;
  final num amount;

  Order({required this.id, required this.product, required this.amount});
}
