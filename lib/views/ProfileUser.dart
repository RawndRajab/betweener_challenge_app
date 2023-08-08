import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/controllers/add_follow_cont.dart';

import 'package:tt9_betweener_challenge/views/home_view.dart';

// import '../models/link.dart';
import '../controllers/get_follow.dart';
import '../models/follower.dart';
import '../models/search.dart' as searchh;
// import '../models/user.dart';

class ProfileUser extends StatefulWidget {
  static String id = '/profileUser';
  final searchh.User searchInfo;
  const ProfileUser({super.key, required this.searchInfo});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  Future<bool>? isAdd;
  late Future<Followings> follow;
  Future<Followings> followw(){
    follow = getFollow(context);
return follow;
  }
  @override
  void initState() {
  //  print('${follow}');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('info-----');
    print(widget.searchInfo);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeView();
            }));
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
      body: Column(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.searchInfo.name!,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                          ],
                        ),
                        Text(
                          widget.searchInfo.email!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          '972592864781',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        FutureBuilder(
                            future: followw(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List follwinng = snapshot.data!.following;
                                  print(snapshot.data!.following  );

                                for (int i = 1; i < follwinng.length; i++) {
                                  print('in loooop');
                                  if (widget.searchInfo.id ==
                                      follwinng[i]['id']) {
                                    print("$i test ${widget.searchInfo.name}");
                                    return const Text('FOLLOWINg');
                                  }
                                }
                                return TextButton(
                                  onPressed: () {
                                    print('succcesss');
                                    Map<String, String?> body = {
                                      'followee_id':
                                          widget.searchInfo.id.toString()
                                    };
                                    setState(() {
                                      // print('add');
                                      isAdd = AddFollow(body);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFD465),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      'ADD FOLLOW',
                                      style: const TextStyle(
                                          color: Color(0xff2D2B4E)),
                                    ),
                                  ),
                                );
                                print('end for');
                              }
                              print('testttt');

                              if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              return const Text('loading');
                            }),
                        // TextButton(
                        //   onPressed: () {
                        //     print('succcesss');
                        //     Map<String, String?> body = {
                        //       'followee_id': widget.searchInfo.id.toString()
                        //     };

                        //     setState(() {
                        //       print('add');
                        //       isAdd = AddFollow(body);
                        //     });
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //       color: const Color(0xffFFD465),
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //     child: Text(
                        //       'ADD FOLLOW',
                        //       style: const TextStyle(color: Color(0xff2D2B4E)),
                        //     ),
                        //   ),
                        // ),
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
          Expanded(
            child: ListView.separated(
              itemCount: widget.searchInfo.links!.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                // final link = snapshot.data?[index].title;
                return Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 80, 24),
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? const Color(0xffFEE2E7)
                          : const Color(0xffE7E5F1),
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.searchInfo.links![index].title}',
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
                          '${widget.searchInfo.links![index].link}',
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
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
