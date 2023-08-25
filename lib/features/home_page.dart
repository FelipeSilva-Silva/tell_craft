import 'package:flutter/material.dart';
import 'package:tell_craft/components/slide_carousel.dart';
import 'package:tell_craft/features/text_generator/text_generator_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// pegar da api depois
final List<String> _recentStories = [
  'História 1',
  'História 2',
  'História 3',
  'História 4',
  'História 5',
  'Historia 6'
];

class _HomeState extends State<Home> {
  final List<String> _listImages = [
    'assets/images/Carousel1.png',
    'assets/images/Carousel2.png',
    'assets/images/Carousel3.png',
  ];

  final List<String> _listTexts = [
    'Embarque em uma fantasia',
    'Embarque em uma distopia futurística',
    'Embarque em uma odisseia no espaço',
  ];

  final int indexImages = 0;

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
      body: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TextGenerator(
                    text: _listTexts[indexImages],
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: PageView.builder(
                  itemCount: _listImages.length,
                  itemBuilder: (_, indexImages) {
                    return SlideCarousel(
                      image: _listImages[indexImages],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Icon(Icons.history),
                  SizedBox(width: 5),
                  Text("Suas Histórias"),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: _recentStories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        color: const Color(0xFF24262E),
                        height:
                            50, // arranjar um jeito pra diminuir o tamanho do quadrado
                        child: Center(
                          child: Text(
                            _recentStories[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
