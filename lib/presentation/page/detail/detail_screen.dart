
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_state.dart';
import 'detail_vm.dart';

class DetailPostPage extends StatefulWidget {
  final int postId;

  DetailPostPage({required this.postId});

  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  @override
  void initState() {
    super.initState();

    // Trigger the API call to fetch the post detail when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailPostViewModel>(context, listen: false)
          .fetchPostDetail(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Consumer<DetailPostViewModel>(
        builder: (context, viewModel, child) {
          final state = viewModel.state;

          if (state is DetailPostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DetailPostError) {
            return Center(child: Text(state.message));
          } else if (state is DetailPostLoaded) {
            final post = state.post;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Title
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Post Body
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              post.body,
                              style: TextStyle(
                                fontSize: 18.0,
                                height: 1.6,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 20.0),
                            Divider(color: Colors.grey),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User ID: ${post.userId}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      'Post ID: ${post.id}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.bookmark_border, color: Colors.teal),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No post found'));
          }
        },
      ),
    );
  }
}