import 'package:amir_chhat_app/core/constants/app_colors.dart';
import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:amir_chhat_app/ui/screens/complete_auth/widgets/boy_or_girl.dart';
import 'package:amir_chhat_app/ui/screens/complete_auth/widgets/complete_auth_widget_from_amir.dart';
import 'package:amir_chhat_app/ui/screens/complete_auth/widgets/complete_auth_widget_from_me.dart';
import 'package:amir_chhat_app/ui/screens/complete_auth/widgets/name_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enums.dart';
import '../../../providers/completeAuth/complete_auth_providers.dart';

class BaseCompleteAuthScreen extends StatefulWidget {
  const BaseCompleteAuthScreen({Key? key}) : super(key: key);

  @override
  State<BaseCompleteAuthScreen> createState() => _BaseCompleteAuthScreenState();
}

class _BaseCompleteAuthScreenState extends State<BaseCompleteAuthScreen> {
  // Function to show the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(

      context: context,
      initialDate:  Provider.of<CompleteAuthProvider>(context,listen: false).selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (context.mounted && picked != null && picked !=  Provider.of<CompleteAuthProvider>(context,listen: false).selectedDate ) {
          Provider.of<CompleteAuthProvider>(context,listen: false).selectBirthDate(picked);

    }

  }

  selectCountry( context)  {
    showCountryPicker(
      context: context,
      showPhoneCode: true, // optional. Shows phone code before the country name.
      useSafeArea: true,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 70.appHeight(context), // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: const InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          labelStyle: TextStyle(
              color: AppColors.blackColor
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.blackColor,),
          enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color:AppColors.yellowColor1,
            ),
          ) ,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:AppColors.yellowColor1,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color:AppColors.yellowColor1,
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        Provider.of<CompleteAuthProvider>(context,listen: false).selectCountry(country);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0,


      ),
      backgroundColor: AppColors.greyColor2.withOpacity(0.4),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15
        ),
        children: [

          const CompleteAuthWidgetFromAmir(text: "Welcome to Amir Chat App",
          widget: SizedBox(),
          ),
          const SizedBox(height: 20,),

          Consumer<CompleteAuthProvider>(
  builder: (context,prov,_) {
    return     Column(

      children: [



         CompleteAuthWidgetFromAmir(text: "Nice to meet you, What is your name?",
        widget: prov.name==null? IconButton(onPressed: (){
          showBottomSheet(context: context, builder: (ctx){
            return          const NameField() ;

          });
        }, icon: const Icon(Icons.arrow_circle_up_sharp,
        color: AppColors.whiteColor,
        )):
            const SizedBox()
        ),
        const SizedBox(height: 20,),
        const NameWidget(),
        prov.name!=null?
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CompleteAuthWidgetFromMe(
                    widget: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.greyColor2,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      height: 30,
                      width: 30,
                      child: IconButton(
                        icon: const Icon(   Icons.edit,size: 15,color: AppColors.whiteColor,),
                        onPressed: () {
                          showBottomSheet(context: context, builder: (ctx){
                            return          const NameWidget() ;

                          },
                              backgroundColor:Colors.transparent
                          );
                        }
                        , color: AppColors.blackColor,),
                    ),
                    text: prov.name!),

              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(

              children: [


                 Expanded(
                     child: CompleteAuthWidgetFromAmir(text: "Hi ${prov.name}, When is your birthday?",
                     widget: prov.selectedDateOrNot == false?  CircleAvatar(

                       radius: 15,


                       foregroundColor: AppColors.yellowColor3,
                       backgroundColor: AppColors.whiteColor,


                       child: IconButton(

                         icon:  const Icon(Icons.date_range,size: 15,),

                         onPressed:()=>_selectDate(context),

                       ),
                     ) :SizedBox(),
                     )),



              ],

            ),
          ],
        ):const SizedBox(),

        const SizedBox(height: 20,)
,
        prov.selectedOrNot == SelectedOrNot.selected?

        Row(
          mainAxisAlignment: MainAxisAlignment.end,

          children: [


            CompleteAuthWidgetFromMe(

              widget:         Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.greyColor2,
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                height: 30,
                width: 30,
                child: IconButton(
                  icon: const Icon(   Icons.edit,size: 15,color: AppColors.whiteColor,),
                  onPressed: ()=>_selectDate(context)
                  , color: AppColors.blackColor,),
              ),

              text: "${prov.selectedDate.year.toString()}-${prov.selectedDate.month.toString()}-${prov.selectedDate.day.toString()}",),

          ],

        )

            :const SizedBox(),

        const SizedBox(height: 15,),

        prov.selectedOrNot == SelectedOrNot.selected?

         Column(
          children: [

            CompleteAuthWidgetFromAmir(text: "Are you a boy or a girl? ",
            widget:prov.gender == null?   IconButton(
              icon: const Icon(   Icons.arrow_circle_up_sharp,size: 25,color: AppColors.whiteColor,),
              onPressed: () {
                showBottomSheet(context: context, builder: (ctx){
                  return          const BoyOrGirlWidget() ;

                },
                    backgroundColor:Colors.transparent
                );
              }
              , color: AppColors.blackColor,):const SizedBox(),
            ),
            const BoyOrGirl(),
          ],
        ) : const SizedBox(),

        const SizedBox(
          height: 15,
        ),
        prov.gender == null ?
            const SizedBox()
            :
    Row(
      mainAxisAlignment: MainAxisAlignment.end,

      children: [
    CompleteAuthWidgetFromMe(
    widget: Container(
    alignment: Alignment.center,
    decoration: const BoxDecoration(
    color: AppColors.greyColor2,
    shape: BoxShape.circle,
    ),
    clipBehavior: Clip.antiAlias,
    height: 30,
    width: 30,
    child: IconButton(
    icon: const Icon(   Icons.edit,size: 15,color: AppColors.whiteColor,),
    onPressed: () {
      showBottomSheet(context: context, builder: (ctx){
        return          const BoyOrGirlWidget() ;

      },
      backgroundColor:Colors.transparent
      );
    }
    , color: AppColors.blackColor,),
    ),
    text: prov.gender == Gender.male? "Boy" :"Girl" ),

    ],
    ),


        const SizedBox(
          height: 15,
        ),

        prov.gender !=null ?

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CompleteAuthWidgetFromAmir(text: "Where are you from ?", widget:

                prov.country ==null?

                CircleAvatar(

                  radius: 15,


                  foregroundColor: AppColors.yellowColor3,
                  backgroundColor: AppColors.whiteColor,


                  child: IconButton(

                    icon:   const Icon(Icons.location_city,size: 15,),

                    onPressed:()=>selectCountry(context),

                  ),
                ): const SizedBox() ),
                const SizedBox(
                  height: 15,
                ),

                prov.country!=null ?

                    CompleteAuthWidgetFromMe(text: prov.country!.name, widget:
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.greyColor2,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      height: 30,
                      width: 30,
                      child: IconButton(
                        icon: const Icon(   Icons.edit,size: 15,color: AppColors.whiteColor,),
                        onPressed: ()=>selectCountry(context)
                        , color: AppColors.blackColor,),
                    ),
                    )
                    :const SizedBox()
              ],
            )

            :const SizedBox()

,
        const SizedBox(
          height: 20,
        )
        ,

        prov.country!=null? MaterialButton(
         minWidth: 50.appWidth(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          color: AppColors.yellowColor1,
          onPressed: ()  { },child: const Text("Continue"),):const SizedBox()


      ],

    );
  }
),




          // const Spacer(),
          // MaterialButton(onPressed: ( )  {
          // if(Provider.of<CompleteAuthProvider>(context).completeAuth.selectedOrNot == SelectedOrNot.not) {
          //   AppHelper.showSnack(context: context, text: "Birthday Required");
          // }
          // }
          // )
          //
          //






        ],
      ),
    );
  }
}
