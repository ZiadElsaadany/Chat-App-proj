
import 'package:amir_chhat_app/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class   UserChat {
  String id  ;
  String photoUrl  ;
  String name  ;
  String phoneNumber  ;
  String email  ;
  UserChat (
  {
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.photoUrl,
}
      );

  Map<String , String >    toJson( ) {
    return {
      FirebaseConstants.name:name,
      FirebaseConstants.photoUrl:photoUrl,
      FirebaseConstants.email:email,
      FirebaseConstants.phoneNumber:phoneNumber,
    };
  }
  factory UserChat.fromDocuments( DocumentSnapshot dsc) {
       String name  ="";
       String phoneNumber  ="";
       String email  ="";
       String photoUrl  ="";
       try  {
         name=dsc.get(FirebaseConstants.name);
       }catch(e)  {

       }
       try{
         phoneNumber = dsc.get(FirebaseConstants.phoneNumber) ;
       }catch(e) { }


       try{
         email = dsc.get(FirebaseConstants.email) ;
       }catch(e) { }


       try{
         photoUrl = dsc.get(FirebaseConstants.photoUrl) ;
       }catch(e) { }
       return UserChat(id: dsc.id, phoneNumber: phoneNumber, name: name, email: email, photoUrl: photoUrl);

  }
}