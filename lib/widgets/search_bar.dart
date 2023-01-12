import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search/search_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    this.enabled = true,
    this.onTap,
    this.left = 20,
    this.right = 20,
    this.top = 10,
    this.bottom = 10,
  }) : super(key: key);

  final bool enabled;
  final VoidCallback? onTap;
  final double left;
  final double right;
  final double top;
  final double bottom;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.left,
          right: widget.right,
          top: widget.top,
          bottom: widget.bottom),
      child: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          state.when(
            initial: () {
              controller?.clear();
            },
            searching: (query) {
              controller?.text = query;
            },
            loaded: (query, total, skip, limit, products) {
              controller?.text = query;
            },
            error: (query, failure) {
              controller?.text = query;
            },
          );
        },
        child: TextFormField(
          enabled: widget.enabled,
          onTap: widget.onTap,
          controller: controller,
          onFieldSubmitted: (query) {
            context.read<SearchBloc>().add(SearchEvent.search(query));
          },
          onChanged: (query) {
            setState(() {});
          },
          decoration: InputDecoration(
            fillColor: Colors.grey,
            filled: true,
            hintText: "Search...",
            suffixIcon: controller!.text.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      context.read<SearchBloc>().add(const SearchEvent.clear());
                    },
                    icon: const Icon(Icons.clear)),
          ),
        ),
      ),
    );
  }
}
