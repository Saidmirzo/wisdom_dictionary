import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:http/http.dart';
import 'package:jbaza/jbaza.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:wisdom/config/constants/urls.dart';
import 'package:wisdom/data/model/recent_model.dart';
import 'package:wisdom/presentation/pages/collocation/view/collocation_details_page.dart';
import 'package:wisdom/presentation/pages/culture/view/culture_detail_page.dart';
import 'package:wisdom/presentation/pages/difference/view/difference_detail_page.dart';
import 'package:wisdom/presentation/pages/google_translator/view/google_translator_page.dart';
import 'package:wisdom/presentation/pages/grammar/view/grammar_detail_page.dart';
import 'package:wisdom/presentation/pages/grammar/view/grammar_page.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';
import 'package:wisdom/presentation/pages/metaphor/view/metaphor_details_page.dart';
import 'package:wisdom/presentation/pages/metaphor/view/metaphor_page.dart';
import 'package:wisdom/presentation/pages/search/view/search_page.dart';
import 'package:wisdom/presentation/pages/catalogs/view/catalogs_page.dart';
import 'package:wisdom/presentation/pages/speaking/view/speaking_details_page.dart';
import 'package:wisdom/presentation/pages/speaking/view/speaking_page.dart';
import 'package:wisdom/presentation/pages/thesaurus/view/thesaurus_details_page.dart';
import 'package:wisdom/presentation/pages/thesaurus/view/thesaurus_page.dart';
import 'package:wisdom/presentation/pages/word_bank/view/wordbank_page.dart';
import 'package:wisdom/presentation/pages/word_detail/view/word_detail_page.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';
import '../../../components/custom_banner.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../culture/view/culture_page.dart';
import '../../difference/view/difference_page.dart';

class HomeScreen extends ViewModelWidget<HomeViewModel> {
  HomeScreen({super.key});

  late final List<Widget> pages = [
    Home(), // 0
    WordBankPage(), // 1
    SearchPage(), // 2
    CatalogsPage(), // 3
    GoogleTranslatorPage(), // 4
    GrammarDetailPage(), // 5
    DifferenceDetailPage(), // 6
    ThesaurusDetailPage(), // 7
    CollocationDetailPage(), // 8
    MetaphorDetailPage(), // 9
    SpeakingDetailPage(), // 10
    GrammarPage(), // 11
    ThesaurusPage(), // 12
    DifferencePage(), // 13
    MetaphorPage(), // 14
    CulturePage(), // 15
    CultureDetailPage(), // 16
    SpeakingPage(), // 17
    WordDetailPage(), // 18
  ];

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return AddToCartAnimation(
      cartKey: viewModel.localViewModel.cartKey,
      createAddToCartAnimation: (runAddToCartAnimation) {
        viewModel.localViewModel.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: viewModel.localViewModel.pageController,
            children: pages,
          ),
          HomeBottomNavBar(
            onTap: ((index) {
              viewModel.localViewModel.changePageIndex(index);
            }),
          ),
        ],
      ),
    );
  }
}

