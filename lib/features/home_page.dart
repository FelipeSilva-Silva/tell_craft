import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tell_craft/components/slide_carousel.dart';
import 'package:tell_craft/features/text_generator/chat_page.dart';
import 'package:tell_craft/features/text_generator/text_generator_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

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

  final auth = FirebaseAuth.instance;
  final CollectionReference reviewsCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<QueryDocumentSnapshot<Object?>>?> _getUserStories() async {
    final user = auth.currentUser;
    if (user != null) {
      final userEmail = user
          .email; // Obtenha o e-mail do usuário pq tá salvando o email em user
      final querySnapshot = await reviewsCollection
          .where('email',
              isEqualTo:
                  userEmail) // Consulta para encontrar o documento do usuário pelo e-mail
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userId = querySnapshot.docs.first.id;
        final storiesSnapshot =
            await reviewsCollection.doc(userId).collection('stories').get();
        return storiesSnapshot.docs;
      }
    }
    // O usuário não está autenticado ou não possui histórias, retorne uma lista vazia
    return null;
  }

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
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TextGenerator(
                          text: _listTexts[indexImages],
                          title: 'Nova Historia',
                        )));
              },
              child: SizedBox(
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
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.history),
                SizedBox(width: 5),
                Text(
                  "Suas Histórias",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Scaffold(
                body: FutureBuilder(
                  future:
                      _getUserStories(), // Use a função para buscar as histórias do usuário
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Erro: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhuma história encontrada.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    } else {
                      // Se houver avaliações, mostre a lista
                      List<QueryDocumentSnapshot<Object?>> stories =
                          snapshot.data as List<QueryDocumentSnapshot<Object?>>;
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Duas colunas
                        ),
                        itemCount: stories.length,
                        itemBuilder: (context, index) {
                          var story =
                              stories[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                        text: _listTexts[indexImages],
                                        title: story['title'],
                                      )));
                            },
                            child: Card(
                              margin: const EdgeInsets.all(
                                  8.0), // Espaçamento ao redor do Card
                              elevation:
                                  4.0, // Elevação para dar uma sombra ao Card
                              child: ListTile(
                                title: Text(
                                  story[
                                      'title'], // Substitua 'title' pelo campo apropriado que armazena o título da história
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
