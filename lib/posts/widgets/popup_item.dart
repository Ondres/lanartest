import 'package:flutter/material.dart';

import '../models/models.dart';

class PopUp extends StatelessWidget {
  const PopUp({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage(post.url),
                fit: BoxFit.cover,
              ),
            )));
  }
}
