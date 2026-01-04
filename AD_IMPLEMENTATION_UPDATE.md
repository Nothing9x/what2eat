# Cập Nhật Quảng Cáo Video - Ad Implementation Update

## Tổng Quan / Overview

Đã cập nhật logic hiển thị quảng cáo video theo yêu cầu mới:
- ✅ Sử dụng ad unit ID thật: `ca-app-pub-7177141603793917/3644925402`
- ✅ Xóa nút Cancel - user bắt buộc phải xem quảng cáo
- ✅ Quảng cáo hiển thị TRƯỚC KHI quay wheel (không phải sau khi xem kết quả)
- ✅ Counter được tăng SAU KHI quay xong
- ✅ Quảng cáo vẫn hiển thị kể cả khi user thoát app và quay lại

## Luồng Hoạt Động Mới / New Flow

### Trước (Old Flow):
1. User quay wheel → Xem kết quả
2. User bấm nút "Quay lại" hoặc "Spin Again"
3. Kiểm tra counter → Hiển thị dialog quảng cáo
4. User có thể Cancel hoặc Watch Ad
5. Về home screen

### Bây Giờ (New Flow):
1. User bấm nút "Quay" (Spin button)
2. **Kiểm tra counter ngay lập tức**
3. Nếu đủ 5 lần → Hiển thị dialog quảng cáo (BẮT BUỘC)
4. User bấm "Xem Quảng Cáo" → Hiển thị quảng cáo video
5. Sau khi xem xong quảng cáo → Wheel bắt đầu quay
6. Counter tăng lên SAU KHI wheel quay xong
7. Hiển thị kết quả bình thường
8. User có thể quay lại home hoặc mở app giao đồ ăn

## Chi Tiết Thay Đổi / Changes Detail

### 1. Ad Unit ID - Real Video Ad
**File:** [lib/services/ad_service.dart](lib/services/ad_service.dart:77)

```dart
// Cũ / Old:
return 'ca-app-pub-7177141603793917/YOUR_INTERSTITIAL_AD_UNIT_ID';

// Mới / New:
return 'ca-app-pub-7177141603793917/3644925402'; // Android interstitial/video ad
```

### 2. Ad Dialog - Bắt Buộc Xem / Mandatory
**File:** [lib/widgets/ad_dialog.dart](lib/widgets/ad_dialog.dart)

**Thay đổi:**
- ❌ Xóa nút "Cancel"
- ✅ Chỉ còn nút "Xem Quảng Cáo" (full width)
- ✅ `barrierDismissible: false` - không cho tap ngoài để đóng
- ✅ `PopScope(canPop: false)` - không cho bấm nút back để thoát
- ✅ User BẮT BUỘC phải bấm "Xem Quảng Cáo" để tiếp tục

```dart
// Cũ / Old:
actions: [
  TextButton("Cancel"),
  ElevatedButton("Watch Ad"),
]

// Mới / New:
actions: [
  SizedBox(
    width: double.infinity,
    child: ElevatedButton("Xem Quảng Cáo"), // Full width, no cancel
  ),
]
```

### 3. Home Screen - Check Quảng Cáo TRƯỚC KHI Quay
**File:** [lib/screens/home_screen.dart](lib/screens/home_screen.dart:53)

**Logic mới trong `_spinWheel()`:**

```dart
void _spinWheel() async {
  if (_isSpinning) return;

  // Check items...
  if (items.isEmpty) return;

  // ✅ KIỂM TRA QUẢNG CÁO TRƯỚC - Check ad BEFORE spinning
  final shouldShowAd = await SpinCounterService.shouldShowAd();
  if (shouldShowAd) {
    // Show dialog (user must watch)
    await AdDialog.show(context);

    // Show ad
    final adShown = await AdService().showInterstitialAd();
    if (adShown) {
      await SpinCounterService.resetSpinCount();
    }
  }

  // ✅ SAU ĐÓ MỚI QUAY - THEN spin wheel
  // ... spin animation code ...

  // ✅ TĂNG COUNTER SAU KHI QUAY XONG - Increment AFTER spinning
  await SpinCounterService.incrementSpinCount();

  // Show result screen
  Navigator.push(...);
}
```

### 4. Result Screen - Đơn Giản Hóa / Simplified
**File:** [lib/screens/result_screen.dart](lib/screens/result_screen.dart)

