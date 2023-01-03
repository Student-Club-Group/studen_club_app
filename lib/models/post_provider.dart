import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'post.dart';

enum StatusOfPosts {
  fetched,
  loading,
  notFetched,
}

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];

  StatusOfPosts state = StatusOfPosts.notFetched;

  final postsRef = FirebaseFirestore.instance.collection("posts").withConverter(
        fromFirestore: Post.fromJson,
        toFirestore: (Post post, _) => post.toJson(),
      );

  fetchPosts(List<String> clubs) async {
    print('inside');
    List<Post> cloudPosts = [];
    var result = await postsRef.where("club", whereIn: clubs).get();
    print('got it');
    var newResult = result.docs;
    for (var query in newResult) {
      cloudPosts.add(query.data());
    }
    print('hello');
    _posts = cloudPosts;
    state = StatusOfPosts.fetched;
    notifyListeners();
  }

  List<Post>? get posts => _posts;
}
