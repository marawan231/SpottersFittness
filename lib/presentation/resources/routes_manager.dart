import 'package:flutter/material.dart';
import 'package:spotters_app_clone/business_logic/cubit/chat_cubit/chat_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/contact_cubit/message_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/countries_cubit/countries_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/personal_data_cubit/profile_cubit_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/profile_cubit/profile_cubit.dart';

import 'package:spotters_app_clone/business_logic/cubit/subscribtion_cubit/subscribtion_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/terms_privacy/terms_privacy_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/user_payment/user_payment_info_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/verify_cubit/verfiy_cubit.dart';
import 'package:spotters_app_clone/business_logic/cubit/videos_cubit/videos_cubit.dart';
import 'package:spotters_app_clone/data/repository/certi_repository.dart';
import 'package:spotters_app_clone/data/repository/chat_repositroy.dart';
import 'package:spotters_app_clone/data/repository/cites_repository.dart';
import 'package:spotters_app_clone/data/repository/contact_repository.dart';
import 'package:spotters_app_clone/data/repository/countries_repoistory.dart';
import 'package:spotters_app_clone/data/repository/edit_profile_repositroy.dart';
import 'package:spotters_app_clone/data/repository/fetch_profile_repository.dart';
import 'package:spotters_app_clone/data/repository/privacy_repository.dart';
import 'package:spotters_app_clone/data/repository/profile_info_repository.dart';
import 'package:spotters_app_clone/data/repository/profile_pic_repository.dart';
import 'package:spotters_app_clone/data/repository/spicialist_repository.dart';
import 'package:spotters_app_clone/data/repository/subscribtion_repoistory.dart';
import 'package:spotters_app_clone/data/repository/sumbit_repository.dart';
import 'package:spotters_app_clone/data/repository/terms_conditions_repository.dart';
import 'package:spotters_app_clone/data/repository/user_payment_info_by_date_repository.dart';
import 'package:spotters_app_clone/data/repository/user_payment_info_repository.dart';
import 'package:spotters_app_clone/data/repository/verfying_repository.dart';
import 'package:spotters_app_clone/data/repository/videos_repository.dart';
import 'package:spotters_app_clone/data/web_services/certi_web_services.dart';
import 'package:spotters_app_clone/data/web_services/chat_web_services.dart';
import 'package:spotters_app_clone/data/web_services/cities_web_services.dart';
import 'package:spotters_app_clone/data/web_services/contact_web_services.dart';
import 'package:spotters_app_clone/data/web_services/countries_web_services.dart';
import 'package:spotters_app_clone/data/web_services/edit_profile_web_services.dart';
import 'package:spotters_app_clone/data/web_services/fetch_profile_web_services.dart';
import 'package:spotters_app_clone/data/web_services/privacy_web_services.dart';
import 'package:spotters_app_clone/data/web_services/profile_info_web_services.dart';
import 'package:spotters_app_clone/data/web_services/profile_pic_web_services.dart';
import 'package:spotters_app_clone/data/web_services/specialist_web_services.dart';
import 'package:spotters_app_clone/data/web_services/subscribtion_web_services.dart';
import 'package:spotters_app_clone/data/web_services/sumbit_web_services.dart';
import 'package:spotters_app_clone/data/web_services/terms_and_conditions.dart';
import 'package:spotters_app_clone/data/web_services/user_payment_web_services.dart';
import 'package:spotters_app_clone/data/web_services/user_payments_info_by_date_web_services.dart';
import 'package:spotters_app_clone/data/web_services/verify_otb_web_services.dart';
import 'package:spotters_app_clone/data/web_services/videos_web_services.dart';
import 'package:spotters_app_clone/draft/draft.dart';
import 'package:spotters_app_clone/presentation/chat_view/chat_view.dart';
import 'package:spotters_app_clone/presentation/contact_us/contact_us.dart';
import 'package:spotters_app_clone/presentation/edit_personal_info/edit_personal_info.dart';
import 'package:spotters_app_clone/presentation/edit_profile_view/edit_profile_view.dart';
import 'package:spotters_app_clone/presentation/forgot_password/forgot_password_view.dart';
import 'package:spotters_app_clone/presentation/home_page/home_page.dart';
import 'package:spotters_app_clone/presentation/notifitcation/notification.dart';
import 'package:spotters_app_clone/presentation/otb/otb_view.dart';
import 'package:spotters_app_clone/presentation/payment_details/payment_details.dart';
import 'package:spotters_app_clone/presentation/payment_success/payment_success.dart';
import 'package:spotters_app_clone/presentation/personal_info/personal_info.dart';
import 'package:spotters_app_clone/presentation/privacy_policy/privacy_policy.dart';
import 'package:spotters_app_clone/presentation/profile/profile_view.dart';
import 'package:spotters_app_clone/presentation/resources/strngs_manager.dart';
import 'package:spotters_app_clone/presentation/settings_view/settings_view.dart';
import 'package:spotters_app_clone/presentation/subscribtion_fee/subscribtion_fee.dart';
import 'package:spotters_app_clone/presentation/subscribtion_renwal/subscribtion_renwal_view.dart';
import 'package:spotters_app_clone/presentation/terms_and_conditions/terms_and_condition_view.dart';
import 'package:spotters_app_clone/presentation/training_videos/training_videos.dart';
import 'package:spotters_app_clone/presentation/upload_training_video/upload_training_video.dart';
import 'package:spotters_app_clone/presentation/user_details/user_details_view.dart';
import 'package:spotters_app_clone/presentation/user_payments/user_payments.dart';
import 'package:spotters_app_clone/presentation/users/users.dart';
import 'package:spotters_app_clone/presentation/videos_view/videos_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/register_cubit/register_cubit.dart';
import '../../business_logic/cubit/login_cubit/login_cubit.dart';
import '../../data/repository/login_repoistry.dart';
import '../../data/repository/register_repoistry.dart';
import '../../data/web_services/login_web_services.dart';
import '../../data/web_services/register_web_services.dart';

