import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class PostController extends GetxController {
  var posts = [].obs; // Observable list for posts
  var filteredPosts = [].obs; // Observable list for filtered posts
  var isLoading = true.obs; // Loading state

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  // Fetch data from API
  Future<void> fetchPosts() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      posts.assignAll(data);
      filteredPosts.assignAll(data);
      isLoading(false); // Set loading to false after data is fetched
    } else {
      Get.snackbar('Error', 'Failed to load data');
    }
  }

  // Filter posts based on user input
  void filterPosts(String query) {
    if (query.isEmpty) {
      filteredPosts.assignAll(posts);
    } else {
      filteredPosts.assignAll(posts.where((post) =>
          post['title'].toLowerCase().contains(query.toLowerCase())));
    }
  }
}
