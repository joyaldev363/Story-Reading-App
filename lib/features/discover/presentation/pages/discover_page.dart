import 'package:flutter/material.dart';
import '../../data/datasources/discover_datasource.dart';
import '../../data/repositories/discover_repository_impl.dart';
import '../../domain/usecases/get_popular_stories.dart';
import '../../domain/usecases/search_stories.dart';
import '../controller/discover_controller.dart';
import '../widgets/discover_header.dart';
import '../widgets/discover_search_bar.dart';
import '../widgets/discover_story_card.dart';
import '../widgets/popular_stories_header.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late final DiscoverController _controller;

  @override
  void initState() {
    super.initState();
    final dataSource = DiscoverLocalDataSourceImpl();
    final repository = DiscoverRepositoryImpl(dataSource: dataSource);
    final getPopularStories = GetPopularStories(repository);
    final searchStories = SearchStories(repository);

    _controller = DiscoverController(
      getPopularStoriesUseCase: getPopularStories,
      searchStoriesUseCase: searchStories,
    );

    _controller.loadPopularStories();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            if (_controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF6366F1)),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _controller.loadPopularStories(),
              color: const Color(0xFF6366F1),
              child: CustomScrollView(
                slivers: [
                  // Padding Header & Search section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20.0,
                        16.0,
                        20.0,
                        20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DiscoverHeader(),
                          const SizedBox(height: 20),
                          DiscoverSearchBar(
                            query: _controller.searchQuery,
                            onChanged: (query) {
                              _controller.onSearchChanged(query);
                            },
                            onClear: () {
                              _controller.clearSearch();
                            },
                            onFilterTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Filter options opened'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          const PopularStoriesHeader(),
                        ],
                      ),
                    ),
                  ),

                  // Stories List or Empty Search Result
                  if (_controller.popularStories.isEmpty)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 48,
                                color: Color(0xFF94A3B8),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No stories found',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final story = _controller.popularStories[index];
                          return DiscoverStoryCard(
                            story: story,
                            onFavoriteTap: () {
                              _controller.toggleFavorite(story.id);
                            },
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Opening "${story.title}"'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          );
                        }, childCount: _controller.popularStories.length),
                      ),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
