import '../utils/import_export.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

      ),
      child: DeveloperScreen(
          developerName: "Rishil V. Jani",
          mentorName: "Prof. Mehul Bhundiya",
          exploredByName: "ASWDC",
          isAdmissionApp: false,
          textColor: Colors.white,
          androidAPPURL: ANDROID_APP_URL,
          iosAPPURL: IOS_APP_URL,
          appTitle: APPLICATION_NAME,
          appLogo: APP_LOGO_PATH,
          appBarColor: cyberpunkGreenDark,
          backgroundColor: cyberpunkLightElevated,
          shareMessage: SHARE_APP_MESSAGE,
      ),
    );
  }
}
