import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String description;
  final List<String> images; // Mengganti List<File> dengan List<String> untuk URL gambar

  const DetailPage({
    Key? key,
    required this.description,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 0.6,
                  child: images.isNotEmpty
                      ? Image.network(
                          images[0],
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey,
                          child: const Center(
                            child: Text('No Image'),
                          ),
                        ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
