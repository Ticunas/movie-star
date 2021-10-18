import 'package:auto_route/auto_route.dart';
import 'package:movie_star/features/guard/presentation/guard_page.dart';
import 'package:movie_star/features/login/presentation/page/login_page.dart';
import 'package:movie_star/features/popular_movies/presentation/pages/popular_movies_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: GuardPage, initial: true),
  AutoRoute(page: LoginPage),
  AutoRoute(page: PopularMoviesPage)
])
class $AppRouter {}
