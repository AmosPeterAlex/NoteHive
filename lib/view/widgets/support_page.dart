import 'package:flutter/material.dart';
import '../utils/my_colors.dart';
import '../utils/my_text_styles.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'Support',
          style: mainTextDark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: primaryColorLight,
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [Colors.purple, Colors.red]),
                  border: Border.all(
                    color: primaryColorDark,
                    width: 3,
                  )),
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("Contact Information", style: mainTextLight),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: primaryColorLight,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'contact@luminartecnolab.com',
                          style: subTextLight,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}