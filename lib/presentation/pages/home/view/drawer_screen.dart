import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';
import 'package:wisdom/presentation/routes/routes.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../components/drawer_menu_item.dart';

class DrawerScreen extends ViewModelWidget<HomeViewModel> {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
            onTap: () => ZoomDrawer.of(context)!.toggle(),
            child: SvgPicture.asset(
              Assets.icons.crossClose,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 40, bottom: 50),
              child: SvgPicture.asset(
                Assets.icons.logoBlueText,
                fit: BoxFit.scaleDown,
                height: 45.h,
                width: 152.w,
              ),
            ),
            DrawerMenuItem(
              title: 'subscribe'.tr(),
              imgAssets: Assets.icons.proVersion,
              onTap: () => Navigator.of(context).pushNamed(Routes.profilePage),
            ),
            DrawerMenuItem(
              title: 'personal_cabinet'.tr(),
              imgAssets: Assets.icons.person,
              onTap: () => Navigator.of(context).pushNamed(Routes.profilePage2),
            ),
            DrawerMenuItem(
              title: 'place_ad'.tr(),
              imgAssets: Assets.icons.giveAd,
              onTap: () => Navigator.of(context).pushNamed(Routes.givingAdPage),
            ),
            DrawerMenuItem(
              title: 'settings'.tr(),
              imgAssets: Assets.icons.setting,
              onTap: () => Navigator.of(context).pushNamed(Routes.settingPage).then(
                    (value) => viewModel.notifyListeners(),
                  ),
            ),
            DrawerMenuItem(
              title: 'abbreviations'.tr(),
              imgAssets: Assets.icons.abbreviations,
              onTap: () => Navigator.of(context).pushNamed(Routes.abbreviationPage),
            ),
            DrawerMenuItem(
              title: 'rate_app'.tr(),
              imgAssets: Assets.icons.rate,
              onTap: () {},
            ),
            DrawerMenuItem(
              title: 'share_app'.tr(),
              imgAssets: Assets.icons.share,
              onTap: () {},
            ),
            // DrawerMenuItem(
            //   title: 'Download',
            //   imgAssets: Assets.icons.download,
            //   onTap: () {
            //     showCustomDialog(
            //       context: context,
            //       title: 'So\'zlarni yuklash',
            //       contentText: Text(
            //         'So\'zlarni offline qidirish uchun yuklab oling',
            //         style: AppTextStyle.font14W400Normal.copyWith(
            //           color: AppColors.paleGray,
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //       positive: 'Yuklash',
            //       onPositiveTap: () => viewModel.updateWords(),
            //       negative: 'Bekor qilish',
            //       onNegativeTap: () {
            //         Navigator.pop(context);
            //       },
            //       icon: Assets.icons.download,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
