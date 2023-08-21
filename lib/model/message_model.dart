
class MessageModel {
  late String message;
  late String date;
  late String image;
  late String name;
  late int unReadCount;
  late MessageType type;
  late String id;

   MessageModel({
    required this.message,
    required this.date,
    required this.image,
    required this.name,
    required this.unReadCount,
    required this.type,
    required this.id,
  });

  MessageModel.fromJson(dynamic json){
    message = json['message']??'';
    date = json['date']??'';
    image = json['image']??'';
    unReadCount = json['unReadCount']??0;
    type = MessageType.text;
    name = json['name']??'';
    id = json['id']??'';
  }

  Map toJson(){
    return {
      'message':message,
      'id':id,
      'name':name,
      'unReadCount':unReadCount,
      'date':date,
      'image':image,
      'type':type.name,
    };
  }

}

enum MessageType{
  text,
}