import '../login/login_view.dart';

import '../register/register_view.dart';
import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/splashRoute";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String onBoardingRoute = "/onBoardingRoute";
  static const String otbScreen = "/otbScreen";
  static const String subscribtionFee = "/subscribtionFee";
  static const String subscribtionRenwal = "/subscribtionRenwal";
  static const String paymentDetails = "/paymentDetails";
  static const String paymentSuccess = "/paymentSuccess";
  static const String personalInfo = "/personalInfo";
  static const String editPersonalInfo = "/editPersonalInfo";
  static const String homePage = "/homePage";
  static const String uploadTrainngVideos = "/uploadTrainngVideos";
  static const String videos = "/videos";
  static const String users = "/users";
  static const String userDetails = "/userDetails";
  static const String trainingVideos = "/trainingVideos";
  static const String profile = "/profile";
  static const String editProfile = "/editProfile";
  static const String chat = "/chat";
  static const String settings = "/settings";
  static const String terms = "/terms";
  static const String privacyPolicy = "/privacyPolicy";
  static const String contactUs = "/contactUs";
  static const String notiftcation = "/notiftcation";
  static const String userPyments = "/userPyments";
}

class RouteGenerator {
  late LoginRepoistry loginRepoistry;
  late LoginCubit loginCubit;
  late RegisterRepoistry registerRepoistry;
  late RegisterCubit registerCubit;
  late SubscriptionRepoistory subscriptionRepoistory;
  late SubscribtionCubit subscribtionCubit;
  late CountriesRepoistory countriesRepoistory;
  late CountriesCubit countriesCubit;
  late CitiesRepository citiesRepository;
  late SpicialistRepository spicialistRepository;
  late SumbitRepository sumbitRepository;
  late ProfilePicRepository profilePicRepository;
  late UserPaymentInfoRepository userPaymentInfoRepository;
  late UserPaymentInfoByDateRepository userPaymentInfoByDateRepository;
  late UserPaymentInfoCubit userPaymentInfoCubit;
  late TermsAndConditionsReopsitory termsAndConditionsReopsitory;
  late PrivacyRepositroy privacyRepositroy;
  late TermsPrivacyCubit termsPrivacyCubit;
  late ProfileInfoRepository profileInfoRepository;
  late FetchProfileRepository fetchProfileRepository;
  late ProfileCubit profileCubit;
  late EditProfileRepository editProfileRepository;
  late VidoesRepository vidoesRepository;
  late VideosCubit videosCubit;
  late ContactRepository contactRepository;
  late MessageCubit messageCubit;
  late CertiRepository certiRepository;
  late ChatRepository chatRepository;
  late ChatCubit chatCubit;
  late VerfyingRepoistry verfyingRepoistry;
  late VerfiyCubit verfiyCubit;

