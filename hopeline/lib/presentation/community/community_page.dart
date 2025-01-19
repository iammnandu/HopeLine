import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommunityPost {
  final String userName;
  final String content;
  final String timeAgo;
  final int likes;
  final int comments;
  final String userAvatar;

  CommunityPost({
    required this.userName,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.userAvatar,
  });
}

class WellnessHubCommunity extends StatefulWidget {
  @override
  _WellnessHubCommunityState createState() => _WellnessHubCommunityState();
}

class _WellnessHubCommunityState extends State<WellnessHubCommunity> {
  final List<String> categories = ['Trending', 'Relationship', 'Self Care'];
  String selectedCategory = 'Trending';
  final TextEditingController _messageController = TextEditingController();
  
  final List<CommunityPost> posts = [
    CommunityPost(
      userName: 'Unnikannnan',
      content: "How's everyone feeling today? Remember to take care of yourself!",
      timeAgo: 'just now',
      likes: 2,
      comments: 0,
      userAvatar: 'assets/avatars/user1.png',
    ),
    CommunityPost(
      userName: 'Aaratannan',
      content: "Hey! I noticed you're doing great with your progress. Want to share some of the things that helped you along the way?",
      timeAgo: '3 hrs ago',
      likes: 12,
      comments: 2,
      userAvatar: 'assets/avatars/user2.png',
    ),
    // Add more sample posts
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildHeader(),
          _buildCategories(),
          Expanded(
            child: _buildPostsList(),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: () => _showNewPostDialog(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.favorite, color: Colors.white),
          ),
          SizedBox(width: 12),
          Text(
            'Wellness Hub',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: selectedCategory == categories[index],
              onSelected: (selected) {
                setState(() {
                  selectedCategory = categories[index];
                });
              },
              backgroundColor: Colors.white,
              selectedColor: Colors.deepOrange,
              labelStyle: TextStyle(
                color: selectedCategory == categories[index]
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(post.userAvatar),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          post.timeAgo,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(post.content),
                SizedBox(height: 12),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up_outlined, size: 16),
                          SizedBox(width: 4),
                          Text('${post.likes}'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.comment_outlined, size: 16),
                          SizedBox(width: 4),
                          Text('${post.comments}'),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  void _showNewPostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Post'),
        content: TextField(
          controller: _messageController,
          decoration: InputDecoration(
            hintText: 'What\'s on your mind?',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Post'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
            ),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                setState(() {
                  posts.insert(
                    0,
                    CommunityPost(
                      userName: 'You',
                      content: _messageController.text,
                      timeAgo: 'just now',
                      likes: 0,
                      comments: 0,
                      userAvatar: 'assets/avatars/default.png',
                    ),
                  );
                });
                _messageController.clear();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}