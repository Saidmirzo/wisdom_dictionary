import 'package:flutter/material.dart';
import 'package:wisdom/config/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({this.width, this.color, super.key});

  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: width ?? 2,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.blue),
      ),
    );
  }
}

Future<T?> showLoadingDialog<T>(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: const [LoadingWidget( color: AppColors.blue, width: 3,)],
        ),
      );
    },
  );
}
