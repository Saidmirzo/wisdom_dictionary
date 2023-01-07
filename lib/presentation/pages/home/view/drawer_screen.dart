import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:wisdom/presentation/routes/routes.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../components/drawer_menu_item.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
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
              title: 'PRO versiya',
              imgAssets: Assets.icons.proVersion,
              onTap: () => Navigator.of(context).pushNamed(Routes.profilePage),
            ),
            DrawerMenuItem(
              title: 'Shahsiy kabinet',
              imgAssets: Assets.icons.person,
              onTap: () {},
            ),
            DrawerMenuItem(
              title: 'Reklama berish',
              imgAssets: Assets.icons.giveAd,
              onTap: () {},
            ),
            DrawerMenuItem(
              title: 'Sozlamalar',
              imgAssets: Assets.icons.setting,
              onTap: () {},
            ),
            DrawerMenuItem(
              title: 'Qisqartmalar',
              imgAssets: Assets.icons.abbreviations,
              onTap: () {},
            ),
            DrawerMenuItem(
              title: 'Ilovani baholash',
              imgAssets: Assets.icons.rate,
              onTap: () {},
            ),
            DrawerMenuItem(
              title: 'Ilovani ulashish',
              imgAssets: Assets.icons.share,
              onTap: () {},
            ),
            DrawerMenuItem(
              title: 'Yuklab olish',
              imgAssets: Assets.icons.download,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
