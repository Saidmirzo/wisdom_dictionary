import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

class ProfilePageViewModel extends BaseViewModel {
  ProfilePageViewModel({required super.context});

  Dialog? dialog;

  @override
  callBackError(String text) {
    dialog = print(text);
  }
}
