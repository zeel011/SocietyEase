import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../models/bill.dart';
import '../widgets/bill_card.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  bool _isLoading = true;
  List<Bill> _bills = [];
  String _filterStatus = 'All';

  @override
  void initState() {
    super.initState();
    _loadBills();
  }

  void _loadBills() {
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _bills = MockData.getBills();
          _isLoading = false;
        });
      }
    });
  }

  List<Bill> get _filteredBills {
    if (_filterStatus == 'All') {
      return _bills;
    }
    return _bills.where((bill) => bill.status == _filterStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Bills'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
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
                  child: _filteredBills.isEmpty
                      ? _buildEmptyState()
                      : _buildBillsList(),
                ),
              ],
            ),
    );
  }

  Widget _buildLoadingShimmer() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSummaryCard() {
    final unpaidBills = _bills.where((bill) => bill.status == 'Unpaid').toList();
    final totalUnpaid = unpaidBills.fold<double>(
      0,
      (sum, bill) => sum + bill.amount,
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
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
                  'Total Outstanding',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${totalUnpaid.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${unpaidBills.length} unpaid bills',
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
              Icons.payment,
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
          _buildFilterChip('Unpaid'),
          const SizedBox(width: 8),
          _buildFilterChip('Paid'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String status) {
    final isSelected = _filterStatus == status;
    return FilterChip(
      label: Text(status),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterStatus = status;
        });
      },
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildBillsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredBills.length,
      itemBuilder: (context, index) {
        final bill = _filteredBills[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BillCard(
            bill: bill,
            onPayPressed: () => _handlePayment(bill),
            onDownloadReceipt: () => _handleDownloadReceipt(bill),
          ),
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
            Icons.receipt_long,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No bills found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no bills matching your current filter.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Bills'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Bills'),
              leading: Radio<String>(
                value: 'All',
                groupValue: _filterStatus,
                onChanged: (value) {
                  setState(() {
                    _filterStatus = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Unpaid Bills'),
              leading: Radio<String>(
                value: 'Unpaid',
                groupValue: _filterStatus,
                onChanged: (value) {
                  setState(() {
                    _filterStatus = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: const Text('Paid Bills'),
              leading: Radio<String>(
                value: 'Paid',
                groupValue: _filterStatus,
                onChanged: (value) {
                  setState(() {
                    _filterStatus = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePayment(Bill bill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bill: ${bill.title}'),
            Text('Amount: ₹${bill.amount.toStringAsFixed(0)}'),
            const SizedBox(height: 16),
            const Text('Choose payment method:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text('UPI Payment'),
              subtitle: const Text('Pay using UPI apps'),
              onTap: () {
                Navigator.pop(context);
                _showUPIDialog(bill);
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Card Payment'),
              subtitle: const Text('Credit/Debit card'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Card payment feature coming soon!'),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showUPIDialog(Bill bill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('UPI Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Amount: ₹${bill.amount.toStringAsFixed(0)}'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'UPI ID: society@pay',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Scan QR code or use UPI ID to pay',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment initiated! Check your UPI app.'),
                ),
              );
            },
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  void _handleDownloadReceipt(Bill bill) {
    if (bill.receiptUrl != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Downloading receipt: ${bill.receiptUrl}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receipt not available for this bill.'),
        ),
      );
    }
  }
} 