import 'package:flutter/material.dart';
import 'package:movie_star/core/di/injection.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/get_movies_local_saved_store.dart';
import 'package:movie_star/features/popular_movies/presentation/stories/get_movies_remote_store.dart';
import 'package:movie_star/features/popular_movies/presentation/tabs/popular_movies_tab.dart';
import 'package:movie_star/features/popular_movies/presentation/tabs/saved_movies_tab.dart';
import 'package:movie_star/features/popular_movies/presentation/widgets/profile_widget.dart';

class PopularMoviesPage extends StatefulWidget {
  final Credential credential;
  const PopularMoviesPage({Key? key, required this.credential})
      : super(key: key);

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: ProfileWidget(
              credential: widget.credential,
            ),
            bottom: const TabBar(tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'Watch Later'),
            ]),
          ),
          body: TabBarView(
            children: [
              PopularMoviesTab(
                getMoviesStore: sl<GetMoviesRemoteStore>(),
              ),
              SavedMoviesTab(store: sl<GetMoviesLocalSavedStore>())
            ],
          )),
    );
  }
}
