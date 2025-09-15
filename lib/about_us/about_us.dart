import '../utils/import_export.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return DeveloperScreen(
        developerName: "Rishil V. Jani",
        mentorName: "Prof. Mehul Bhundiya",
        exploredByName: "ASWDC",
        isAdmissionApp: false,
        shareMessage: '',
        appTitle: "SherlockCode",
        appLogo: 'assets/image/SherlockCode.png',
        appBarColor: cyberpunkGreenDark,
        backgroundColor: cyberpunkLightElevated,
    );
  }
}
