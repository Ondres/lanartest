import 'package:flutter/material.dart';
import 'package:lanartestpr/posts/posts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostListItem extends StatelessWidget {
  PostListItem({required this.finder, Key? key, required this.post})
      : super(key: key);

  final Post post;
  var finder = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return post.description.contains(finder)
        ? Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage(post.url),
                fit: BoxFit.cover,
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent),
              onPressed: () {
                showCupertinoModalBottomSheet(
                  // expand: false,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => PopUp(
                    post: post,
                  ),
                );
              },
              child: Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    post.description,
                    style: TextStyle(
                        backgroundColor: Colors.white60,
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          )
        : Container(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Text(
              "This picture doesn't match the description.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            )),
          );
  }
}
