import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/WeatherViewModel.dart';

class CustomSearchDelegate extends SearchDelegate {
  final BuildContext parentContext; // Store the parent context

  CustomSearchDelegate({required this.parentContext});
  List<String> searchTerms = [
    'Dhaka',
    'Brahmanbaria',
    'Sylhet',
    'Noakhali',
    'Cumilla',
    'Chittagong',
    'Barisal',
    'Chennai',
    'Kolkata',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Build result = $query');
    final queryString = query.toLowerCase();

    if (queryString.isNotEmpty) {
      // Wrap this in a try-catch to catch any exceptions
      try {
        var viewModel = Provider.of<WeatherViewModel>(parentContext);
        viewModel.addNewCity(queryString);
        close(context, queryString);
      } catch (error) {
        print("Error: $error");
        // Handle the error gracefully, maybe show a snackbar or log the issue
      }
    } else {
      close(context, null);
    }

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Use watch here to listen for updates and rebuild suggestions when data changes
    var viewModel = Provider.of<WeatherViewModel>(parentContext);

    final searchTerms = viewModel.favoriteCities;
    print('city count = ${searchTerms.length}');
    List<String> matchQuery = [];
    for (var city in searchTerms) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            close(context, result);
          },
        );
      },
    );
  }
}
