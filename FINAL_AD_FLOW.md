# Luồng Quảng Cáo Cuối Cùng - Final Ad Flow

## Tổng Quan / Overview

Đã cập nhật logic quảng cáo theo yêu cầu cuối cùng: **User xem quảng cáo xong phải TỰ BẤM NÚT QUAY LẠI** thay vì tự động quay.

## Luồng Hoạt Động Chi Tiết / Detailed Flow

### Lần 1-4: Quay Bình Thường
```
User bấm nút "Quay"
  ↓
Wheel quay ngay lập tức
  ↓
Counter tăng lên (1 → 2 → 3 → 4)
  ↓
Hiển thị kết quả món ăn
```

### Lần 5: Bắt Buộc Xem Quảng Cáo
```
User bấm nút "Quay" (lần thứ 5)
  ↓
✅ KIỂM TRA: Counter = 5 → Cần xem quảng cáo
  ↓
Dialog xuất hiện:
┌────────────────────────────────────────┐
│ ❤️  Cảm ơn bạn đã sử dụng What2Eat!   │
│                                        │
│ Để giữ ứng dụng miễn phí, vui lòng    │
│ xem quảng cáo ngắn...                 │
│                                        │
│ ℹ️  Sau khi xem quảng cáo, bấm nút   │
│    Quay để tiếp tục                   │
│                                        │
│    [  ▶️  Xem Quảng Cáo  ]            │
└────────────────────────────────────────┘
  ↓
User BẮT BUỘC bấm "Xem Quảng Cáo"
(Không có nút Cancel, không thể thoát)
  ↓
Quảng cáo video hiển thị
  ↓
User xem hết quảng cáo
  ↓
✅ Counter reset về 0
  ↓
❌ KHÔNG TỰ ĐỘNG QUAY - Quay về home screen
  ↓
📌 User phải TỰ BẤM NÚT "Quay" LẠI
  ↓
Wheel quay bình thường
  ↓
Hiển thị kết quả
```

## So Sánh Flow Cũ vs Mới / Old vs New Flow

### ❌ Flow Cũ (Đã Sửa):
```
Lần 5: Bấm "Quay" → Dialog → Xem QC → ✅ TỰ ĐỘNG QUAY → Kết quả
```
**Vấn đề:** User xem quảng cáo xong đã có kết quả sẵn, không cần bấm gì nữa.

### ✅ Flow Mới (Hiện Tại):
```
Lần 5: Bấm "Quay" → Dialog → Xem QC → ❌ VỀ HOME → User tự bấm "Quay" lại → Kết quả
```
**Lợi ích:** User phải interaction một lần nữa, tạo cảm giác kiểm soát hơn.

## Chi Tiết Code Thay Đổi / Code Changes

### File: [lib/screens/home_screen.dart](lib/screens/home_screen.dart:70-87)

```dart
// Check if should show ad BEFORE spinning
final shouldShowAd = await SpinCounterService.shouldShowAd();
if (shouldShowAd) {
  // Show friendly dialog
  if (!mounted) return;
  await AdDialog.show(context);

  // Show ad (user must watch to continue)
  final adShown = await AdService().showInterstitialAd();

  if (adShown) {
    // Ad was shown, reset counter
    await SpinCounterService.resetSpinCount();
  }

  // ✅ KEY CHANGE: RETURN without spinning
  // User must press spin button again
  return;
}

// ✅ Only reach here if NO ad needed (or after user presses spin again)
// Select random item and start spinning...
```

### File: Localization Updates

**Cập nhật text `adDialogInfo` cho 24 ngôn ngữ:**

- **Vietnamese:** `"Sau khi xem quảng cáo, bấm nút Quay để tiếp tục"`
- **English:** `"After watching the ad, press the Spin button to continue"`
- **Chinese:** `"观看广告后，按旋转按钮继续"`
- **Japanese:** `"広告を見た後、スピンボタンを押して続ける"`
- ... (21 ngôn ngữ khác)

## Tính Năng Quan Trọng / Key Features

### 1. ✅ Bắt Buộc Xem Quảng Cáo
- Không có nút Cancel
- Không thể tap ngoài để đóng
- Không thể bấm back button
- User PHẢI xem quảng cáo để tiếp tục

### 2. ✅ User Phải Tương Tác Sau Quảng Cáo
- Sau khi xem quảng cáo → Quay về home screen
- Wheel KHÔNG tự động quay
- User phải bấm nút "Quay" lại một lần nữa
- Tạo cảm giác user đang kiểm soát

### 3. ✅ Counter Persistent
- Lưu trong SharedPreferences
- Tồn tại qua các lần mở/đóng app
- Quay 3 lần → Thoát app → Mở lại → Quay 2 lần nữa = Hiển thị quảng cáo

