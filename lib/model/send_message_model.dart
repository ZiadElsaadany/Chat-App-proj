
import 'message_model.dart';

class SendMessageModel {
  late String message;
  late String date;
  late MessageType type;
  late String id;

  SendMessageModel({
    required this.message,
    required this.date,
    required this.type,
    required this.id,
  });

  SendMessageModel.fromJson(dynamic json){
    message = json['message']??'';
    date = json['date']??'';
    type = MessageType.text;
    id = json['id']??'';
  }

  Map toJson(){
    return {
      'message':message,
      'id':id,
      'date':date,
      'type':type.name,
    };
  }

}
