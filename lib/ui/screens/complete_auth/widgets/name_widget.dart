import 'package:amir_chhat_app/core/constants/app_colors.dart';
import 'package:amir_chhat_app/providers/completeAuth/complete_auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameWidget extends StatefulWidget {
  const NameWidget({Key? key}) : super(key: key);

  @override
  State<NameWidget> createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), ( ) {
      showBottomSheet(context: context, builder: (ctx){
        return          const NameField() ;

      });
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class NameField extends StatefulWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {

  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<CompleteAuthProvider>(
      builder: (context,prov,_) {
        return Form(
          key: key,
          child: Container(
            color: AppColors.blackColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.greyColor2.withOpacity(0.5)
                      ),
                      child: TextFormField(

                        style: TextStyle (
                          color: AppColors.whiteColor
                        ),
                        cursorColor: AppColors.yellowColor1,
                        controller: controller,
                         decoration: InputDecoration(

                           contentPadding: const EdgeInsets.symmetric(
                               horizontal: 8),
                           hintText: "Please enter your name",
                           hintStyle: TextStyle(
                             color: AppColors.greyColor1.withOpacity(0.5),
                             fontSize: 14
                           ),
                           border: outlineInputBorder(),
                           focusedBorder: outlineInputBorder(),
                           enabledBorder: outlineInputBorder(),
                         ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                 GestureDetector(
                   onTap: ( ) {
                     if( key.currentState!.validate()){

                       prov.selectName(controller.text);
                       Navigator.pop(context);
                     }

                   }
                   ,
                   child: Container(

                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       color: AppColors.yellowColor1,
                     ),
                     padding: EdgeInsets.all(9),

                     child: Text("Send"),
                   ),
                 )

                ],
              ),
            ),
          ),
        );
      }
    );
  }


 OutlineInputBorder outlineInputBorder(){
    return OutlineInputBorder(
      borderRadius:BorderRadius.circular(15) ,
      borderSide: const BorderSide(
        color: Colors.transparent
      )
    );
 }
}
