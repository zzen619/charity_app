import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../state/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  File? profileImage; // 👈 صورة محلية

  /// تحميل البيانات
  void getProfile() {
    emit(
      ProfileLoaded(
        name: "Ahmed Zain El Din",
        image: "",
        walletBalance: 250.0,
        totalImpact: 12450,
        livesTouched: 84,
        error: null,
      ),
    );
  }

  /// 📸 تغيير الصورة
  Future<void> pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null && state is ProfileLoaded) {
      profileImage = File(pickedFile.path);

      final current = state as ProfileLoaded;

      /// 👇 فقط نعيد emit لنفس البيانات حتى يحدث rebuild
      emit(current.copyWith());
    }
  }

  /// ✏️ تحديث بيانات البروفايل
  void updateProfile({String? name, String? image, File? localImage}) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;

      // حفظ الصورة المحلية إذا تم اختيارها
      if (localImage != null) {
        profileImage = localImage;
      }

      emit(
        current.copyWith(
          name: name ?? current.name,
          image: image ?? current.image,
          error: null,
        ),
      );
    }
  }

  /// ➕ إضافة فلوس
  void addMoney(double amount) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;

      emit(
        current.copyWith(
          walletBalance: current.walletBalance + amount,
          error: null,
        ),
      );
    }
  }

  /// ➖ سحب فلوس
  void withdraw(double amount) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;

      if (current.walletBalance < amount) {
        emit(
          current.copyWith(
            error: "Not enough balance ❌",
          ),
        );
        return;
      }

      emit(
        current.copyWith(
          walletBalance: current.walletBalance - amount,
          error: null,
        ),
      );
    }
  }

  /// 🚪 تسجيل الخروج
  void logout() {
    emit(ProfileLoading());
  }
}