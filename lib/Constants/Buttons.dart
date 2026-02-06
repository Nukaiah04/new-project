import 'package:flutter/material.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';

Widget fillButton(context,
    {required bool load, required String title, required onTap}) {
  Size size = MediaQuery.of(context).size;
  return InkWell(
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: load ? null : onTap,
    child: AnimatedContainer(
      alignment: Alignment.center,
      height: 50,
      width: load ? 50 : size.width,
      duration: const Duration(milliseconds: 300),
      decoration:
      BoxDecoration(color: appColor, borderRadius: BorderRadius.circular(10)),
      child: load
          ? CircularProgressIndicator(color: whiteClr)
          : Text(title, style: TxtStls.whistle),
    ),
  );
}
//
// Widget unFillButton(context,
//     {required bool load, required String title, required onTap}) {
//   Size size = MediaQuery.of(context).size;
//   return InkWell(
//     hoverColor: Colors.transparent,
//     focusColor: Colors.transparent,
//     splashColor: Colors.transparent,
//     highlightColor: Colors.transparent,
//     onTap: load ? null : onTap,
//     child: AnimatedContainer(
//       alignment: Alignment.center,
//       height: 50,
//       width: load ? 50 : size.width,
//       duration: const Duration(milliseconds: 300),
//       decoration: BoxDecoration(
//           color: bgClr1,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: btnClr)),
//       child: load
//           ? CircularProgressIndicator(color: bgClr1)
//           : Text(title, style: TxtStls.stl13),
//     ),
//   );
// }
//
Widget Cflatbtn({required title,required onTap,color}){
  return MaterialButton(
    onPressed: onTap,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: color,width: 2),
        borderRadius: BorderRadius.circular(10)),
    child: Text(title, style: TxtStls.smalltxtStle),
  );
}