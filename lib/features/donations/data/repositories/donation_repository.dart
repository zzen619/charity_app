import '../models/donation_model.dart';

class DonationRepository {
  Future<List<DonationModel>> getDonations(DonationCategory category) async {
    await Future.delayed(const Duration(seconds: 1));

    final all = [
      DonationModel(
        id: 1,
        name: 'Ahmed',
        title: 'Student',
        description:
            '''Ali is a 25-year-old father of three who has been diagnosed with a critical heart condition.
        Doctors have recommended urgent surgery to save his life, but the cost of the operation
        is far beyond what his family can afford.
        Your donation can give Ali a second chance at life and allow him to return to his family
        healthy and strong.
        ''',
        raised: 800,
        goal: 1200,
        image: '',
      ),
      DonationModel(
        id: 2,
        name: 'Ali',
        title: 'Patient',
        description: 'Needs surgery',
        raised: 200,
        goal: 1000,
        image: '',
      ),
    ];

    /// 🔥 فلترة حسب النوع (مؤقت)
    if (category == DonationCategory.education) {
      return all.where((e) => e.title.contains('Student')).toList();
    }

    if (category == DonationCategory.medical) {
      return all.where((e) => e.title.contains('Patient')).toList();
    }

    return all;
  }
}
