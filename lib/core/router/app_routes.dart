class AppRoutes {
  // Main Routes
  static const home = '/home';
  static const notifications = '/notifications';
  static const requests = '/requests';
  static const campaigns = '/campaigns';
  static const profile = '/profile';

  // Profile Sub-Routes (بدون / لأنها مسارات فرعية داخل الـ Profile)
  static const myActivities = 'my-activities';
  static const myImpact = 'my-impact';
  static const myRequests = 'my-requests';
  static const editProfile = 'edit-profile';

  // Auth Routes
  static const login = '/login';
  static const register = '/register';
  static const registerStep2 = '/register_step2';
}