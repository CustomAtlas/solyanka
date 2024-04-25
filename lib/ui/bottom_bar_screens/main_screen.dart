import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/bottom_bar_screens/main_screen_view_model.dart';
import 'package:solyanka/ui/bottom_bar_screens/click_here_screen.dart';
import 'package:solyanka/ui/bottom_bar_screens/home_screen.dart';
import 'package:solyanka/ui/bottom_bar_screens/profile_screen.dart';
import 'package:solyanka/ui/bottom_bar_screens/vacancies_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenViewModel>();
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: model.ytCcontroller,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 75,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: model.image,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.meeting, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 3),
                  Text(
                    model.name,
                    style: const TextStyle(
                        fontSize: 18, color: AppStyles.mainColor),
                  ),
                ],
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 28,
                        color: AppStyles.mainColor,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Icon(Icons.circle, color: Colors.red, size: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                IndexedStack(
                  index: model.currentIndex,
                  children: [
                    const HomeScreen(),
                    ClickHereScreen(ytPlayer: player),
                    const VacanciesScreen(),
                    const ProfileScreen(),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 3,
                      child: DecoratedBox(
                          decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(255, 197, 195, 195)
                                  : const Color.fromARGB(255, 54, 54, 54),
                          blurRadius: 10,
                        )
                      ])),
                    )),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => model.openCurrentPage(value),
              iconSize: 23,
              currentIndex: model.currentIndex,
              elevation: 5,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: model.currentIndex == 0
                      ? const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: _BottomBarItem(
                              icon: Icons.home_filled, title: 'Home'),
                        )
                      : const Icon(Icons.home_filled, color: Colors.grey),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: model.currentIndex == 1
                      ? const _BottomBarItem(icon: Icons.wallet, title: '  :)')
                      : const Icon(Icons.wallet, color: Colors.grey),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: model.currentIndex == 2
                      ? const _BottomBarItem(
                          icon: Icons.pie_chart_outline, title: 'Jobs')
                      : const Icon(Icons.pie_chart_outline, color: Colors.grey),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: model.currentIndex == 3
                      ? const _BottomBarItem(
                          icon: Icons.person_outline_rounded, title: 'Me')
                      : const Icon(Icons.person_outline_rounded,
                          color: Colors.grey),
                  label: '',
                ),
              ],
            ),
          );
        });
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: AppStyles.mainColor,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            Text(title, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
