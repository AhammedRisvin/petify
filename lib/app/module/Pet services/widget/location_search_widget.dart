import 'dart:async';
import 'dart:convert';

import 'package:clan_of_pets/app/module/Dating/view/location_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.onTap,
    required this.node,
  });

  final Function(String id, String placeName) onTap;
  final FocusNode node;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<PlaceSuggestion> suggestions = [];
  final searchCont = TextEditingController();
  bool isSearching = false;
  bool isFullScreen = false;

  String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';

  Future<void> fetchSuggestions(String query) async {
    setState(() {
      isSearching = true;
    });
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&components=country:IN&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      suggestions.clear();
      for (var item in data['predictions']) {
        final suggestionsList = PlaceSuggestion(
          name: item['description'],
          placeId: item['place_id'],
        );
        suggestions.add(suggestionsList);
      }
    } else {
      suggestions.clear();
    }
    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isFullScreen
          ? MediaQuery.of(context).size.height
          : Responsive.height * 20,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppConstants.transparent,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFullScreen ? 0 : 16),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppConstants.black10,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              focusNode: widget.node,
              onTapOutside: (_) {
                widget.node.unfocus();
              },
              onTap: () {
                setState(() {
                  isFullScreen = true;
                });
              },
              onChanged: (value) => fetchSuggestions(value),
              controller: searchCont,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                filled: true,
                hintText: 'Search',
                fillColor: AppConstants.transparent,
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: AppConstants.appPrimaryColor,
                ),
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.black,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppConstants.black40,
                  ),
                  onPressed: () {
                    searchCont.clear();
                    suggestions.clear();
                    setState(() {});
                    if (searchCont.text.isEmpty) {
                      widget.onTap('', '');
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: isSearching
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = suggestions[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundColor:
                              AppConstants.appPrimaryColor.withOpacity(0.1),
                          radius: 16.0,
                          child: const Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                        ),
                        title: Text(suggestion.name),
                        onTap: () {
                          widget.node.unfocus();
                          widget.onTap(suggestion.placeId, suggestion.name);
                          setState(() {
                            isFullScreen = false;
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
