import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:huepoint/components/explore_card.dart';
// import 'package:huepoint/components/markert_card.dart';s

class Explorescreen extends StatelessWidget {
  const Explorescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBarWidget(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Number of columns
              mainAxisSpacing: 10.0, // Space between rows
              crossAxisSpacing: 10.0, // Space between columns
              padding: EdgeInsets.all(10.0), // Padding around the grid
              children: List.generate(20, (index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
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
    final query = _controller.text;
    print(query);
    // Add your search logic here
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onSubmitted: (value) => _performSearch(),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/images/search-bars.svg'),
              onPressed: _performSearch,
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}