class Home extends ViewModelWidget<HomeViewModel> {
  Home({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.menu,
          onTap: () => ZoomDrawer.of(context)!.toggle(),
          isSearch: false,
          title: 'Wisdom Dictionary',
        ),
        body: SwipeRefresh.adaptive(
          stateStream: viewModel.stream,
          onRefresh: () => viewModel.getRandomDailyWords(),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Builder(
              builder: (context) {
                return viewModel.isSuccess(tag: viewModel.getDailyWordsTag)
                    ? ListView(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h, bottom: 75.h),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Builder(
                            builder: (context) {
                              return viewModel.isSuccess(tag: viewModel.getDailyWordsTag)
                                  ? Visibility(
                                      visible: viewModel.homeRepository.timelineModel.ad != null &&
                                          viewModel.localViewModel.profileState != 1,
                                      child: GestureDetector(
                                        onTap: () => viewModel.onAdWebClicked(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: AppDecoration.bannerDecor,
                                              child: viewModel.homeRepository.timelineModel.ad!.image != null
                                                  ? ClipRRect(
                                                      borderRadius: BorderRadius.circular(18.r),
                                                      child: Image.network(
                                                        Urls.baseUrl +
                                                            viewModel.homeRepository.timelineModel.ad!.image!,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: (context, child, loadingProgress) {
                                                          if (loadingProgress == null) {
                                                            return child;
                                                          }
                                                          return SizedBox(
                                                            height: 165.h,
                                                            child: const LoadingWidget(
                                                              color: AppColors.blue,
                                                              width: 2,
                                                            ),
                                                          );
                                                        },
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return SizedBox(
                                                            height: 165.h,
                                                            child: const LoadingWidget(
                                                              color: AppColors.blue,
                                                              width: 2,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                          CustomBanner(
                            title: 'Grammar',
                            isInkWellEnable: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                            onTap: () {
                              viewModel.localViewModel.isFromMain = true;
                              viewModel.localViewModel.changePageIndex(5);
                            },
                            child: Center(
                              child: Text(
                                viewModel.homeRepository.timelineModel.grammar!.worden!.word!,
                                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          CustomBanner(
                            title: 'Differences',
                            isInkWellEnable: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                            onTap: () {
                              viewModel.localViewModel.isFromMain = true;
                              viewModel.localViewModel.changePageIndex(6);
                            },
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
                                  text: viewModel.separateDifference(
                                      true, viewModel.homeRepository.timelineModel.difference!.word!),
                                  children: [
                                    TextSpan(
                                        text: ' or ',
                                        style: AppTextStyle.font16W500Italic.copyWith(color: AppColors.paleGray)),
                                    TextSpan(
                                        text: viewModel.separateDifference(
                                            false, viewModel.homeRepository.timelineModel.difference!.word)),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          CustomBanner(
                            contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            title: 'Do you know this ?',
                            onTap: () {
                              viewModel.localViewModel.wordDetailModel = RecentModel(
                                  id: viewModel.homeRepository.timelineModel.image!.id!,
                                  word: viewModel.homeRepository.timelineModel.image!.word,
                                  type: 'word');
                              viewModel.localViewModel.isFromMain = true;
                              viewModel.localViewModel.changePageIndex(18);
                            },
                            isInkWellEnable: true,
                            child: Center(
                              child: Image.network(
                                Urls.baseUrl + viewModel.homeRepository.timelineModel.image!.image!,
                                height: 200.h,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return SizedBox(
                                    height: 200.h,
                                    child: const LoadingWidget(
                                      color: AppColors.blue,
                                      width: 2,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image(
                                        image: AssetImage(Assets.images.noInternet),
                                        height: 200.h,
                                        fit: BoxFit.cover,
                                        color: AppColors.error,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: Text(
                                          "oops! no connection",
                                          style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.error),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          CustomBanner(
                            title: 'Thesaurus',
                            isInkWellEnable: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                            onTap: () {
                              viewModel.localViewModel.isFromMain = true;
                              viewModel.localViewModel.changePageIndex(7);
                            },
                            child: Center(
                              child: Text(
                                viewModel.homeRepository.timelineModel.thesaurus!.worden!.word!,
                                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
                              ),
                            ),
                          ),
                          CustomBanner(
                            title: 'Collocation',
                            isInkWellEnable: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                            onTap: () {
                              viewModel.localViewModel.isFromMain = true;
                              viewModel.localViewModel.changePageIndex(8);
                            },
                            child: Center(
                              child: Text(
                                viewModel.homeRepository.timelineModel.collocation!.worden!.word!,
                                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
                              ),
                            ),
                          ),
                          CustomBanner(
                            title: 'Metaphor',
                            isInkWellEnable: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                            onTap: () {
                              viewModel.localViewModel.isFromMain = true;
                              viewModel.localViewModel.changePageIndex(9);
                            },
                            child: Center(
                              child: Text(
                                viewModel.homeRepository.timelineModel.metaphor!.worden!.word!,
                                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
                              ),
                            ),
                          ),
                          CustomBanner(
                            title: 'Speaking',
                            isInkWellEnable: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                            onTap: () {
                              viewModel.localViewModel.isFromMain = true;
                              viewModel.localViewModel.changePageIndex(10);
                            },
                            child: Center(
                              child: Text(
                                viewModel.homeRepository.timelineModel.speaking!.word!,
                                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 75,
                        child: const Center(child: LoadingWidget(color: AppColors.paleBlue, width: 3)));
              },
            )
          ],
        ),
      ),
    );
  }
}
