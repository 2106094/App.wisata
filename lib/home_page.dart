import 'package:flutter/material.dart';
import 'package:aplikasi_wisata_c/data/add_status.dart';
import 'package:aplikasi_wisata_c/data/comments_page.dart';
import 'data/user.dart';
import 'profile_page.dart'; // Import ProfilePage
import 'data/add_status.dart'; // Import AddStatusPage
import 'detail_page.dart';
import 'chat_page.dart';

class Homepage extends StatefulWidget {
  final User user;

  const Homepage({Key? key, required this.user}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> _statuses = [];
  int _selectedIndex = 0; // Add currentIndex to track the selected tab

  // Add _onItemTapped to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different pages based on the selected index
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatPage(user: widget.user)),
      );
    } else if (index == 1) {
      // Stay on the homepage, no need to navigate
    } else if (index == 2) {
      // Handle the 'Kontak' tab, if there's a specific page for it, navigate there
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => KontakPage(user: widget.user)),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Wisata.App"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo_rounded),
            onPressed: () async {
              final newStatus = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStatusPage(user: widget.user),
                ),
              );

              if (newStatus != null) {
                setState(() {
                  _statuses.add(newStatus);
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(user: widget.user),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _statuses.length,
        itemBuilder: (_, index) {
          final status = _statuses[index];
          final user = status['user'] as User;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    description: status['description'],
                    images: status['images'],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(status['images'][0]),
                          radius: 25,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                user.name,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      status['images'][0],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      status['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        const FavoriteIcon(),
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CommentsPage(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Set current index
        onTap: _onItemTapped, // Handle tab changes
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Tambah Teman',
          ),
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({Key? key}) : super(key: key);

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: isFavorited ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              isFavorited = !isFavorited;
            });
          },
        ),
        Text(isFavorited ? "101" : "100"),
      ],
    );
  }
}
