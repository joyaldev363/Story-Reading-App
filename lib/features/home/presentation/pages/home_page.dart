import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../data/datasources/home_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/story.dart';
import '../../domain/usecases/get_home_data.dart';
import '../controller/home_controller.dart';
import '../widgets/category_section.dart';
import '../widgets/home_header.dart';
import '../widgets/recommended_section.dart';
import '../widgets/search_bar.dart';
import '../widgets/story_banner.dart';

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

  void _openStoryReaderModal(BuildContext context, StoryEntity story) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.72,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF635BFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.auto_stories_rounded,
                    color: Color(0xFF635BFF),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navyBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${story.languageLabel} • ${story.readTime}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF718096),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Story Preview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  '${story.description}\n\n'
                  'வரிசை கதைகள்: தமிழ் மற்றும் ஆங்கிலத்தில் சிறுகதை வாசிப்பு அனுபவம்.\n\n'
                  'Enjoy reading this story with synchronized audio narration, vocabulary builder, and bilingual text toggling.',
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: AppColors.navyBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF635BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reading "${story.title}" now!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                label: const Text(
                  'Start Reading Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                  const HomeHeader(),

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
                    onStoryTap: (story) =>
                        _openStoryReaderModal(context, story),
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
