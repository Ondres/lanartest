import 'package:flutter/material.dart';
import 'package:lanartestpr/posts/posts.dart';

class App extends MaterialApp {
  const App({Key? key})
      : super(
            debugShowCheckedModeBanner: false,
            key: key,
            home: const PostsPage());
}
