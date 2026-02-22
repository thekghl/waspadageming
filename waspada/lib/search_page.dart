import 'dart:async';
import 'package:flutter/material.dart';
import '../models/location_result.dart';
import '../services/geocoding_service.dart';
import '../services/recent_searches_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<LocationResult> _searchResults = [];
  List<LocationResult> _recentSearches = [];
  bool _isLoading = false;
  bool _isLoadingRecent = true;
  Timer? _debounce;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final recent = await RecentSearchesService.getRecentSearches();
    if (mounted) {
      setState(() {
        _recentSearches = recent;
        _isLoadingRecent = false;
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _errorMessage = null;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 800), () async {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final results = await GeocodingService.fetchLocations(query);
        if (mounted) {
          setState(() {
            _searchResults = results;
            if (results.isEmpty) {
              _errorMessage = 'No locations found.';
            }
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage =
                'Failed to load results. Check internet connection.';
            _searchResults = [];
          });
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  Future<void> _handleSelection(LocationResult result) async {
    await RecentSearchesService.addRecentSearch(result);
    if (mounted) {
      Navigator.pop(context, result);
    }
  }

  Future<void> _clearRecentSearches() async {
    await RecentSearchesService.clearRecentSearches();
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Search Bar Area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                hintText: 'Search city or region...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged('');
                              },
                            )
                          else
                            const Icon(Icons.mic, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search History / Suggestions
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                  ? Center(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : _searchController.text.isEmpty
                  ? _buildRecentSearchesSection()
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final result = _searchResults[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          title: Text(result.name),
                          onTap: () => _handleSelection(result),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchesSection() {
    if (_isLoadingRecent) {
      return const SizedBox(); // don't flash loading spinner
    }

    if (_recentSearches.isEmpty) {
      return const Center(
        child: Text(
          'No recent searches yet.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: _clearRecentSearches,
                child: const Text(
                  'Clear',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: _recentSearches.length,
            itemBuilder: (context, index) {
              final result = _recentSearches[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  onTap: () => _handleSelection(result),
                  child: Row(
                    children: [
                      const Icon(Icons.history, color: Colors.grey, size: 20),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          result.name,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
