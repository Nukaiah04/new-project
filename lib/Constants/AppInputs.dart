import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';



Widget NameField({controller,labelText,hintText,readOnly = false}){
  return TextFormField(
    style: TxtStls.txtStle,
    readOnly:readOnly,
    autofocus: false,
    controller:controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.sentences,
    validator: (name){
      if(name!.isEmpty){
        return "$labelText can not be empty";
      }
      else{
        return null;
      }
    },
  );
}

Widget EmailField({controller,labelText,hintText}){
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    autofocus: false,
    style: TxtStls.txtStle,
    controller:controller,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    textCapitalization: TextCapitalization.none,
    validator: (email){
      final RegExp emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false, multiLine: false,);
      if(email!.isEmpty){
        return "$labelText can not be empty";
      }
      else if(!emailRegex.hasMatch(email)){
        return "$labelText is not formatted";
      }
      else{
        return null;
      }
    },
  );
}

Widget NumberField({controller,labelText,hintText,enabled = false,required maxLength}){
  return TextFormField(
    style: TxtStls.txtStle,
    maxLength:maxLength,
    autofocus: false,
    controller:controller,
    readOnly: enabled,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: false),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    validator:(phone){
      if(phone!.isEmpty){
        return "$labelText can not be empty";
      }
      else{
        return null;
      }
    },

  );
}


Widget PasswordField({controller,labelText,hintText,obscureText,onPressed}){
  return TextFormField(
    style: TxtStls.txtStle,
    autofocus: false,
    controller:controller,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
      labelText:labelText,
      labelStyle: TxtStls.txtStle,
      hintText: hintText,
      hintStyle: TxtStls.smalltxtStle,
      errorStyle: TxtStls.errorStle,
      fillColor: whiteClr,
      filled: true,
      counterText: "",
      suffixIcon: IconButton(icon: Icon(obscureText?Icons.visibility_off:Icons.visibility),onPressed:onPressed,
        // color: primary
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  BorderSide(color: blackClr.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  BorderSide(color: appColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  BorderSide(color: Colors.red),
      ),
    ),
    obscureText:obscureText,
    obscuringCharacter: "*",
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.visiblePassword,
    textCapitalization: TextCapitalization.none,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (password){
      if(password!.isEmpty){
        return "$labelText can not be empty";
      }
      else if(password.length<6){
        return "$labelText should be more than 6 digits ";
      }
      else{
        return null;
      }
    },
  );
}


InputDecoration inputDecoration({labelText,hintText}){
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
    labelText:labelText,
    labelStyle: TxtStls.txtStle,
    hintText: hintText,
    hintStyle: TxtStls.smalltxtStle,
    fillColor: whiteClr,
    filled: true,
    counterText: "",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  BorderSide(color: blackClr.withOpacity(0.5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  BorderSide(color: appColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  BorderSide(color: Colors.red),
    ),
    errorStyle: TxtStls.errorStle,
  );
}


