import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      // bottomSheet: miniPlayer(context),
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
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
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
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width1 * 0.030, 0, width1 * 0.030, height1 * 0.00010),
              child: TextFormField(
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255))),
                onTap: () {
                  //showSearch(context: context, delegate: SearchLocation());
                },
                // controller: searchController,
                // onChanged: (value) => updateList(value),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  hintText: 'Search song, artist, album or playlist',
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(113, 158, 158, 158),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(146, 50, 50, 50),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            listView(context)
          ],
        ),
      ),
    );
  }

  // miniPlayer(context) {
  //   final height1 = MediaQuery.of(context).size.height;
  //   final width1 = MediaQuery.of(context).size.width;
  //   return Row(
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) {
  //                 return  MusicPlayScreen(index:,);
  //               },
  //             ),
  //           );
  //         },
  //         child: Expanded(
  //           child: Container(
  //             width: width1 * 1.00,
  //             height: height1 * 0.10,
  //             // height: 80,
  //             // width: 387.3,
  //             color: const Color.fromARGB(255, 28, 97, 150),
  //             child: Row(
  //               children: [
  //                 // const SizedBox(
  //                 //   width: 18,
  //                 // ),
  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(
  //                       width1 * 0.0400, 0, 0, height1 * 0.00010),
  //                   child: const CircleAvatar(
  //                     radius: 30,
  //                     backgroundImage: AssetImage('assets/images/splash.jpg'),
  //                   ),
  //                 ),

  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(
  //                       width1 * 0.1000, 0, 0, height1 * 0.00010),
  //                   child: const Text(
  //                     'Music 1',
  //                     style: TextStyle(color: Colors.white, fontSize: 20),
  //                   ),
  //                 ),

  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(
  //                       width1 * 0.13, 0, 0, height1 * 0.00010),
  //                   child: const Icon(
  //                     Icons.skip_previous,
  //                     color: Colors.white,
  //                     size: 50,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(
  //                       width1 * 0.00300, 0, 0, height1 * 0.00010),
  //                   child: const Icon(
  //                     Icons.pause,
  //                     color: Colors.white,
  //                     size: 50,
  //                   ),
  //                 ),
  //                 const Icon(
  //                   Icons.skip_next,
  //                   color: Colors.white,
  //                   size: 50,
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  listView(context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Expanded(
      child: SizedBox(
        height: 20,
        child: ListView.separated(
            shrinkWrap: true,
            // scrollDirection: Axis.vertical,
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
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          width: width1 * 0.449,
                          height: height1 * 0.20,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Add to Playlist',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                'Add to Favorites',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
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
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 20),
      ),
    );
  }
}
//how