import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';

import '../models/link.dart';
import '../models/user.dart';
import 'add_link.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;
  late String data;
  late double size;
  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        actions: const [
          Icon(
            Icons.search_outlined,
            size: 32,
          ),
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.qr_code,
            size: 32,
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 42,
          // ),
          FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(18, 42, 0.0, 8),
                  child: Text(
                    'Hello, ${snapshot.data?.user?.name}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return const Text('loading');
            },
          ),
          IconButton(
            icon: const Icon(
              IconData(
                0xf00cc,
                fontFamily: 'MaterialIcons',
              ),
              size: 400,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          const Divider(
            height: 12,
            thickness: 1,
            endIndent: 90,
            indent: 90,
            color: Colors.black,
          ),
          FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: snapshot.data!.length + 1,
                    padding: const EdgeInsets.all(12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        if (index < snapshot.data!.length) {
                          // print('$index');
                           print('>>>>>>>> ${snapshot.data?[index].username}');

                          final link = snapshot.data?[index].title;
                          return Container(
                            padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFE6A6),
                                borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              child: Column(
                                children: [
                                  Text(
                                    '$link',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff784E00),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    
                                    '${snapshot.data?[index].username}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff784E00),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (index == snapshot.data!.length) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                            decoration: BoxDecoration(
                                color: const Color(0xffE7E5F1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const addLink();
                                    }));
                                  },
                                  icon: const Icon(
                                    color: Color(0xff2D2B4E),
                                    Icons.add,
                                    size: 32,
                                  ),
                                ),
                                const Text(
                                  'Add More',
                                  style: TextStyle(
                                    color: Color(0xff2D2B4E),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 12,
                      );
                    },
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Text('loading');
            },
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
