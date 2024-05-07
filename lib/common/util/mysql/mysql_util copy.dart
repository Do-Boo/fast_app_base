import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _controller = TextEditingController();
  Future<List<Map>>? _searchResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Search',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _searchResult = _search(_controller.text);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: _searchResult == null
              ? Container()
              : FutureBuilder<List<Map>>(
                  future: _searchResult,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: snapshot.data!.map((item) => Text(item['roomName'])).toList(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                ),
        ),
      ],
    );
  }
}
