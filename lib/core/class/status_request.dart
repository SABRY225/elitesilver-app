enum StatusRequest {
  none,            // الحالة الافتراضية
  loading,         // جاري التحميل
  success,         // تم بنجاح
  failure,         // فشل (بيانات خاطئة مثلاً)
  serverfailure,   // خطأ من السيرفر (500)
  offlinefailure   // خطأ في الإنترنت
}