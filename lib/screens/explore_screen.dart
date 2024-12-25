import 'package:flutter/material.dart';

class Explorescreen extends StatelessWidget {
  const Explorescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchBarWidget(),
        Text('Trending'),
        Text('Categories'),
        Text('For you'),
      ],
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _performSearch() {
    // final query = _controller.text;
    // Add your search logic here
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              // onSubmitted: (value) => _performSearch(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _performSearch,
          ),
        ],
      ),
    );
  }
}
