import 'package:flutter/material.dart';
import 'package:storyly/app/theme/app_colors.dart';
import 'package:storyly/features/home/data/datasources/home_datasource.dart';
import 'package:storyly/features/home/data/repositories/home_repository_impl.dart';
import 'package:storyly/features/home/domain/entities/story.dart';
import 'package:storyly/features/home/domain/usecases/get_home_data.dart';
import 'package:storyly/features/home/presentation/controller/home_controller.dart';
import 'package:storyly/features/home/presentation/widgets/category_section.dart';
import 'package:storyly/features/home/presentation/widgets/home_header.dart';
import 'package:storyly/features/home/presentation/widgets/recommended_section.dart';
import 'package:storyly/features/home/presentation/widgets/search_bar.dart';
import 'package:storyly/features/home/presentation/widgets/story_banner.dart';
import 'package:storyly/features/home/presentation/pages/story_details_page.dart';
import 'package:storyly/features/notifications/presentation/pages/notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    const dataSource = HomeLocalDataSourceImpl();
    const repository = HomeRepositoryImpl(dataSource: dataSource);
    final useCase = GetHomeData(repository);
    _controller = HomeController(getHomeDataUseCase: useCase);
    _controller.loadHomeData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openStoryDetails(BuildContext context, StoryEntity story) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StoryDetailsPage(story: story)),
    );
  }

  void _openNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
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
                child: CircularProgressIndicator(color: AppColors.navyBlue),
              );
            }

            final data = _controller.homeData;
            if (data == null) {
              return const Center(child: Text('Unable to load home data.'));
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header
                  HomeHeader(
                    onNotificationTap: () => _openNotifications(context),
                  ),

                  // Search Bar
                  HomeSearchBar(
                    onChanged: (query) => _controller.updateSearchQuery(query),
                  ),

                  const SizedBox(height: 8),

                  // Featured Story Banner
                  StoryBannerWidget(
                    banners: data.featuredBanners,
                    activeIndex: _controller.activeBannerIndex,
                    onPageChanged: (index) =>
                        _controller.onBannerPageChanged(index),
                  ),

                  // Categories Section
                  CategorySectionWidget(
                    categories: data.categories,
                    selectedCategoryId: _controller.selectedCategoryId,
                    onCategoryTap: (category) {
                      _controller.selectCategory(category.id);
                    },
                  ),

                  const SizedBox(height: 8),

                  // Recommended for You Section
                  RecommendedSectionWidget(
                    stories: _controller.filteredRecommendedStories,
                    onStoryTap: (story) => _openStoryDetails(context, story),
                    onFavoriteTap: (story) =>
                        _controller.toggleFavorite(story.id),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
