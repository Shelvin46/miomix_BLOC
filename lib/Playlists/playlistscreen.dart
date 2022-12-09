import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Playlistscreen extends StatelessWidget {
  const Playlistscreen({super.key});

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
                          'Playlist Name',
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
              height: 10,
            ),
            listView1(context)
          ],
        ),
      ),
    );
  }

  listView1(context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/splash.jpg'),
              ),
              title: Text(
                'Music  $index',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,

                  // color: Color(Colors.white),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: 12),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        deleteSnackbar(context);
        Navigator.pop(context);
      },
    );
    Widget noButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('No'),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Music"),
      content: const Text("Are You Sure"),
      actions: [
        okButton,
        noButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteSnackbar(context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Deleted Sccessfully',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
//how to set alertdialog in flutter?
