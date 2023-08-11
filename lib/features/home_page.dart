import 'package:flutter/material.dart';
import 'package:tell_craft/components/slide_carousel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _list = [
    'assets/images/Carousel1.png',
    'assets/images/Carousel2.png',
    'assets/images/Carousel3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logoTitle.png'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline_sharp,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: PageView.builder(
                itemCount: _list.length,
                itemBuilder: (_, index) {
                  return SlideCarousel(
                    image: _list[index],
                  );
                },
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
