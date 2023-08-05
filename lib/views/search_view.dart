import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import '../controllers/search_cont.dart';
import '../models/search.dart';
import 'ProfileUser.dart';

class SearchView extends StatefulWidget {
  static String id = '/searchView';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Future<Search>? searchFuture;

  TextEditingController searchController = TextEditingController();
  late String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: TextFormField(
                onFieldSubmitted: (value) {
                  print('setstate');
                  print('value   == $value');

                  searchQuery = value;
                  Map<String, dynamic> searchParams = {'name': searchQuery};
                  setState(() {
                    searchFuture = searchUsersByName(searchParams);
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  labelText: 'search',
                ),
                controller: searchController,
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<Search>(
              future: searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error: ${snapshot.error}')); // Display the error message
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found.'));
                } else {
                  Search searchResults = snapshot.data!;
                  return ListView.builder(
                    itemCount: searchResults.user!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print('clickkkkkkk');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfileUser(
                              searchInfo: snapshot.data!.user![index],
                            );
                          }));
                        },
                        child: Container(
                          child: ListTile(
                            title: Text('${snapshot.data!.user![index].name}'),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
