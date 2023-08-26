
import 'package:amir_chhat_app/core/constants/enums.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CompleteAuthProvider extends ChangeNotifier {

  DateTime selectedDate = DateTime.now();
  bool selectedDateOrNot = false;
  SelectedOrNot selectedOrNot = SelectedOrNot.not;
  void selectBirthDate(DateTime selectedDate )  {
    this.selectedDate= selectedDate;
    selectedOrNot = SelectedOrNot.selected;
    selectedDateOrNot= true;
    notifyListeners();

  }

  Gender ? gender ;

  void selectGender(  Gender gender)  {
    this.gender = gender;
    notifyListeners();
  }

  String? name;
  void selectName(  String name)  {
    this.name =name;
    notifyListeners();
  }
  Country? country;
  void selectCountry(  Country country)  {
    this.country =country;
    notifyListeners();
  }

}

