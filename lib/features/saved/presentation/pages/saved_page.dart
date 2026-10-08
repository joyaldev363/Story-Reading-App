import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../data/datasources/saved_datasource.dart';
import '../../data/repositories/saved_repository_impl.dart';
import '../../domain/usecases/get_saved_stories.dart';
import '../../domain/usecases/remove_saved_story.dart';
import '../../domain/usecases/search_saved_stories.dart';
import '../../domain/usecases/toggle_saved_story.dart';
import '../controller/saved_controller.dart';
import '../widgets/saved_filter_tabs.dart';
import '../widgets/saved_header.dart';
import '../widgets/saved_search_bar.dart';
import '../widgets/saved_story_card.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late final SavedController _controller;

  @override
  void initState() {
    super.initState();
    final dataSource = SavedLocalDataSourceImpl();
    final repository = SavedRepositoryImpl(dataSource: dataSource);

    _controller = SavedController(
      getSavedStoriesUseCase: GetSavedStories(repository),
      searchSavedStoriesUseCase: SearchSavedStories(repository),
      removeSavedStoryUseCase: RemoveSavedStory(repository),
      toggleSavedStoryUseCase: ToggleSavedStory(repository),
    );

    _controller.loadSavedStories();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (_controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF635BFF)),
              );
            }

            final stories = _controller.filteredStories;

            return RefreshIndicator(
              color: const Color(0xFF635BFF),
              backgroundColor: Colors.white,
              onRefresh: () => _controller.loadSavedStories(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  // Top Header
                  SliverToBoxAdapter(
                    child: SavedHeader(
                      onMoreTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('More options tapped'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),

                  // Search Bar
                  SliverToBoxAdapter(
                    child: SavedSearchBar(
                      onChanged: (query) =>
                          _controller.updateSearchQuery(query),
                    ),
                  ),

                  // Filter Tabs
                  SliverToBoxAdapter(
                    child: SavedFilterTabs(
                      selectedFilter: _controller.selectedFilter,
                      allCount: _controller.allCount,
                      unreadCount: _controller.unreadCount,
                      readingCount: _controller.readingCount,
                      onFilterSelected: (filter) =>
                          _controller.selectFilter(filter),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),

                  // Stories List or Empty State
                  if (stories.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_outline_rounded,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No saved stories found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Try searching for another story or changing filters',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final story = stories[index];
                          return SavedStoryCard(
                            story: story,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Opening ${story.title}'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            onBookmarkTap: () =>
                                _controller.toggleSaved(story.id),
                          );
                        }, childCount: stories.length),
                      ),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
