import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/routes/landing_route.dart';
import 'package:produce_pos/modules/auth/views/registration_from.dart';

import '../../modules/auth/views/forget_password_page.dart';
import '../../modules/auth/views/intro_login_page.dart';
import '../../modules/auth/views/login_or_signup_page.dart';
import '../../modules/auth/views/login_page.dart';
import '../../modules/auth/views/number_verification_page.dart';
import '../../modules/auth/views/password_reset_page.dart';
import '../../modules/auth/views/sign_up_page.dart';
import '../../modules/cart/views/cart_page.dart';
import '../../modules/cart/views/checkout_page.dart';
import '../../modules/drawer/views/about_us_page.dart';
import '../../modules/drawer/views/contact_us_page.dart';
import '../../modules/drawer/views/drawer_page.dart';
import '../../modules/drawer/views/faq_page.dart';
import '../../modules/drawer/views/help_page.dart';
import '../../modules/drawer/views/terms_and_conditions_page.dart';
import '../../modules/entrypoint/views/entrypoint_ui.dart';
import '../../modules/home/views/bundle_create_page.dart';
import '../../modules/home/views/bundle_details_page.dart';
import '../../modules/home/views/bundle_product_details_page.dart';
import '../../modules/home/views/new_item_page.dart';
import '../../modules/home/views/order_failed_page.dart';
import '../../modules/home/views/order_successfull_page.dart';
import '../../modules/home/views/popular_pack_page.dart';
import '../../modules/home/views/product_details_page.dart';
import '../../modules/home/views/search_page.dart';
import '../../modules/home/views/search_result_page.dart';
import '../../modules/menu/views/category_page.dart';
import '../../modules/onboarding/views/onboarding_page.dart';
import '../../modules/profile/address/address_page.dart';
import '../../modules/profile/address/new_address_page.dart';
import '../../modules/profile/coupon/coupon_details_page.dart';
import '../../modules/profile/coupon/coupon_page.dart';
import '../../modules/profile/views/notification_page.dart';
import '../../modules/profile/order/my_order_page.dart';
import '../../modules/profile/order/order_details.dart';
import '../../modules/profile/payment_method/add_new_card_page.dart';
import '../../modules/profile/payment_method/payment_method_page.dart';
import '../../modules/profile/views/profile_edit_page.dart';
import '../../modules/profile/settings/change_password_page.dart';
import '../../modules/profile/settings/change_phone_number_page.dart';
import '../../modules/profile/settings/language_settings_page.dart';
import '../../modules/profile/settings/notifications_settings_page.dart';
import '../../modules/profile/settings/settings_page.dart';
import '../../modules/review/views/review_page.dart';
import '../../modules/review/views/submit_review_page.dart';
import '../../modules/save/views/save_page.dart';
import 'app_routes.dart';
import 'unknown_page.dart';

