import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../widgets/overview_card.dart';
import '../widgets/notice_preview_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: _isLoading
          ? _buildLoadingShimmer()
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 120,
                  floating: false,
                  pinned: true,
                  backgroundColor: colorScheme.surface,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding:
                        const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    title: Text(
                      'SocietyEase',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.primary,
                            colorScheme.primaryContainer,
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {
                        // TODO: Implement notifications
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_outline),
                      onPressed: () {
                        // TODO: Implement profile
                      },
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildGreeting(),
                      const SizedBox(height: 24),
                      _buildOverviewCards(),
                      const SizedBox(height: 24),
                      _buildLatestNotices(),
                    ]),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement admin functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Admin features coming soon!'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildGreeting() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting !!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Welcome to your society dashboard',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildOverviewCards() {
    final unpaidBills = MockData.getUnpaidBillsCount();
    final latestNotice = MockData.getLatestNotice();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OverviewCard(
                title: 'Unpaid Bills',
                value: unpaidBills.toString(),
                icon: Icons.payment,
                color: Colors.orange,
                onTap: () {
                  // Navigate to bills screen
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OverviewCard(
                title: 'Latest Notice',
                value: latestNotice?.title ?? 'No notices',
                icon: Icons.announcement,
                color: Colors.blue,
                onTap: () {
                  // Navigate to notices screen
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        OverviewCard(
          title: 'Complaints',
          value: '2 Pending',
          icon: Icons.report_problem,
          color: Colors.red,
          onTap: () {
            // TODO: Navigate to complaints screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Complaints module coming soon!'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLatestNotices() {
    final notices = MockData.getNotices().take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Notices',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to notices screen
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...notices.map((notice) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: NoticePreviewCard(notice: notice),
            )),
      ],
    );
  }
}