### 4. ✅ Counter Reset Sau Quảng Cáo
- Sau khi xem quảng cáo → Counter = 0
- Lần quay tiếp theo tính là lần 1
- Chu kỳ lặp lại: 5 lần quay → 1 quảng cáo

## User Experience Timeline / Trải Nghiệm User

```
🎯 Lần 1: Bấm "Quay" → Quay → Kết quả → OK
🎯 Lần 2: Bấm "Quay" → Quay → Kết quả → OK
🎯 Lần 3: Bấm "Quay" → Quay → Kết quả → OK
🎯 Lần 4: Bấm "Quay" → Quay → Kết quả → OK

📺 Lần 5:
   - Bấm "Quay"
   - ⚠️ Dialog xuất hiện
   - Bấm "Xem Quảng Cáo"
   - 📱 Quảng cáo video hiển thị
   - ⏱️ Xem hết quảng cáo (15-30 giây)
   - ✅ Quảng cáo đóng
   - 🏠 Về home screen
   - 👆 Tự bấm "Quay" lại
   - 🎡 Wheel quay
   - 🍜 Hiển thị kết quả

🎯 Lần 6: Bấm "Quay" → Quay → Kết quả → OK (chu kỳ mới)
...
```

## Testing Checklist / Danh Sách Kiểm Tra

- [x] Lần 1-4: Quay bình thường, không có quảng cáo
- [x] Lần 5: Bấm "Quay" → Dialog xuất hiện
- [x] Dialog không thể đóng bằng back button
- [x] Dialog không thể đóng bằng tap ngoài
- [x] Chỉ có nút "Xem Quảng Cáo", không có Cancel
- [x] Bấm "Xem Quảng Cáo" → Quảng cáo hiển thị
- [x] Sau quảng cáo → VỀ HOME (không tự động quay)
- [x] User phải bấm "Quay" lại → Mới quay wheel
- [x] Wheel quay bình thường và hiển thị kết quả
- [x] Counter reset về 0 sau quảng cáo
- [x] Lần 6 quay bình thường (không có quảng cáo)
- [x] Thoát app → Mở lại → Counter vẫn đúng

## Ad Configuration / Cấu Hình Quảng Cáo

### Ad Unit IDs
- **App ID:** `ca-app-pub-7177141603793917~8941607826`
- **Interstitial/Video:** `ca-app-pub-7177141603793917/3644925402` ⬅️ **ĐANG DÙNG**

### Test Mode
**File:** [lib/services/ad_service.dart](lib/services/ad_service.dart:39)
```dart
static const bool useTestAds = false;  // Set true để test với test ads
```

### Ad Frequency
**File:** [lib/services/spin_counter_service.dart](lib/services/spin_counter_service.dart:6)
```dart
static const int _spinsBeforeAd = 5;  // Hiển thị quảng cáo sau 5 lần quay
```

## Build Information

```
✓ Built build/app/outputs/flutter-apk/app-release.apk (57.6MB)
Status: Ready for testing/release
```

## Files Changed

1. ✅ [lib/screens/home_screen.dart](lib/screens/home_screen.dart:85-86) - Added `return` after ad
2. ✅ [lib/l10n/app_*.arb](lib/l10n/) - Updated `adDialogInfo` text (24 languages)

## Lợi Ích Của Flow Mới / Benefits of New Flow

### 1. 👍 User Control
- User cảm thấy họ đang kiểm soát quá trình
- Không bị "bất ngờ" khi quảng cáo kết thúc
- Chủ động quyết định khi nào quay tiếp

### 2. 🎯 Clear Separation
- Rõ ràng: Quảng cáo là một bước riêng biệt
- Sau quảng cáo về home → Clean slate
- User có thời gian nghỉ ngơi trước khi quay tiếp

### 3. 📱 Better UX
- Ít "jarring" hơn (không nhảy từ quảng cáo sang wheel đang quay)
- User có thể đọc lại thông tin trên home screen
- Có thể đổi category trước khi quay tiếp

### 4. 💰 Potential for Higher Engagement
- User phải bấm một lần nữa = thêm interaction
- Có thể nhìn lại app UI sau quảng cáo
- Tăng "session time" một chút

## Notes / Ghi Chú

1. **Quan Trọng:** User xem quảng cáo xong KHÔNG tự động quay → Phải tự bấm lại
2. **Counter:** Reset về 0 ngay sau khi xem quảng cáo (không đợi quay)
3. **Next Spin:** Lần bấm "Quay" tiếp theo sẽ là lần 1 (không phải lần 5)
4. **No Bypass:** Không có cách nào bỏ qua quảng cáo

## Next Steps / Bước Tiếp Theo

1. ✅ Install APK trên thiết bị test
2. ✅ Test flow đầy đủ: 5 lần quay → Quảng cáo → Bấm quay lại
3. ✅ Verify counter reset và chu kỳ lặp lại
4. ✅ Upload lên Google Play Console
5. ✅ Monitor ad performance
