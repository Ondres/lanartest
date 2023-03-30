import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../posts.dart';

final _controller = CarouselController();
var textController = new TextEditingController();

class CarouselSlide extends StatelessWidget {
  CarouselSlide({required this.posts, Key? key}) : super(key: key);

  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 30,
          child: TextField(
            onChanged: (value) {
              print(textController.text);
            },
            controller: textController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.transparent,
          child: CarouselSlider.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, index, realIdx) {
              return PostListItem(post: posts[index], finder: textController.text);
            },
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: false,
              disableCenter: true,
              height: MediaQuery.of(context).size.height * 0.8,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
            ),
          ),
        )
      ],
    );
  }
}
