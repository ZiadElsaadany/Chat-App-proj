import 'package:amir_chhat_app/constants/enums.dart';
import 'package:amir_chhat_app/constants/firebase_constants.dart';
import 'package:amir_chhat_app/model/user_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {



  States  getMyDataState = States.initial ;

UserChat ?  userChat;
  void getMyData(
      ) async{

  getMyDataState = States.loading;
  notifyListeners() ;
    try {
      await FirebaseFirestore.instance.collection(FirebaseConstants.collectionName).doc(
          "AvFZjg70NYFUrFGoiFBB"
      ).get().then((value) {
        // value  =  Map<String , dynamic>
        userChat =  UserChat.fromDocuments(value);

        getMyDataState = States.loaded ;
        notifyListeners()  ;

        //     userChat.(json: value.data()!);
        // emit(GetMyDataSuccessState());
      }
      );

    }on FirebaseException catch(e){
      print (e.toString());
      getMyDataState = States.failure ;
      notifyListeners();

    }

  }


  List<UserChat> users= [];

  States usersState = States.initial;
  void getUsers( ) async {
     usersState = States.loading;
     notifyListeners();

    try  {
      await FirebaseFirestore.instance.collection(FirebaseConstants.collectionName).get().then((value)  {
        users =[] ;
        for(var item in value.docs)   {
          if(item.id != "AvFZjg70NYFUrFGoiFBB") {
            users.add(UserChat.fromDocuments(item)) ;
          }
        }
      } );
       usersState = States.loaded;

    } on FirebaseException  catch(e){
      debugPrint(e.toString());
      users = [] ;
      usersState = States.failure;
    }
  }



  List<UserChat> filteredUsers= [] ;
  void searchAboutUser(
      {
        required String q
      }
      )  {
    debugPrint(users.toString());
    filteredUsers =   users.where((element)   {
      return       element.name.contains(q);
    }).toList();

    notifyListeners(); 
    debugPrint(filteredUsers.toString());

  }


  bool   searchEnabled  = false;



  void  changeSearchEnabled( ) {
    searchEnabled=!searchEnabled;
    if(searchEnabled == false) filteredUsers.clear();
    notifyListeners();
  }


}