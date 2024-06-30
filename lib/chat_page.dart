import 'package:flutter/material.dart';
import 'package:aplikasi_wisata_c/profile_page.dart'; // Impor ProfilePage
import 'package:aplikasi_wisata_c/data/user.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({Key? key, required this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Wisata.App"),
        actions: [
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 18, 18, 219),
                    child: Icon(Icons.person),
                  ),
                  title: Text(messages[index]), // Tampilkan pesan komentar
                  subtitle: Text('11:00 AM'), // Waktu pesan, bisa diganti dengan waktu sebenarnya
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Kontak',
          ),
        ],
        currentIndex: 0, // This assumes 'Pesan' tab is selected
        onTap: (int index) {
          if (index == 0) {
            // Tidak perlu ada perubahan, tetap di halaman Pesan
          } else if (index == 1) {
            Navigator.pop(context); // Go back to previous page (Homepage)
          } else if (index == 2) {
            // Logika untuk tab 'Kontak' jika ada halaman kontak yang spesifik
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => KontakPage(user: widget.user),
            //   ),
            // );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Contoh pesan awal, bisa dihapus jika tidak dibutuhkan
    messages.add('Halo, ada yang bisa dibantu?');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
