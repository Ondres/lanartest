import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../posts.dart';

part 'post_event.dart';

part 'post_state.dart';

const _uniqKey =
    'https://api.unsplash.com/photos/?client_id=p_aW-TLSlKPyLtXGnR3nuXrWtzuc4VhONYYsG_pR1wE';
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.dio}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  var dio = Dio();

  _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }

      final posts = await _fetchPosts();
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (e) {
      print(e);
      print("catch some error");
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  _fetchPosts() async {
    List<Post> list = [];
    final response1 = await dio.get(_uniqKey);
    print("response.statusCode is " + response1.statusCode.toString());
    if (response1.statusCode == 200) {
      final body = response1.data as List;
      for (int i = 0; i < body.length; i++) {
        list.add(Post(
          description: body[i]['alt_description'] ?? 'None',
          url: body[i]['urls']['full'] ??
              'https://images.unsplash.com/photo-1679772692716-109397c09bd6?crop=entropy&cs=srgb&fm=jpg&ixid=Mnw0Mjg4Nzl8MHwxfGFsbHw0fHx8fHx8Mnx8MTY4MDA4OTkwMA&ixlib=rb-4.0.3&q=85',
        ));
      }
      return list;
    }
    throw Exception('error fetching posts');
  }
}
