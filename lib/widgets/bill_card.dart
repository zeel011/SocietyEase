import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/bill.dart';

class BillCard extends StatelessWidget {
  final Bill bill;
  final VoidCallback onPayPressed;
  final VoidCallback onDownloadReceipt;

  const BillCard({
    super.key,
    required this.bill,
    required this.onPayPressed,
    required this.onDownloadReceipt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isPaid = bill.status == 'Paid';
    final isOverdue = !isPaid && bill.dueDate.isBefore(DateTime.now());

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bill.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bill.month,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(isPaid, isOverdue),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${bill.amount.toStringAsFixed(0)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Due Date',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM dd, yyyy').format(bill.dueDate),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isOverdue ? Colors.red : colorScheme.onSurface,
                          fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (!isPaid) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onPayPressed,
                      icon: const Icon(Icons.payment, size: 18),
                      label: const Text('Pay Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                if (bill.receiptUrl != null)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onDownloadReceipt,
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Receipt'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            if (isOverdue && !isPaid) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 16,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This bill is overdue. Please pay immediately to avoid late fees.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isPaid, bool isOverdue) {
    Color chipColor;
    String statusText;
    IconData statusIcon;

    if (isPaid) {
      chipColor = Colors.green;
      statusText = 'Paid';
      statusIcon = Icons.check_circle;
    } else if (isOverdue) {
      chipColor = Colors.red;
      statusText = 'Overdue';
      statusIcon = Icons.warning;
    } else {
      chipColor = Colors.orange;
      statusText = 'Unpaid';
      statusIcon = Icons.pending;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            size: 16,
            color: chipColor,
          ),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              color: chipColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
} 