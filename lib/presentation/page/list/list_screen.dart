import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/presentation/page/create/create_screen.dart';
import '../../../data/models/remote_model.dart';
import '../detail/detail_screen.dart';
import 'list_state.dart';
import 'list_vm.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostListViewModel>(context, listen: false).fetchPosts();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final viewModel = Provider.of<PostListViewModel>(context, listen: false);
      if (!viewModel.isLoadingMore) {
        viewModel.loadMorePosts();
      }
    }
  }

  Future<void> _refreshPosts() async {
    final viewModel = Provider.of<PostListViewModel>(context, listen: false);
    await viewModel.fetchPosts(); // Re-fetch the posts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _showCreateOrUpdateScreen(context);
        },
      ),
      body: Consumer<PostListViewModel>(
        builder: (context, viewModel, child) {
          final state = viewModel.state;

          if (state is PostListLoading && viewModel.posts.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostListDeleting) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostListError && viewModel.posts.isEmpty) {
            return Center(child: Text(state.message));
          } else if (state is PostListLoaded || state is PostListLoading) {
            return RefreshIndicator(
              onRefresh: _refreshPosts, // Swipe to refresh
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: viewModel.posts.length + (viewModel.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == viewModel.posts.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final post = viewModel.posts[index];
                  return PostListItem(
                    post: post,
                    onUpdate: (post) {
                      // Handle update logic
                      _showUpdateDialog(context, post);
                    },
                    onDelete: (post) {
                      // Handle delete logic
                      _showDeleteDialog(context, post);
                    },
                    onTap: (post) {
                      // Handle tap logic, e.g., navigate to details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPostPage(postId: post.id),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('No posts found'));
          }
        },
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, RemoteModel post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Post'),
          backgroundColor: Colors.white,
          content: Text('Do you want to update this post?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.teal)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update', style: TextStyle(color: Colors.teal)),
              onPressed: () {
                // Handle the update logic here
                Navigator.of(context).pop();
                _showCreateOrUpdateScreen(context, post: post);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, RemoteModel post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Post'),
          backgroundColor: Colors.white,
          content: Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.teal),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.teal)),
              onPressed: () {
                Provider.of<PostListViewModel>(context, listen: false).deletePost(post);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCreateOrUpdateScreen(BuildContext context, {RemoteModel? post}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This allows the bottom sheet to be resizable
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (context) => Padding(padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom
      ), child: CreateScreen(existingPost: post)),
    );
  }
}

class PostListItem extends StatelessWidget {
  final RemoteModel post;
  final Function(RemoteModel) onUpdate;
  final Function(RemoteModel) onDelete;
  final Function(RemoteModel) onTap;

  PostListItem({
    required this.post,
    required this.onUpdate,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => onTap(post),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      post.body,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'Update') {
                    onUpdate(post);
                  } else if (value == 'Delete') {
                    onDelete(post);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Update', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }
}