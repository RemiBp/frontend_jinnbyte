import 'package:flutter/material.dart';

class  ChoiceProvider  extends ChangeNotifier{
  BuildContext? context;
  init(context){
    this.context = context;
  }

Future<void> createChoiceApi()async{
    try{


    }catch(err){
      debugPrint("error while creating choice is : $err");
    }
}
 }