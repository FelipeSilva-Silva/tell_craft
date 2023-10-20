import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tell_craft/components/slide_carousel.dart';
import 'package:tell_craft/features/text_generator/chat_page.dart';
import 'package:tell_craft/features/generator_new_history.dart';
import 'package:tell_craft/features/setting/setting_page.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tell_craft/models/chat_model.dart';

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

  final int indexImages = 0;

  final auth = FirebaseAuth.instance;
  final CollectionReference reviewsCollection =
      FirebaseFirestore.instance.collection('story');

  Future<List<QueryDocumentSnapshot<Object?>>?> _getUserStories() async {
    List<QueryDocumentSnapshot<Object?>> matchingDocs = [];

    try {
      final user = auth.currentUser;
      final userEmail = user!.email;

      CollectionReference storyCollection =
          FirebaseFirestore.instance.collection('story');

      // Realize uma consulta para encontrar todos os documentos dentro da coleção "story"
      QuerySnapshot querySnapshot = await storyCollection.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Acesse a lista no subdocumento
        dynamic data = doc.data();
        List<dynamic> lista =
            (data != null && data[doc.id] is List) ? data[doc.id] : [];

        // Verifique cada item na lista para encontrar correspondências com o campo 'email'
        for (var item in lista) {
          if (item['email'] == userEmail) {
            matchingDocs.add(doc);
            break; // Se encontrar um email correspondente, pare de verificar este documento
          }
        }
      }

      return matchingDocs;
    } catch (e) {
      print('Erro na consulta: $e');
    }
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ));
            },
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
                    builder: (context) => const GeneratorHistoryPage()));
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
                      return const Center(child: CircularProgressIndicator());
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

                          print(story.entries);

                          List<ChatModel> chatModelList = [];

                          story.forEach((id, chatList) {
                            if (chatList is List) {
                              chatList.forEach((chatData) {
                                if (chatData is Map) {
                                  Map<String, dynamic> chatDataCasted =
                                      chatData.cast<String, dynamic>();
                                  ChatModel chatModel =
                                      ChatModel.fromJson(chatDataCasted);
                                  chatModelList.add(chatModel);
                                }
                              });
                            }
                          });

                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            id: stories[index].id,
                                            title: '',
                                            chat: chatModelList,
                                          )))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              elevation: 4.0,
                              child: ListTile(
                                title: Text(
                                  "Historia ${index.toString()}",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GeneratorHistoryPage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
