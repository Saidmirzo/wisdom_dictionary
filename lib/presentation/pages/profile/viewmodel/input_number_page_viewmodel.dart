import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/profile_repository.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/constants.dart';
import '../../../routes/routes.dart';

class InputNumberPageViewModel extends BaseViewModel {
  InputNumberPageViewModel({
    required super.context,
    required this.profileRepository,
    required this.localViewModel,
    required this.sharedPreferenceHelper,
  });

  final ProfileRepository profileRepository;
  final LocalViewModel localViewModel;
  final SharedPreferenceHelper sharedPreferenceHelper;
  String loginTag = 'loginTag';
  Future? dialog;

  Future<void> onNextPressed(String phoneNumber) async {
    safeBlock(
      () async {
        var status = await profileRepository
            .login(phoneNumber.replaceAll('+', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''));
        setSuccess();
        if (status) {
          sharedPreferenceHelper.putString(Constants.KEY_PHONE, phoneNumber);
          navigateTo(Routes.verifyPage, arg: {'number': phoneNumber});
        }
      },
      callFuncName: 'onNextPressed',
      inProgress: true,
    );
  }

  @override
  callBackBusy(bool value, String? tag) {
    if (dialog == null && isBusy(tag: tag)) {
      Future.delayed(Duration.zero, () {
        dialog = showLoadingDialog(context!);
      });
    }
  }

  @override
  callBackSuccess(value, String? tag) {
    if (dialog != null) {
      pop();
      dialog = null;
    }
  }

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
