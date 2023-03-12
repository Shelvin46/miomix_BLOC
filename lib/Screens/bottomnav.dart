// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miomix/Screens/libraryscreen.dart';
import 'package:miomix/Screens/mainscreen.dart';
import 'package:miomix/Screens/searchscreen.dart';
import 'package:miomix/blocs/bottom_nav_bloc/bottom_nav_bloc_bloc.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  @override
  List pages = [
    ListScreen(),
    SearchScreen(),
    const LibraryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBlocBloc, BottomNavBlocState>(
      builder: (context, state) {
        int currentSelectIndex = state.count ?? 0;
        return Scaffold(
          body: pages[currentSelectIndex],
          bottomNavigationBar: NavigationBarTheme(
            data: const NavigationBarThemeData(
              backgroundColor: Color.fromARGB(255, 4, 45, 79),
            ),
            child: NavigationBar(
              selectedIndex: currentSelectIndex,
              onDestinationSelected: (index) {
                if (index == 0) {
                  BlocProvider.of<BottomNavBlocBloc>(context)
                      .add(FirstScreen());
                } else if (index == 1) {
                  BlocProvider.of<BottomNavBlocBloc>(context)
                      .add(SecondScreen());
                } else {
                  BlocProvider.of<BottomNavBlocBloc>(context)
                      .add(ThirdScreen());
                }
              },
              height: 65,
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.queue_music_outlined,
                    color: Colors.white,
                  ),
                  label: '',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
    // return Scaffold(
    //   body: pages[currentSelectIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     selectedIconTheme: const IconThemeData(color: Colors.amber),
    //     unselectedIconTheme: const IconThemeData(color: Colors.white),
    //     backgroundColor: const Color.fromARGB(255, 4, 45, 79),
    //     currentIndex: currentSelectIndex,
    //     onTap: (newIndex) {
    //       setState(() {
    //         currentSelectIndex = newIndex;
    //       });
    //     },
    //     items: const [
    //       BottomNavigationBarItem(
    //         // backgroundColor: Colors.black,
    //         icon: Icon(
    //           Icons.home,
    //           color: Colors.white,
    //           size: 29,
    //         ),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.search,
    //           color: Colors.white,
    //           size: 29,
    //         ),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.queue_music,
    //           color: Colors.white,
    //           size: 29,
    //         ),
    //         label: '',
    //       ),
    //     ],
    //   ),
   

// how to set onpress colorn  in flutter?

