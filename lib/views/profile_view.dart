import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/models/follower.dart';
import 'package:tt9_betweener_challenge/views/edit_link.dart';
import 'package:tt9_betweener_challenge/views/edit_profile.dart';
import 'package:tt9_betweener_challenge/views/home_view.dart';
// import '../constants.dart';
import '../controllers/add_follwer.dart';
import '../controllers/delete_link.dart';
import '../controllers/link_controller.dart';
import '../controllers/user_controller.dart';
import '../models/link.dart';
import '../models/user.dart';
import 'add_link.dart';
import 'login_view.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<User> user;
  late Future<Followings> follower;

  late Future<List<Link>> links;
  @override
  void initState() {
    user = getLocalUser();
    follower = getFollow(context);
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeView.id);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 28,
            color: Color(0xff2D2B4E),
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xff2D2B4E),
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2D2B4E),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 90,
                        height: 120,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/imgs/download.jfif'),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              FutureBuilder(
                                future: user,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      '${snapshot.data?.user?.name}',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                  return const Text('loading');
                                },
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              IconButton(
                                onPressed: () async {
                                  print('awaait');
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const EditProfile();
                                  })).then((value) => null);
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 30,
                                ),
                                color: Colors.white,
                              )
                            ],
                          ),
                          FutureBuilder(
                            future: user,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  '${snapshot.data?.user?.email}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return const Text('loading');
                            },
                          ),
                          const Text(
                            '972592864781',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              FutureBuilder(
                                  future: follower,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }
                                    if (snapshot.hasData) {
                                      return TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 18),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color(0xffFFD465),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'follower: ${snapshot.data!.followersCount}',
                                          style: const TextStyle(
                                              color: Color(0xff2D2B4E)),
                                        ),
                                      );
                                    }
                                    return const Text('loading');
                                  }),
                              const SizedBox(
                                width: 4,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 18,
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color(0xffFFD465),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'following: 0',
                                  style: TextStyle(
                                    color: Color(0xff2D2B4E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      padding: const EdgeInsets.only(left: 12),
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          final link = snapshot.data?[index].title;
                          return Slidable(
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  SlidableAction(
                                    flex: 2,
                                    onPressed: (context) async {
                                      print('update');
                                      await Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return EditLink(
                                            idlink: snapshot.data?[index].id);
                                      }));
                                      // setState(() {
                                      //   getLinks(context);
                                      // });
                                    },
                                    foregroundColor: Colors.white,
                                    autoClose: true,
                                    icon: Icons.edit,
                                    backgroundColor: const Color(0xffFFD465),
                                    borderRadius: BorderRadius.circular(15),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SlidableAction(
                                    flex: 2,
                                    autoClose: true,
                                    onPressed: (context) {
                                      deleteLink(snapshot.data?[index].id)
                                          .then((value) {
                                        print('delte await');
                                        print(links);
                                        setState(() {
                                          links=getLinks(context);
                                        });
                                      });
                                    },
                                    icon: Icons.delete_outline_outlined,
                                    backgroundColor: const Color(0xffF56C61),
                                    borderRadius: BorderRadius.circular(15),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                ]),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(24, 24, 80, 24),
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? const Color(0xffFEE2E7)
                                      : const Color(0xffE7E5F1),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$link',
                                    style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: index % 2 == 0
                                          ? const Color(0xff783341)
                                          : const Color(0xff2D2B4E),
                                    ),
                                  ),
                                  Text(
                                    'https://www.instagram.com/a7medhq/',
                                    style: TextStyle(
                                      color: index % 2 == 0
                                          ? const Color(0xff9B6A73)
                                          : const Color(0xff807D99),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
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
              height: 8,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff2D2B4E),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const addLink();
          }));
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
