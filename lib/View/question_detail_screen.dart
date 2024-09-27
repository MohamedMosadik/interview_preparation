import 'package:flutter/material.dart';

class QuestionDetailsScreen extends StatefulWidget {
  QuestionDetailsScreen({super.key, this.questionsDetails});

  dynamic questionsDetails;

  @override
  State<QuestionDetailsScreen> createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  double _width = 0;
  double _height = 0;
  late Color _color;

  double opacityLevel = 1.0;
  void _changeOpacity() {
    setState(() => opacityLevel = 0.0);
  }

  @override
  void initState() {
    super.initState();
    _color = widget.questionsDetails.level == "easy"
        ? Colors.yellow
        : widget.questionsDetails.level == "medium"
            ? Colors.green
            : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.questionsDetails.level + " Question",
          style: TextStyle(),
        ),
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(children: [
          Hero(
              tag: widget.questionsDetails.id,
              child: Text(
                widget.questionsDetails.questions,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 28, fontWeight: FontWeight.w500),
              )),
          AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: _width,
              height: _height,
              // color: _color,
              child: Center(
                child: Text(
                  widget.questionsDetails.answer,
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              )),
        ]),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          _changeOpacity();
          // Change the color and size of the container on tap
          setState(() {
            _color = Colors.transparent;
            _width = MediaQuery.of(context).size.width;
            _height = MediaQuery.of(context).size.height * 0.4;
          });
        },
        child: AnimatedOpacity(
            opacity: opacityLevel,
            duration: const Duration(seconds: 3),
            child: Container(
                padding: EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                    color: _color, borderRadius: BorderRadius.circular(24)),
                child: Text("Show Me Answer"))),
      ),
    );
  }
}
