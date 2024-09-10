import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/post_controller.dart';

class MyHomePage extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  MyHomePage({super.key}); // Inject GetX controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Alterixx Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: postController.fetchPosts,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: postController.filterPosts, // Bind search to GetX controller
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search by title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          Obx(() {
            if (postController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: postController.filteredPosts.length,
                  itemBuilder: (context, index) {
                    final post = postController.filteredPosts[index];
                    return ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        post['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'User ID: ${post['userId']}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            post['body'],
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () {
                        // Handle tap
                      },
                    );

                  },
                ),
              );
            }
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showConfirmationDialog,
        tooltip: 'Confirm Action',
        child: const Icon(Icons.check),
      ),
    );
  }

  void _showConfirmationDialog() {
    Get.defaultDialog(
      title: 'Confirmation',
      middleText: 'Do you want to proceed?',
      textCancel: 'Cancel',
      textConfirm: 'Proceed',
      onConfirm: () {
        Get.back();
      },
    );
  }
}