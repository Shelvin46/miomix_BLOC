import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class SetttingScreen extends StatefulWidget {
  const SetttingScreen({super.key});

  @override
  State<SetttingScreen> createState() => _SetttingScreenState();
}

class _SetttingScreenState extends State<SetttingScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 63, 97),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width1 * 1,
              height: height1 * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black26,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width1 * 0.05,
                            vertical: height1 * 0.02),
                        child: const Text(
                          'Settings',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Terms And Conditions',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  // SizedBox(
                  //   width: 13,
                  // ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Share The App',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Nickname',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  // SizedBox(
                  //   width: 13,
                  // ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width1 * 0.0001),
                    child: Switch(
                      value: value,
                      onChanged: (onChnaged) {
                        setState(() {
                          value = onChnaged;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'About',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