**Xóa:**
- ❌ `_incrementSpinCount()` - counter được tăng ở home screen
- ❌ `_handleBackNavigation()` - không cần check quảng cáo nữa
- ❌ `PopScope` với ad check logic
- ❌ Import ad services (không dùng nữa)

**Giữ lại:**
- ✅ Hiển thị kết quả món ăn
- ✅ Nút order trên food delivery platforms
- ✅ Nút "Quay lại" và "Quay tiếp" đơn giản (`Navigator.pop`)

## Tính Năng Quan Trọng / Important Features

### 1. Counter Persistent (Tồn Tại Qua Các Lần Mở App)
Counter được lưu trong SharedPreferences, nên:
- ✅ User quay 3 lần → Thoát app
- ✅ Mở app lại → Quay thêm 2 lần
- ✅ Lần thứ 5 vẫn hiển thị quảng cáo

### 2. Không Thể Bỏ Qua / Cannot Skip
- ✅ Không có nút Cancel
- ✅ Không thể tap ngoài để đóng dialog
- ✅ Không thể bấm back button để thoát dialog
- ✅ User BẮT BUỘC phải xem quảng cáo để tiếp tục quay

### 3. User Experience Flow
```
User bấm "Quay"
  ↓
[Lần 1-4]: Quay ngay → Xem kết quả
  ↓
[Lần 5]: Dialog xuất hiện
  ↓
User bấm "Xem Quảng Cáo" (duy nhất option)
  ↓
Quảng cáo video hiển thị
  ↓
User xem hết quảng cáo
  ↓
Wheel quay với animation
  ↓
Hiển thị kết quả
  ↓
[Counter reset về 0, chu kỳ lặp lại]
```

## Testing / Kiểm Tra

### Để Test Với Test Ads:
**File:** [lib/services/ad_service.dart](lib/services/ad_service.dart:39)

```dart
static const bool useTestAds = true;  // Bật test mode
```

### Để Test Với Real Ads (Development):
1. Thêm device ID vào `testDeviceIds` array
2. Set `useTestAds = false`
3. Build debug APK
4. Cài lên device và test

### Test Checklist:
- [ ] Quay 4 lần → Không có quảng cáo
- [ ] Lần thứ 5 → Dialog xuất hiện
- [ ] Bấm back button trên dialog → Không đóng được
- [ ] Tap ngoài dialog → Không đóng được
- [ ] Phải bấm "Xem Quảng Cáo" → Quảng cáo xuất hiện
- [ ] Sau quảng cáo → Wheel quay
- [ ] Xem kết quả → Bình thường
- [ ] Thoát app → Mở lại → Quay tiếp → Counter vẫn hoạt động đúng

## Build Information

```
✓ Built build/app/outputs/flutter-apk/app-release.apk (57.6MB)
```

## Files Changed

1. ✅ [lib/services/ad_service.dart](lib/services/ad_service.dart) - Updated ad unit ID
2. ✅ [lib/widgets/ad_dialog.dart](lib/widgets/ad_dialog.dart) - Removed cancel button, made mandatory
3. ✅ [lib/screens/home_screen.dart](lib/screens/home_screen.dart) - Check ad before spin, increment after spin
4. ✅ [lib/screens/result_screen.dart](lib/screens/result_screen.dart) - Simplified, removed ad logic

## Ad Unit Information

- **App ID:** `ca-app-pub-7177141603793917~8941607826`
- **Banner Ad (Bottom):** `ca-app-pub-7177141603793917/2877804494`
- **Interstitial/Video Ad:** `ca-app-pub-7177141603793917/3644925402` ⬅️ **ĐANG DÙNG / IN USE**

## Notes / Ghi Chú

1. **Counter = 5 spins**: Có thể thay đổi trong [lib/services/spin_counter_service.dart](lib/services/spin_counter_service.dart:6)
2. **Test Mode**: Nhớ set `useTestAds = false` khi release production
3. **User Experience**: Dialog xuất hiện TRƯỚC khi quay nên user biết rằng họ phải xem quảng cáo trước
4. **Không có cách nào bypass**: User BẮT BUỘC phải xem quảng cáo để tiếp tục sử dụng app

## Next Steps / Bước Tiếp Theo

1. Test app trên thiết bị thật với test ads
2. Nếu OK → Build release APK
3. Upload lên Google Play Console
4. Monitor ad performance trong AdMob dashboard
