import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final List<Map<String, String>> _faqs = const [
    {
      'question': 'How does bilingual Tamil & English audio sync work?',
      'answer':
          'Storyly highlights sentences synchronously with high-quality Tamil and English audio narration. You can toggle audio language anytime using the floating player controls.',
    },
    {
      'question': 'Can I read and download stories offline?',
      'answer':
          'Yes! Tap the download icon on any story card. Downloaded stories are saved locally on your device for seamless offline reading without internet.',
    },
    {
      'question': 'How are reading streaks and daily goals calculated?',
      'answer':
          'Reading at least 10 minutes daily updates your active reading streak and earns bonus vocabulary points in your profile gamer stats.',
    },
    {
      'question': 'How do I change the reader font size or theme?',
      'answer':
          'Inside the reader page, tap the Aa font button at the top header to adjust font size, paragraph spacing, dark mode, or sepia parchment theme.',
    },
  ];

  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.navyBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navyBlue,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar header
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search help topics or questions...',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF635BFF)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Contact Options
            const Text(
              'Need Assistance?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ContactCard(
                    icon: Icons.support_agent_rounded,
                    title: 'Live Chat Support',
                    subtitle: '24/7 Assistance',
                    color: const Color(0xFF635BFF),
                    onTap: () => _showSnackBar(context, 'Connecting to Live Chat...'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ContactCard(
                    icon: Icons.email_outlined,
                    title: 'Email Us',
                    subtitle: 'support@storyly.app',
                    color: AppColors.navyBlue,
                    onTap: () => _showSnackBar(context, 'Opening email client...'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // FAQ Section
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _faqs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final isExpanded = _expandedIndex == index;
                final faq = _faqs[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.help_outline_rounded,
                              color: Color(0xFF635BFF),
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                faq['question']!,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.navyBlue,
                                ),
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: const Color(0xFFA0AEC0),
                            ),
                          ],
                        ),
                        if (isExpanded) ...[
                          const SizedBox(height: 12),
                          const Divider(height: 1),
                          const SizedBox(height: 12),
                          Text(
                            faq['answer']!,
                            style: const TextStyle(
                              fontSize: 13.5,
                              color: Color(0xFF4A5568),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