  RouteGenerator() {
    loginRepoistry = LoginRepoistry(LoginWebServices());
    loginCubit = LoginCubit(loginRepoistry);
    registerRepoistry = RegisterRepoistry(RegisterWebServices());
    registerCubit = RegisterCubit(registerRepoistry);
    subscriptionRepoistory = SubscriptionRepoistory(SubscribtionWebServices());
    subscribtionCubit = SubscribtionCubit(subscriptionRepoistory);
    countriesRepoistory = CountriesRepoistory(CountriesWebServices());
    citiesRepository = CitiesRepository(CitiesWebServices());
    spicialistRepository = SpicialistRepository(SpicialistWebServices());
    sumbitRepository = SumbitRepository(SumbitWebServices());
    profilePicRepository = ProfilePicRepository(ProfilePicWebServices());
    profileInfoRepository = ProfileInfoRepository(ProfileInfoWebServices());
    certiRepository = CertiRepository(CertiWebServices());
    countriesCubit = CountriesCubit(
      countriesRepoistory,
      citiesRepository,
      spicialistRepository,
      sumbitRepository,
      profilePicRepository,
      profileInfoRepository,
      certiRepository,
    );
    userPaymentInfoRepository =
        UserPaymentInfoRepository(UserPaymentsInfoWebServices());
    userPaymentInfoByDateRepository =
        UserPaymentInfoByDateRepository(UserPaymentsInfoByDateWebServices());
    userPaymentInfoCubit = UserPaymentInfoCubit(
        userPaymentInfoRepository, userPaymentInfoByDateRepository);
    termsAndConditionsReopsitory =
        TermsAndConditionsReopsitory(TermsAndConditionsWebServices());
    privacyRepositroy = PrivacyRepositroy(PrivacyWebServices());

    termsPrivacyCubit =
        TermsPrivacyCubit(termsAndConditionsReopsitory, privacyRepositroy);
    fetchProfileRepository = FetchProfileRepository(FetchProfileWebServices());
    editProfileRepository = EditProfileRepository(EditProfileWebServices());
    profileCubit = ProfileCubit(fetchProfileRepository, editProfileRepository);
    vidoesRepository = VidoesRepository(VideosWebServices());
    videosCubit = VideosCubit(vidoesRepository);
    contactRepository = ContactRepository(ContactWebServices());
    messageCubit = MessageCubit(contactRepository);
    chatRepository = ChatRepository(ChatWebServices());
    chatCubit = ChatCubit(chatRepository);
    verfyingRepoistry = VerfyingRepoistry(VerfyingWebServices());
    verfiyCubit = VerfiyCubit(verfyingRepoistry);
  }

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: loginCubit,
                  child: const LoginView(),
                ));
      case Routes.registerRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: registerCubit,
                  child: const RegisterView(),
                ));
      case Routes.otbScreen:
        final arguments = settings.arguments as Map;
        final email = arguments['email'];
        final String otpCode = arguments['otpCode'];
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: registerCubit,
                    ),
                    BlocProvider.value(
                      value: verfiyCubit,
                    ),
                  ],
                  child: OtbView(
                    email: email,
                    otpCode: otpCode,
                  ),
                ));
      case Routes.subscribtionFee:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: subscribtionCubit,
                  child: const SubscribtionFeeView(),
                ));
      case Routes.paymentDetails:
        final arguments = settings.arguments as Map;
        final planPrice = arguments['planPrice'];
        return MaterialPageRoute(
            builder: (_) => PaymentDetailsView(
                  planPrice: planPrice,
                ));
      case Routes.paymentSuccess:
        return MaterialPageRoute(builder: (_) => const PaymentSuccessView());
      case Routes.personalInfo:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: countriesCubit,
                  ),
                  BlocProvider.value(
                    value: profileCubit,
                  ),
                ], child: const PersonalInfoView()));
      case Routes.homePage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: profileCubit,
                    ),
                    BlocProvider.value(
                      value: countriesCubit,
                    ),
                    BlocProvider.value(
                      value: chatCubit,
                    ),
                  ],
                  child: const HomePageView(),
                ));
      case Routes.uploadTrainngVideos:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: videosCubit,
                    ),
                    BlocProvider.value(
                      value: countriesCubit,
                    ),
                  ],
                  child: const UploadTrainingVideoView(),
                ));
      case Routes.trainingVideos:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: videosCubit,
            child: const VideoView(),
          ),
        );
      case Routes.users:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: chatCubit,
                  child: const UsersView(),
                ));
      case Routes.userDetails:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: chatCubit,
                  child: const UserDetailsView(),
                ));
      // case Routes.trainingVideos:
      //   return MaterialPageRoute(builder: (_) => const TrainingVideosView());
      case Routes.profile:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: profileCubit,
                    ),
                    BlocProvider.value(
                      value: videosCubit,
                    ),
                  ],
                  child: const ProfileView(),
                ));
      case Routes.chat:
        final arguments = settings.arguments as Map;
        final userToken = arguments['userToken'];

        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: chatCubit,
                  child: ChatView(
                    selectedUserToChatWithToken: userToken,
                  ),
                ));
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.editPersonalInfo:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: countriesCubit,
                  ),
                  BlocProvider.value(
                    value: profileCubit,
                  )
                ], child: const EditPersonalInfoView()));
      case Routes.editProfile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: profileCubit,
                  child: const EditProfileView(),
                ));
      case Routes.subscribtionRenwal:
        return MaterialPageRoute(
            builder: (_) => const SubscribtionRenewalView());

      case Routes.terms:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: termsPrivacyCubit,
                  child: const TermsAndConditionView(),
                ));

      case Routes.notiftcation:
        return MaterialPageRoute(builder: (_) => const NotftcationView());

      case Routes.privacyPolicy:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: termsPrivacyCubit,
                  child: const PrivacyPolicyView(),
                ));
      case Routes.contactUs:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: messageCubit,
                  child: const ContacUsView(),
                ));

      case Routes.userPyments:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: userPaymentInfoCubit,
                  child: const UserPaymentsView(),
                ));

      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: loginCubit,
                  child: const ForgotPasswordView(),
                ));
    }
    return null;
  }
}
