import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../infrastructure/models/the_cat_api_response.dart';
import '../widgets/cat_card_widget.dart';

typedef SearchCatCallBack = Future<List<CatData>> Function(String query);

class SearchCatDelegate extends SearchDelegate<dynamic> {
  final SearchCatCallBack searchCat;
  //Stream with timer for prevent multiple calls to the API
  StreamController<List<CatData>> debouncedSearch =
      StreamController.broadcast();
  //Stream for show loading indicator
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchCatDelegate({required this.searchCat});

  void dispose() {
    debouncedSearch.close();
    _debounceTimer?.cancel();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final List<CatData> cats = await searchCat(query);
      debouncedSearch.add(cats);
      isLoadingStream.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'Search by name or breed';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return SpinPerfect(
                duration: const Duration(seconds: 20),
                spins: 15,
                infinite: true,
                child: IconButton(
                    onPressed: () {
                      query = '';
                    },
                    icon: const Icon(Icons.refresh_outlined,
                        color: Colors.black)),
              );
            }
            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                  onPressed: () {
                    query = '';
                  },
                  icon: const Icon(Icons.clear)),
            );
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          dispose();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultsAndSuggestions();
  }

  StreamBuilder<List<CatData>> _buildResultsAndSuggestions() {
    return StreamBuilder(
      stream: debouncedSearch.stream,
      initialData: const <CatData>[],
      builder: (context, snapshot) {
        final List<CatData> cats = snapshot.data ?? [];

        return cats.isNotEmpty
            ? GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                itemCount: cats.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemBuilder: (context, index) {
                  return CardWidget(index: index, catData: cats);
                })
            : const Center(child: Text('No results'));
      },
    );
  }
}
