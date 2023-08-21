import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 234, 248, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 234, 248, 255),
      body: Container(
        height: size.height,
        width: size.width,
        child: Image.network(imageUrl),
      ),
    );
  }
}