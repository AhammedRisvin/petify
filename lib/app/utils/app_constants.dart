import 'package:clan_of_pets/app/module/blog/view_model/blog_provioder.dart';
import 'package:clan_of_pets/app/module/community/create%20feed/provider/create_feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../module/Dating/view model/dating_provider.dart';
import '../module/Dating/view model/location_provider.dart';
import '../module/Pet services/view_model/services_provider.dart';
import '../module/adopt_a_pet/view_model/adopt_provider.dart';
import '../module/appInfo/view_model/appinfo_provider.dart';
import '../module/auth/view model/auth_provider.dart';
import '../module/community/chat/view model/chat_provider.dart';
import '../module/community/community admin/provider/community_admin_provider.dart';
import '../module/community/community details/provider/community_details_provider.dart';
import '../module/community/community home/provider/community_home_provider.dart';
import '../module/community/create community/provider/create_community_provider.dart';
import '../module/community/view model/Community_provider.dart';
import '../module/home/view model/home_provider.dart';
import '../module/lostgem/view_model/lostgem_provider.dart';
import '../module/onboarding/view model/onboarding_provider.dart';
import '../module/pet profile/view model/pet_profile_provider.dart';
import '../module/user profile/view model/profile_provider.dart';

class AppConstants {
  //APP COLORS

  static const white = Color(0xFFFFFFFF);
  static const subTextGrey = Color(0xFFA5A5A5);
  static const appPrimaryColor = Color(0xFFF5895A);
  static const transparent = Colors.transparent;
  static const black = Color(0xff000000);
  static const black40 = Color(0xff999999);
  static const black60 = Color(0xff666666);
  static const black10 = Color(0xffE5E5E5);
  static const textFieldTextColor = Color(0xffCFCFCF);
  static const greyContainerBg = Color(0xffF3F3F5);
  static const greyContainerBg2 = Color(0xffD9D9D9);
  static const drawerBgColor = Color(0xFF151515);
  static const red = Color(0xff95021d);
  static const appCommonRed = Color(0xffEE5158);
  static const darkYellow = Color(0xff302B0E);
  static const bgBrown = Color(0xff712D2E);
  static final border = const Color(0xffFFFFFF).withOpacity(0.2);
  static final shimmerhighlightColor = Colors.grey[300];
  static final shimmerbaseColor = Colors.grey[200];
}

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: ((context) => OnboardingProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => AuthProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => HomeProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => PetProfileProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => CommunityProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => ServiceProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => LostGemProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => CommunityProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => BlogProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => AppInfoProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => EditController()),
  ),
  ChangeNotifierProvider(
    create: ((context) => CreateCommunityProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => CommunityHomeProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => CreateFeedProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => CommunityDetailsProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => ChatProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => CommunityAdminProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => DatingProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => LocationProvider()),
  ),
  ChangeNotifierProvider(
    create: ((context) => AdoptProvider()),
  ),
];
