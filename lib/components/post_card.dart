import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Postcard extends StatefulWidget {
  const Postcard({super.key});

  @override
  _PostcardState createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          color: Colors.red,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'hello',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Container(
                color: const Color(0xFF424336),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: SvgPicture.asset(
                          _isLiked ? 'assets/images/like_solid.svg' : 'assets/images/like_outline.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/share-nodes.svg',
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
