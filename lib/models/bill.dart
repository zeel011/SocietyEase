class Bill {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  final String status;
  final String month;
  final String? receiptUrl;

  Bill({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.month,
    this.receiptUrl,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
      month: json['month'],
      receiptUrl: json['receiptUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'status': status,
      'month': month,
      'receiptUrl': receiptUrl,
    };
  }
} 