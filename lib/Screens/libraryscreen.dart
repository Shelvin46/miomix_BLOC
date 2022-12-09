import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miomix/Playlists/playlistscreen.dart';
import 'package:miomix/Screens/mainscreen.dart';
import 'package:miomix/favourites/favoritelist.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createPlaylist(context);
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
                        return FavoritePagelist();
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
              child: Padding(
                padding: EdgeInsets.only(left: width1 * 0.05),
                child: ListView.separated(
                    // scrollDirection: Axis.vertical,
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Playlistscreen();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  height: height1 * 0.15,
                                  width: width1 * 0.25,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://media.istockphoto.com/id/685111998/photo/young-girl-dancing-to-the-music.jpg?b=1&s=612x612&w=0&k=20&c=hzH3S5_9l_P-ZfpGwyz5OQp1QsSfEJor48jObUfUnBU=',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Playlist $index',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width1 * 0.3),
                                child: GestureDetector(
                                  onTap: () {
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
                                                  deleteListSnackbar(context);
                                                  Navigator.pop(context);
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
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  renamePlaylist();
                                                },
                                                child: const Text(
                                                  'Rename Playlist',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.white,
                                    // color: Color(Colors.white),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: 10),
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

  // bottomSheetedit(context) {
  // Widget bottomSheet(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Padding(
  //       padding:
  //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //       child: Container(
  //         height: 423 * 0.7,
  //         color: const Color.fromARGB(255, 24, 24, 24),
  //         child: Column(
  //           children: [createPlaylist(context)],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  createPlaylist(context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: width1 * 0.449,
          height: height1 * 0.50,
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.only(top: height1 * 0.01),
                  child: const Text(
                    'Create Playlist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
              ),
              formButtons(context)
            ],
          ),
        );
      },
    );
  }
  // <--------------------------------------------------------------------------Playlist creation-------------------------------------------------------------------------------------------------------------------------------------------------->

  Row formButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("cancel")),
        ElevatedButton(onPressed: () {}, child: const Text("Create"))
      ],
    );
  }
  // <------------------------------------------------------------------------ Playlist create & cancel button --------------------------------------------------------------------------------------------------------------------------------------------------->

  renamePlaylist() {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: width1 * 0.449,
          height: height1 * 0.50,
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.only(top: height1 * 0.01),
                  child: const Text(
                    'Rename Playlist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
              ),
              formButtons(context)
            ],
          ),
        );
      },
    );
  }
  // <----------------------------------------------------------------------Rename Playlist------------------------------------------------------------------------------------------------------------------------------------------------------>
}
