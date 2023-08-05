import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/models/follower.dart';

import '../models/user.dart';

class FollowerUsers extends StatefulWidget {
  final List<Follow> users;
  const FollowerUsers({super.key, required this.users});

  @override
  State<FollowerUsers> createState() => _FollowerUsersState();
}

class _FollowerUsersState extends State<FollowerUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'FOLLOWERS',
          style: TextStyle(
              color: Color(0xff2D2B4E),
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.users.length,
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
                          widget.users[index].name,
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
                          widget.users[index].email,
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
        ],
      ),
    );
  }
}
