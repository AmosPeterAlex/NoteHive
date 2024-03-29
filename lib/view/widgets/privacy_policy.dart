import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/my_colors.dart';
import '../utils/my_text_styles.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final descriptionstyle =
  GoogleFonts.poppins(color: textColorLight, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColorDark,
          ),
        ),
        backgroundColor: primaryColorLight,
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: mainTextDark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: primaryColorLight,
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                    LinearGradient(colors: [Colors.purple, Colors.red]),
                    border: Border.all(
                      color: primaryColorDark,
                      width: 3,
                    )),
                width: MediaQuery.of(context).size.width * 0.99,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. Information We Collect", style: mainTextLight),
                      Text(
                        '1.1 Personal Information: Notely App does not collect any personal information\n1.2 Device Information: We may collect information about the device you use to access the app, including device type, operating system, and unique device identifiers.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("2. Data Storage", style: mainTextLight),
                      Text(
                        '2.1 Note created using NOTELY are stored locally on the user device.\n2.2 The Hive database for local storage. Hive is an open source, small database.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("3. Security", style: mainTextLight),
                      Text(
                        '3.1 We implement reasonable security measures to protect your information from unauthorized access, disclosure, alteration, destruction and 100% secure.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("4. Children's Privacy", style: mainTextLight),
                      Text(
                        '4.1 Our app is not intended for children under the age of 13, and we do not knowingly collect personal information from children.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("5. Changes to the Privacy Policy",
                          style: mainTextLight),
                      Text(
                        '5.1 We reserve the right to update or modify our privacy policy at any time. We will notify you of any changes by posting the updated policy on our website or through the app.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("6. Third-Party Services", style: mainTextLight),
                      Text(
                        '6.1 NOTELY App may use third-party services for analytics and crash reporting. These services may collect anonymous usage data to help identify and fix app issues.\n6.2 Users are encouraged to review the privacy policies of third-party services used by NOTELY App.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}