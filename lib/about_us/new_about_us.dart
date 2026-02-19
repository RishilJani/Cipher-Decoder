import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/import_export.dart';

class NewAboutUs extends StatelessWidget {
  const NewAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cyberpunkDark,
      appBar: AppBar(
        backgroundColor: cyberpunkCyanDark,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Center(
              child: ClipOval(
                child: Image.asset(
                  APP_LOGO_PATH,
                  height: 120,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _AboutCard(
              color: cyberpunkGreen,
              text: "Meet Our Team",
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Column(
                  children: [
                    _AboutCardRow(
                      text: "Rishil V. Jani",
                      tittleText: "Developed By",
                      colorValue: cyberpunkGreen,
                    ),
                    _AboutCardRow(
                      text: "Prof. Mehul Bhundiya",
                      tittleText: "Mentored By",
                      colorValue: cyberpunkGreen,
                    ),
                    _AboutCardRow(
                      text: "ASWDC",
                      tittleText: "Explored By",
                      colorValue: cyberpunkGreen,
                    ),
                    _AboutCardRow(
                      text: "Darshan University, Rajkot",
                      tittleText: "Eulogized By",
                      colorValue: cyberpunkGreen,
                    ),
                  ],
                ),
              ),
            ),
            _AboutCard(
                text: "About Us", child: infoCard(), color: cyberpunkGreen),
            _AboutCard(
              text: "Contact Us",
              color: cyberpunkGreen,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _CardRow(
                      icon: Icons.mail,
                      text: "aswdc@darshan.ac.in",
                      colorValue: cyberpunkGreen,
                      textColor: cyberpunkWhite,
                      onTap: () {
                        _launchURL("mailto:aswdc@darshan.ac.in");
                      },
                    ),
                    _CardRow(
                      icon: Icons.phone,
                      text: "+91-97277 47317",
                      colorValue: cyberpunkGreen,
                      textColor: cyberpunkWhite,
                      onTap: () {
                        _launchURL("tel:+919727747317");
                      },
                    ),
                    _CardRow(
                      icon: Icons.web,
                      text: "darshan.ac.in",
                      colorValue: cyberpunkGreen,
                      textColor: cyberpunkWhite,
                      onTap: () {
                        _launchURL("https://darshan.ac.in");
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 2,
                color: cyberpunkDarkElevated,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: cyberpunkGreen, width: 1.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _CardRow(
                        icon: Icons.share,
                        text: "Share App",
                        colorValue: cyberpunkGreen,
                        textColor: cyberpunkWhite,
                        onTap: () {
                          // Share.share(SHARE_APP_MESSAGE);
                          SharePlus.instance.share(ShareParams(
                              text: "$SHARE_APP_MESSAGE \n$DU_URL",

                          ));
                        },
                      ),
                      _CardRow(
                        icon: Icons.apps,
                        text: "More Apps",
                        colorValue: cyberpunkGreen,
                        textColor: cyberpunkWhite,
                        onTap: () {
                          _launchURL(
                              "https://play.google.com/store/apps/developer?id=Darshan+University");
                        },
                      ),
                      _CardRow(
                        icon: Icons.star,
                        text: "Rate Us",
                        colorValue: cyberpunkGreen,
                        textColor: cyberpunkWhite,
                        onTap: () {
                          _launchURL(ANDROID_APP_URL);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: [
                  const Text(
                    "© 2024 Darshan University",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cyberpunkGray),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "All Rights Reserved -",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: cyberpunkGray),
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL(
                              "https://darshan.ac.in/aswdc-privacy-policy-general");
                        },
                        child: const Text(" Privacy Policy",
                            style: TextStyle(color: Colors.blueAccent)),
                      )
                    ],
                  ),
                  const Text(
                    "Made with ❤ in India",
                    style: TextStyle(color: cyberpunkGray),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}

Widget infoCard() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                DU_LOGO_PATH,
                height: 65,
              ),
              Image.asset(
                ASWDC_LOGO_PATH,
                height: 65,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.\n\nSole purpose of ASWDC is to bridge gap between university curriculum &amp; industry demands. Students learn cutting edge technologies, develop real world application & experiences professional environment @ ASWDC under guidance of industry experts & faculty members.",
            style: TextStyle(
              fontSize: 15.0,
              color: cyberpunkWhite,
            ),
          ),
        ),
      ],
    ),
  );
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({
    required this.text,
    required this.child,
    required this.color,
  });

  final String text;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4))),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, top: 5, right: 15, left: 15),
                child: Text(text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Card(
            elevation: 2,
            color: cyberpunkDarkElevated,
            margin: EdgeInsets.zero,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: color, width: 1.5)),
            child: child,
          )
        ],
      ),
    );
  }
}

class _AboutCardRow extends StatelessWidget {
  const _AboutCardRow({
    required this.text,
    required this.tittleText,
    required this.colorValue,
  });

  final String text;
  final String tittleText;
  final Color colorValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 95,
            child: Text(
              tittleText,
              style: TextStyle(
                color: colorValue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              ":",
              style: TextStyle(color: colorValue),
            ),
          ),
          Flexible(
              child: Text(
            text,
            style: const TextStyle(
              color: cyberpunkWhite,
            ),
          ))
        ],
      ),
    );
  }
}

class _CardRow extends StatelessWidget {
  const _CardRow({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.textColor,
    required this.colorValue,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color colorValue;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Icon(
              icon,
              size: 20,
              color: colorValue,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: onTap,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 15, color: textColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
