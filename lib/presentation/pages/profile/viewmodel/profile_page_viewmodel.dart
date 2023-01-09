import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfilePageViewModel extends BaseViewModel {
  ProfilePageViewModel({required super.context});

  Dialog? dialog;
  String? radioValue = '';

  @override
  callBackError(String text) {
    showTopSnackBar(
      Overlay.of(context!)!,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }
}
