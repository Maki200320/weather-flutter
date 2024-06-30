import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Function(String) onTextChanged;

  CustomAppBar({required this.onTextChanged});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double iconSize = IconTheme.of(context).size ?? 24.0;

    return AppBar(
      backgroundColor: Color.fromRGBO(7, 40, 84, 0.5),
      leading: IconButton(
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        iconSize: iconSize,
        onPressed: () {},
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: TextField(
          controller: _textEditingController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.only(top: 30.0),
          ),
          textAlign: TextAlign.start,
          onChanged: widget.onTextChanged,
        ),
      ),
      actions: [
        if (_textEditingController.text.isNotEmpty)
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _textEditingController.clear();
                widget.onTextChanged('');
              });
            },
          ),
      ],
    );
  }
}
