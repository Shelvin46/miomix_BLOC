import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:miomix/Models/allsonglist.dart';
import 'package:miomix/Playlists/playlistscreen.dart';
import 'package:miomix/favourites/favoritelist.dart';
import '../Models/dbfunction.dart';
import '../Models/playlistmpdel.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  TextEditingController _textEditingController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final formGlobalKey1 = GlobalKey<FormState>();
  List<PlaylistSongs> playlist = [];

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return bottomSheet(context);
            },
          );
          //createPlaylist(context);
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) => bottomSheet(context),
          // );
        },
        child: const Icon(Icons.add),
      ),
      // <-------------------------------------------------------------------------Create Playlist------------------------------------------------------------------------------------------------------------------------------------------------------------->
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
                          'My Library',
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
            // <-----------------------------------------------------App bar Container------------------------------------------------------------------------------------------------------------------------------------------>
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width1 * 0.02, 0, width1 * 0.02, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const FavoritePagelist();
                      },
                    ),
                  );
                },
                child: Container(
                  width: width1 * 07,
                  height: height1 * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 73, 121, 161),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(width1 * 0.030, 0,
                            width1 * 0.030, height1 * 0.00010),
                        child: const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'Favorite Songs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(width1 * 0.3, 0, 0, 0),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // <----------------------------------------------------------------------Favorite song button----------------------------------------------------------------------------------------------------------------------------------->
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width1 * 07,
                height: height1 * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 43, 84, 118),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width1 * 0.030, 0, width1 * 0.030, height1 * 0.00010),
                      child: const Icon(
                        Icons.playlist_add_check,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const Text(
                      'Your Playlist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // <----------------------------------------------------------------------Playlist heading------------------------------------------------------------------------------------------------------------------>
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: playlistbox.listenable(),
                builder: (context, data, child) {
                  List<PlaylistSongs> allplay = data.values.toList();

                  if (playlistbox.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        heightFactor: 7.5,
                        child: Center(
                          child: Text(
                            "No Playlist Created",
                            style: GoogleFonts.montserrat(
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Playlistscreen(
                                allPlaylistSongs:
                                    allplay[index].playlistssongs!,
                                playlistindex: index,
                                playlistname: allplay[index].playlistname!,
                              ),
                            ),
                          ),
                          leading: Container(
                            height: height1 * 0.15,
                            width: width1 * 0.17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/studio.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: Text(
                            allplay[index].playlistname.toString(),
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 13.43,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    width: width1 * 0.449,
                                    height: height1 * 0.20,
                                    color: Colors.black,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Delete Playlist'),
                                                  content: const Text(
                                                      'Are You Sure'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          return Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Cancel')),
                                                    TextButton(
                                                        onPressed: () {
                                                          playlistbox
                                                              .deleteAt(index);
                                                          deleteListSnackbar(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Delete'))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Delete Playlist',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            List<Songs>? exisitingSongs =
                                                allplay[index].playlistssongs!;
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return bottomSheetedit(
                                                    context,
                                                    index,
                                                    allplay[index]
                                                        .playlistname!,
                                                    exisitingSongs);
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'Rename playlist',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.more_vert_sharp),
                            color: Colors.white,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: allplay.length);
                },
              ),
            ),
            // <----------------------------------------------------------------- Playlists---------------------------------------------------------------------------------------------------------------------->
          ],
        ),
      ),
    );
  }

  deleteListSnackbar(context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          'Deleted Successfully',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
  // <------------------------------------------------Delete Snackbar------------------------------------------------------------------------------------------------------------------------------------------>

  Widget bottomSheet(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 250,
        color: const Color.fromARGB(255, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [playlistform(context)],
        ),
      ),
    );
  }

  Padding playlistform(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        child: Column(
          children: [
            Text(
              "Create Playlist ",
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
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  hintText: "Enter a name",
                  hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69))),
                ),
                validator: (value) {
                  List<PlaylistSongs> values = playlistbox.values.toList();

                  bool isAlreadyAdded = values
                      .where((element) => element.playlistname == value!.trim())
                      .isNotEmpty;

                  if (value!.trim() == '') {
                    return 'Name required';
                  }
                  if (value.trim().length > 10) {
                    return 'Enter Characters below 10 ';
                  }

                  if (isAlreadyAdded) {
                    return 'Name Already Exists';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            formButtons(context)
          ],
        ),
      ),
    );
  }

  Row formButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            final isValid = formGlobalKey.currentState!.validate();
            if (isValid) {
              playlistbox.add(PlaylistSongs(
                  playlistname: _textEditingController.text,
                  playlistssongs: []));
              Navigator.pop(context);
            }
          },
          child: const Text("Create"),
        )
      ],
    );
  }
  // <------------------------------------------------------------------------ Playlist create & cancel button --------------------------------------------------------------------------------------------------------------------------------------------------->

  bottomSheetedit(
      BuildContext context, int index, String name, List<Songs> exisongs) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 423 * 0.7,
          color: const Color.fromARGB(255, 24, 24, 24),
          child: Column(
            children: [editBottom(context, index, name, exisongs)],
          ),
        ),
      ),
    );
  }

  editBottom(
      BuildContext context, int index, String name, List<Songs> exisongs) {
    controller.text = name;

    log(name);
    //double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          children: [
            Text(
              "Edit Playlist ",
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
              key: formGlobalKey1,
              child: TextFormField(
                controller: controller,
                cursorHeight: 25,
                decoration: InputDecoration(
                  //label: Text(name),
                  filled: true,
                  fillColor: const Color.fromARGB(199, 255, 255, 255),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  hintText: "Enter a name",
                  hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69))),
                ),
                validator: (value) {
                  List<PlaylistSongs> values = playlistbox.values.toList();

                  bool isAlreadyAdded = values
                      .where((element) => element.playlistname == value!.trim())
                      .isNotEmpty;
                  if (value!.trim() == '') {
                    return 'Name Required';
                  }
                  if (value.trim().length > 10) {
                    return 'Enter Characters below 10 ';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            formButtonsedit(context, index, name, exisongs)
          ],
        ),
      ),
    );
  }

  Row formButtonsedit(
      BuildContext context, int index, String name, List<Songs> exisongs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("cancel")),
        ElevatedButton(
            onPressed: () {
              final isValid = formGlobalKey1.currentState!.validate();
              if (isValid) {
                playlistbox.putAt(
                    index,
                    PlaylistSongs(
                        playlistname: controller.text,
                        playlistssongs: exisongs));
                Navigator.pop(context);
              }
            },
            child: const Text("Create"))
      ],
    );
  }
  // <----------------------------------------------------------------------Rename Playlist------------------------------------------------------------------------------------------------------------------------------------------------------>
}

//how to set border in container in flutter?





