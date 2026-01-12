import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/core/animations/page_slider.dart';
import 'package:my_flutter_app/presentation/screens/home/home_screen.dart';

import 'package:my_flutter_app/presentation/screens/menu/menu_screen.dart';
import 'package:my_flutter_app/presentation/screens/random/random_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => Home()),
    GoRoute(
      path: '/menu',
      pageBuilder: (context, state) =>
          PageSlider().newPageAppearFromRightToLeft(
            context: context,
            state: state,
            child: MenuScreen(),
          ),
    ),
    GoRoute(
      path: '/random',
      pageBuilder: (context, state) =>
          PageSlider().newPageAppearFromRightToLeft(
            context: context,
            state: state,
            child: RandomScreen(),
          ),
    ),
  ],
);
