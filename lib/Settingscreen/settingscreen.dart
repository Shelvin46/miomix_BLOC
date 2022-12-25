import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miomix/Screens/searchscreen.dart';
import 'package:miomix/Settingscreen/popup.dart';
import 'package:miomix/Settingscreen/privacy_policy.dart';
import 'package:miomix/Settingscreen/termsandconditions.dart';
import 'package:switcher_button/switcher_button.dart';

import '../Models/dbfunction.dart';
import '../Models/nickname.dart';

class SetttingScreen extends StatefulWidget {
  const SetttingScreen({super.key});

  @override
  State<SetttingScreen> createState() => _SetttingScreenState();
}

class _SetttingScreenState extends State<SetttingScreen> {
  TextEditingController _textEditingController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
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
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return TermsAndconditions();
                    },
                  ));
                  // showDialog(
                  //     context: context,
                  //     builder: (builder) {
                  //       return settingmenupopup(
                  //           mdFilename: 'termsandconditons.md');
                  //     });
                },
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
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PrivacyPolicy(),
                  ));
                },
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
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => bottomSheet(context),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Nickname',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                    // SizedBox(
                    //   width: 13,
                    // ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListTile(
                  trailing: SwitcherButton(
                    value: true,
                    size: 27,
                    onChange: (value) {
                      audioPlayer.showNotification = true;
                    },
                  ),
                  title: const Text(
                    "Notifications",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                )),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width1 * 0.0400, 0, width1 * 0.0200, 0),
              child: InkWell(
                onTap: () {
                  aboutPopUp();
                },
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: width * 0.7,
          color: const Color.fromARGB(255, 24, 24, 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Column(
                    children: [
                      Text(
                        "Enter a nick name ",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formGlobalKey,
                        child: TextFormField(
                          controller: _textEditingController,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(199, 255, 255, 255),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            hintText: "Enter a name",
                            hintStyle: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 69, 69, 69))),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            if (value.trim().length > 5) {
                              return 'Nick name should be only 5 characters in length';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("cancel")),
                          ElevatedButton(
                              onPressed: () {
                                final isValid =
                                    formGlobalKey.currentState!.validate();
                                if (isValid) {
                                  nameBox.put(
                                      0,
                                      nickName(
                                          name: _textEditingController.text));
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Ok"))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  aboutPopUp() {
    showAboutDialog(
        context: context,
        applicationName: "Mio Mix",
        applicationIcon: Image.asset(
          "assets/images/studio.png",
          height: 32,
          width: 32,
        ),
        applicationVersion: "1.0.1",
        children: [
          const Text(
              "Mio Mix is an offline music player app which allows use to hear music from their storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
          const SizedBox(
            height: 10,
          ),
          const Text("App developed by Shelvin Varghese.")
        ]);
  }
}
