import 'package:flutter/material.dart';
import 'package:flutter_app/features/movies/bloc/movies_bloc.dart';
import 'package:flutter_app/features/movies/bloc/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movies_event.dart';

class MoviesSearchWidget extends StatefulWidget {
  const MoviesSearchWidget({super.key, required this.initValue});

  final String initValue;

  @override
  State<MoviesSearchWidget> createState() => _MoviesSearchWidgetState();
}

class _MoviesSearchWidgetState extends State<MoviesSearchWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    if (_textController.text != widget.initValue) {
      _textController.value = _textController.value.copyWith(
        text: widget.initValue,
        selection: TextSelection(
          baseOffset: widget.initValue.length,
          extentOffset: widget.initValue.length,
        ),
        composing: TextRange.empty,
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocListener<MoviesBloc, MoviesState>(
      listenWhen:
          (previous, current) => previous.searchText != current.searchText,
      listener: (BuildContext context, MoviesState state) {},
    );

    return TextField(
      controller: _textController,
      onChanged: (value) {
        context.read<MoviesBloc>().add(
          MoviesSearchTextChangedEvent(searchText: value),
        );
      },
      decoration: InputDecoration(
        hintText: "Type something...",
        prefixIcon: Icon(Icons.search),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
