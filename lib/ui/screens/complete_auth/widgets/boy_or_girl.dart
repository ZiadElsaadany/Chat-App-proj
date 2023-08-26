import 'package:amir_chhat_app/core/constants/app_colors.dart';
import 'package:amir_chhat_app/core/constants/app_images.dart';
import 'package:amir_chhat_app/core/constants/enums.dart';
import 'package:amir_chhat_app/core/extension/size_extension.dart';
import 'package:amir_chhat_app/core/helper/app_helper.dart';
import 'package:amir_chhat_app/providers/completeAuth/complete_auth_providers.dart';
import 'package:amir_chhat_app/ui/screens/complete_auth/widgets/complete_auth_widget_from_amir.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoyOrGirl extends StatefulWidget {
  const BoyOrGirl({Key? key}) : super(key: key);

  @override
  State<BoyOrGirl> createState() => _BoyOrGirlState();
}

class _BoyOrGirlState extends State<BoyOrGirl> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), ( ) {
      showBottomSheet(context: context, builder: (ctx){
        return          const BoyOrGirlWidget() ;

      } ,
      backgroundColor: Colors.transparent
      );
    });

  }
  @override
  Widget build(BuildContext context) {
 return const SizedBox();
  }
}

class BoyOrGirlWidget extends StatelessWidget {
  const BoyOrGirlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10) ,
          topLeft:  Radius.circular(10)
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: ( ) {
                  Provider.of<CompleteAuthProvider>(context,listen: false).selectGender(Gender.male);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 15.appWidth(context),
backgroundColor: Provider.of<CompleteAuthProvider>(context).gender==Gender.male ? AppColors.yellowColor1 : Colors.transparent,
                  child: CircleAvatar(
                    radius: 13.appWidth(context),
                    backgroundImage: AssetImage(
                      Provider.of<CompleteAuthProvider>(context).gender==Gender.male ?
                          AppImages.selectedMale

                          :AppImages.notSelectedMale
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 2.appWidth(context),
              ),
              CircleAvatar(
                radius: 15.appWidth(context),
                backgroundColor: Provider.of<CompleteAuthProvider>(context).gender==Gender.female ? AppColors.yellowColor1 : Colors.transparent,

                child: GestureDetector(
                  onTap: ( )  {
                    Provider.of<CompleteAuthProvider>(context,listen: false).selectGender(Gender.female);
                    Navigator.pop(context);


                  },
                  child: CircleAvatar(

                    radius: 13.appWidth(context),

                    backgroundImage: AssetImage(
                        Provider.of<CompleteAuthProvider>(context).gender==Gender.female ?
                        AppImages.selectedFemale

                            :AppImages.notSelectedFemale
                    ),
                  ),
                ),
              )

            ],
          ),

        ],
      ),
    );
  }
}
