import '../models/bill.dart';
import '../models/notice.dart';

class MockData {
  static List<Bill> getBills() {
    return [
      Bill(
        id: '1',
        title: 'Monthly Maintenance',
        amount: 2500.0,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        status: 'Unpaid',
        month: 'December 2024',
      ),
      Bill(
        id: '2',
        title: 'Water Charges',
        amount: 800.0,
        dueDate: DateTime.now().add(const Duration(days: 12)),
        status: 'Unpaid',
        month: 'December 2024',
      ),
      Bill(
        id: '3',
        title: 'Monthly Maintenance',
        amount: 2500.0,
        dueDate: DateTime.now().subtract(const Duration(days: 15)),
        status: 'Paid',
        month: 'November 2024',
        receiptUrl: 'receipt_nov_2024.pdf',
      ),
      Bill(
        id: '4',
        title: 'Electricity Charges',
        amount: 1200.0,
        dueDate: DateTime.now().subtract(const Duration(days: 8)),
        status: 'Paid',
        month: 'November 2024',
        receiptUrl: 'electricity_nov_2024.pdf',
      ),
      Bill(
        id: '5',
        title: 'Monthly Maintenance',
        amount: 2500.0,
        dueDate: DateTime.now().subtract(const Duration(days: 45)),
        status: 'Paid',
        month: 'October 2024',
        receiptUrl: 'receipt_oct_2024.pdf',
      ),
    ];
  }

  static List<Notice> getNotices() {
    return [
      Notice(
        id: '1',
        title: 'Society Annual General Meeting',
        content:
            'Dear Residents,\n\nWe are pleased to announce that the Annual General Meeting (AGM) of our society will be held on December 15, 2024, at 6:00 PM in the community hall.\n\nAgenda:\n- Review of last year\'s activities\n- Financial report presentation\n- Election of new committee members\n- Discussion on upcoming projects\n\nAll residents are requested to attend this important meeting. Light refreshments will be served.\n\nBest regards,\nSociety Management Committee',
        postedDate: DateTime.now().subtract(const Duration(days: 2)),
        author: 'Society Secretary',
        isImportant: true,
      ),
      Notice(
        id: '2',
        title: 'Water Supply Maintenance',
        content:
            'Dear Residents,\n\nPlease be informed that there will be scheduled water supply maintenance on December 10, 2024, from 9:00 AM to 3:00 PM. During this time, water supply will be temporarily suspended.\n\nWe apologize for the inconvenience and request your cooperation.\n\nThank you for your understanding.',
        postedDate: DateTime.now().subtract(const Duration(days: 1)),
        author: 'Committee',
        isImportant: true,
      ),
      Notice(
        id: '3',
        title: 'Diwali Celebrations',
        content:
            'Dear Residents,\n\nWe are excited to announce the Diwali celebrations in our society on November 12, 2024, starting at 6:00 PM.\n\nProgram:\n- Traditional lighting ceremony\n- Cultural performances\n- Community dinner\n- Fireworks display\n\nAll residents and their families are cordially invited to join the celebrations.\n\nLet\'s make this Diwali memorable together!',
        postedDate: DateTime.now().subtract(const Duration(days: 5)),
        author: 'Committee',
        isImportant: false,
      ),
      Notice(
        id: '4',
        title: 'Security Update',
        content:
            'Dear Residents,\n\nWe would like to inform you that we have upgraded our security system with new CCTV cameras and access control systems. The new system will be operational from December 1, 2024.\n\nPlease ensure that all family members and domestic help are registered with the security office.\n\nFor any queries, please contact the security office.\n\nThank you for your cooperation.',
        postedDate: DateTime.now().subtract(const Duration(days: 7)),
        author: 'Security Team',
        isImportant: false,
      ),
      Notice(
        id: '5',
        title: 'Garden Maintenance Schedule',
        content:
            'Dear Residents,\n\nOur garden maintenance team will be working on the following schedule:\n\n- Monday to Friday: 7:00 AM to 11:00 AM\n- Saturday: 8:00 AM to 12:00 PM\n- Sunday: 9:00 AM to 11:00 AM\n\nPlease avoid parking vehicles in the garden area during these hours.\n\nThank you for your cooperation.',
        postedDate: DateTime.now().subtract(const Duration(days: 10)),
        author: 'Committee',
        isImportant: false,
      ),
    ];
  }

  static int getUnpaidBillsCount() {
    return getBills().where((bill) => bill.status == 'Unpaid').length;
  }

  static Notice? getLatestNotice() {
    final notices = getNotices();
    if (notices.isEmpty) return null;
    notices.sort((a, b) => b.postedDate.compareTo(a.postedDate));
    return notices.first;
  }
}
