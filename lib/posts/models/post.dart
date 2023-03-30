import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({required this.description, required this.url});

  final String url;
  final String description;

  @override
  List<Object> get props => [url, description];
}

