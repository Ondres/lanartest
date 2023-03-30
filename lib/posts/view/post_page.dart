import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanartestpr/posts/posts.dart';

var _dio = Dio();

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Posts'),

          IconButton(
              onPressed: () {
                textController.clear();
                PostBloc(dio: _dio)..add(PostFetched());
              },
              icon: Icon(Icons.replay_circle_filled)),
        ],
      )),
      body: BlocProvider(
        create: (_) => PostBloc(dio: _dio)..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