class RouteGenerator {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.landingRoute,
        page: () => LandingRoute(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.introLogin,
        page: () => const IntroLoginPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.onboarding,
        page: () => const OnboardingPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.entryPoint,
        page: () => const EntryPointUI(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.registrationForm
        ,
        page: () => const RegistrationFrom(),
        transition: Transition.cupertino),

    GetPage(
        name: AppRoutes.search,
        page: () => const SearchPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.searchResult,
        page: () => const SearchResultPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.cartPage,
        page: () => const CartPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.savePage,
        page: () => const SavePage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.checkoutPage,
        page: () => const CheckoutPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.categoryDetails,
        page: () => const CategoryProductPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.signup,
        page: () => const SignUpPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.loginOrSignup,
        page: () => const LoginOrSignUpPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.numberVerification,
        page: () => const NumberVerificationPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.forgotPassword,
        page: () => const ForgetPasswordPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.passwordReset,
        page: () => const PasswordResetPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.newItems,
        page: () => const NewItemsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.popularItems,
        page: () => const PopularPackPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.bundleProduct,
        page: () => const BundleProductDetailsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.bundleDetailsPage,
        page: () => const BundleDetailsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.productDetails,
        page: () => const ProductDetailsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.createMyPack,
        page: () => const BundleCreatePage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.orderSuccessfull,
        page: () => const OrderSuccessfullPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.orderFailed,
        page: () => const OrderFailedPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.myOrder,
        page: () => const AllOrderPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.orderDetails,
        page: () => const OrderDetailsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.coupon,
        page: () => const CouponAndOffersPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.couponDetails,
        page: () => const CouponDetailsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.profileEdit,
        page: () => const ProfileEditPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.newAddress,
        page: () => const NewAddressPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.deliveryAddress,
        page: () => const AddressPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.notifications,
        page: () => const NotificationPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.settingsNotifications,
        page: () => const NotificationSettingsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.settings,
        page: () => const SettingsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.settingsLanguage,
        page: () => const LanguageSettingsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.changePassword,
        page: () => const ChangePasswordPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.changePhoneNumber,
        page: () => const ChangePhoneNumberPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.review,
        page: () => const ReviewPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.submitReview,
        page: () => const SubmitReviewPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.drawerPage,
        page: () => const DrawerPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.aboutUs,
        page: () => const AboutUsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.termsAndConditions,
        page: () => const TermsAndConditionsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.faq,
        page: () => const FAQPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.help,
        page: () => const HelpPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.contactUs,
        page: () => const ContactUsPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.paymentMethod,
        page: () => const PaymentMethodPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.paymentCardAdd,
        page: () => const AddNewCardPage(),
        transition: Transition.cupertino),
    // Handle unknown route
    GetPage(
        name: '/errorPage',
        page: () => const UnknownPage(),
        transition: Transition.cupertino),
  ];
}

  //   switch (route) {
  //     case AppRoutes.introLogin:
  //       return CupertinoPageRoute(builder: (_) => const IntroLoginPage());

  //     case AppRoutes.onboarding:
  //       return CupertinoPageRoute(builder: (_) => const OnboardingPage());

  //     case AppRoutes.entryPoint:
  //       return CupertinoPageRoute(builder: (_) => const EntryPointUI());

  //     case AppRoutes.search:
  //       return CupertinoPageRoute(builder: (_) => const SearchPage());

  //     case AppRoutes.searchResult:
  //       return CupertinoPageRoute(builder: (_) => const SearchResultPage());

  //     case AppRoutes.cartPage:
  //       return CupertinoPageRoute(builder: (_) => const CartPage());

  //     case AppRoutes.savePage:
  //       return CupertinoPageRoute(builder: (_) => const SavePage());

  //     case AppRoutes.checkoutPage:
  //       return CupertinoPageRoute(builder: (_) => const CheckoutPage());

  //     case AppRoutes.categoryDetails:
  //       return CupertinoPageRoute(builder: (_) => const CategoryProductPage());

  //     case AppRoutes.login:
  //       return CupertinoPageRoute(builder: (_) => const LoginPage());

  //     case AppRoutes.signup:
  //       return CupertinoPageRoute(builder: (_) => const SignUpPage());

  //     case AppRoutes.loginOrSignup:
  //       return CupertinoPageRoute(builder: (_) => const LoginOrSignUpPage());

  //     case AppRoutes.numberVerification:
  //       return CupertinoPageRoute(
  //           builder: (_) => const NumberVerificationPage());

  //     case AppRoutes.forgotPassword:
  //       return CupertinoPageRoute(builder: (_) => const ForgetPasswordPage());

  //     case AppRoutes.passwordReset:
  //       return CupertinoPageRoute(builder: (_) => const PasswordResetPage());

  //     case AppRoutes.newItems:
  //       return CupertinoPageRoute(builder: (_) => const NewItemsPage());

  //     case AppRoutes.popularItems:
  //       return CupertinoPageRoute(builder: (_) => const PopularPackPage());

  //     case AppRoutes.bundleProduct:
  //       return CupertinoPageRoute(
  //           builder: (_) => const BundleProductDetailsPage());

  //     case AppRoutes.bundleDetailsPage:
  //       return CupertinoPageRoute(builder: (_) => const BundleDetailsPage());

  //     case AppRoutes.productDetails:
  //       return CupertinoPageRoute(builder: (_) => const ProductDetailsPage());

  //     case AppRoutes.createMyPack:
  //       return CupertinoPageRoute(builder: (_) => const BundleCreatePage());

  //     case AppRoutes.orderSuccessfull:
  //       return CupertinoPageRoute(builder: (_) => const OrderSuccessfullPage());

  //     case AppRoutes.orderFailed:
  //       return CupertinoPageRoute(builder: (_) => const OrderFailedPage());

  //     case AppRoutes.myOrder:
  //       return CupertinoPageRoute(builder: (_) => const AllOrderPage());

  //     case AppRoutes.orderDetails:
  //       return CupertinoPageRoute(builder: (_) => const OrderDetailsPage());

  //     case AppRoutes.coupon:
  //       return CupertinoPageRoute(builder: (_) => const CouponAndOffersPage());

  //     case AppRoutes.couponDetails:
  //       return CupertinoPageRoute(builder: (_) => const CouponDetailsPage());

  //     case AppRoutes.profileEdit:
  //       return CupertinoPageRoute(builder: (_) => const ProfileEditPage());

  //     case AppRoutes.newAddress:
  //       return CupertinoPageRoute(builder: (_) => const NewAddressPage());

  //     case AppRoutes.deliveryAddress:
  //       return CupertinoPageRoute(builder: (_) => const AddressPage());

  //     case AppRoutes.notifications:
  //       return CupertinoPageRoute(builder: (_) => const NotificationPage());

  //     case AppRoutes.settingsNotifications:
  //       return CupertinoPageRoute(
  //           builder: (_) => const NotificationSettingsPage());

  //     case AppRoutes.settings:
  //       return CupertinoPageRoute(builder: (_) => const SettingsPage());

  //     case AppRoutes.settingsLanguage:
  //       return CupertinoPageRoute(builder: (_) => const LanguageSettingsPage());

  //     case AppRoutes.changePassword:
  //       return CupertinoPageRoute(builder: (_) => const ChangePasswordPage());

  //     case AppRoutes.changePhoneNumber:
  //       return CupertinoPageRoute(
  //           builder: (_) => const ChangePhoneNumberPage());

  //     case AppRoutes.review:
  //       return CupertinoPageRoute(builder: (_) => const ReviewPage());

  //     case AppRoutes.submitReview:
  //       return CupertinoPageRoute(builder: (_) => const SubmitReviewPage());

  //     case AppRoutes.drawerPage:
  //       return CupertinoPageRoute(builder: (_) => const DrawerPage());

  //     case AppRoutes.aboutUs:
  //       return CupertinoPageRoute(builder: (_) => const AboutUsPage());

  //     case AppRoutes.termsAndConditions:
  //       return CupertinoPageRoute(
  //           builder: (_) => const TermsAndConditionsPage());

  //     case AppRoutes.faq:
  //       return CupertinoPageRoute(builder: (_) => const FAQPage());

  //     case AppRoutes.help:
  //       return CupertinoPageRoute(builder: (_) => const HelpPage());

  //     case AppRoutes.contactUs:
  //       return CupertinoPageRoute(builder: (_) => const ContactUsPage());

  //     case AppRoutes.paymentMethod:
  //       return CupertinoPageRoute(builder: (_) => const PaymentMethodPage());

  //     case AppRoutes.paymentCardAdd:
  //       return CupertinoPageRoute(builder: (_) => const AddNewCardPage());

  //     default:
  //       return errorRoute();
  //   }
  // }

  // static Route? errorRoute() =>
  //     CupertinoPageRoute(builder: (_) => const UnknownPage());
// }
