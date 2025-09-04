import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../models/notice.dart';
import '../widgets/notice_card.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  bool _isLoading = true;
  List<Notice> _notices = [];
  List<Notice> _filteredNotices = [];
  String _searchQuery = '';
  String _filterType = 'All';

  @override
  void initState() {
    super.initState();
    _loadNotices();
  }

  void _loadNotices() {
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _notices = MockData.getNotices();
          _filteredNotices = _notices;
          _isLoading = false;
        });
      }
    });
  }

  void _filterNotices() {
    setState(() {
      _filteredNotices = _notices.where((notice) {
        final matchesSearch = notice.title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            notice.content.toLowerCase().contains(_searchQuery.toLowerCase());

        final matchesFilter = _filterType == 'All' ||
            (_filterType == 'Important' && notice.isImportant) ||
            (_filterType == 'Regular' && !notice.isImportant);

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Board'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingShimmer()
          : Column(
              children: [
                _buildSummaryCard(),
                const SizedBox(height: 16),
                _buildFilterChips(),
                const SizedBox(height: 16),
                Expanded(
                  child: _filteredNotices.isEmpty
                      ? _buildEmptyState()
                      : _buildNoticesList(),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoticeDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSummaryCard() {
    final importantNotices =
        _notices.where((notice) => notice.isImportant).length;
    final totalNotices = _notices.length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Notices',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  totalNotices.toString(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$importantNotices important notices',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.announcement,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildFilterChip('All'),
          const SizedBox(width: 8),
          _buildFilterChip('Important'),
          const SizedBox(width: 8),
          _buildFilterChip('Regular'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String type) {
    final isSelected = _filterType == type;
    return FilterChip(
      label: Text(type),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterType = type;
        });
        _filterNotices();
      },
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      selectedColor: Theme.of(context).colorScheme.secondaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onSecondaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildNoticesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredNotices.length,
      itemBuilder: (context, index) {
        final notice = _filteredNotices[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: NoticeCard(notice: notice),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.announcement,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No notices found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no notices matching your current filter.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Notices'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter search term...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
            _filterNotices();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
              });
              _filterNotices();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Notices'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Notices'),
              leading: Radio<String>(
                value: 'All',
                groupValue: _filterType,
                onChanged: (value) {
                  setState(() {
                    _filterType = value!;
                  });
                  _filterNotices();
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Important Notices'),
              leading: Radio<String>(
                value: 'Important',
                groupValue: _filterType,
                onChanged: (value) {
                  setState(() {
                    _filterType = value!;
                  });
                  _filterNotices();
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Regular Notices'),
              leading: Radio<String>(
                value: 'Regular',
                groupValue: _filterType,
                onChanged: (value) {
                  setState(() {
                    _filterType = value!;
                  });
                  _filterNotices();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddNoticeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Notice'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Admin feature coming soon!'),
            SizedBox(height: 16),
            Text(
              'This feature will allow society administrators to post new notices and announcements.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
