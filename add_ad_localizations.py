#!/usr/bin/env python3
import json
import os

# Ad-related localization strings for all languages
translations = {
    'en': {
        'adDialogTitle': 'Thanks for Using What2Eat!',
        'adDialogMessage': 'To keep this app free, please watch a short ad. This helps us continue improving What2Eat.',
        'adDialogInfo': 'Ad will show after you press "Watch Ad"',
        'watchAdButton': 'Watch Ad',
        'cancelButton': 'Cancel',
    },
    'vi': {
        'adDialogTitle': 'Cảm ơn bạn đã sử dụng What2Eat!',
        'adDialogMessage': 'Để giữ ứng dụng miễn phí, vui lòng xem quảng cáo ngắn. Điều này giúp chúng tôi tiếp tục cải thiện What2Eat.',
        'adDialogInfo': 'Quảng cáo sẽ hiển thị sau khi bạn nhấn "Xem Quảng Cáo"',
        'watchAdButton': 'Xem Quảng Cáo',
        'cancelButton': 'Hủy',
    },
    'zh': {
        'adDialogTitle': '感谢使用 What2Eat！',
        'adDialogMessage': '为了保持应用免费，请观看短广告。这有助于我们继续改进 What2Eat。',
        'adDialogInfo': '点击"观看广告"后将显示广告',
        'watchAdButton': '观看广告',
        'cancelButton': '取消',
    },
    'ja': {
        'adDialogTitle': 'What2Eatをご利用いただきありがとうございます！',
        'adDialogMessage': 'アプリを無料で提供するため、短い広告をご覧ください。これにより、What2Eatの改善を続けることができます。',
        'adDialogInfo': '「広告を見る」を押すと広告が表示されます',
        'watchAdButton': '広告を見る',
        'cancelButton': 'キャンセル',
    },
    'ko': {
        'adDialogTitle': 'What2Eat을 이용해 주셔서 감사합니다!',
        'adDialogMessage': '앱을 무료로 유지하기 위해 짧은 광고를 시청해 주세요. 이는 What2Eat을 계속 개선하는 데 도움이 됩니다.',
        'adDialogInfo': '"광고 보기"를 누르면 광고가 표시됩니다',
        'watchAdButton': '광고 보기',
        'cancelButton': '취소',
    },
    'es': {
        'adDialogTitle': '¡Gracias por usar What2Eat!',
        'adDialogMessage': 'Para mantener esta aplicación gratuita, por favor mira un anuncio corto. Esto nos ayuda a seguir mejorando What2Eat.',
        'adDialogInfo': 'El anuncio se mostrará después de presionar "Ver Anuncio"',
        'watchAdButton': 'Ver Anuncio',
        'cancelButton': 'Cancelar',
    },
    'fr': {
        'adDialogTitle': 'Merci d\'utiliser What2Eat !',
        'adDialogMessage': 'Pour garder cette application gratuite, veuillez regarder une courte publicité. Cela nous aide à continuer d\'améliorer What2Eat.',
        'adDialogInfo': 'La publicité s\'affichera après avoir appuyé sur "Regarder la Pub"',
        'watchAdButton': 'Regarder la Pub',
        'cancelButton': 'Annuler',
    },
    'de': {
        'adDialogTitle': 'Vielen Dank für die Nutzung von What2Eat!',
        'adDialogMessage': 'Um diese App kostenlos zu halten, schauen Sie sich bitte eine kurze Werbung an. Dies hilft uns, What2Eat weiter zu verbessern.',
        'adDialogInfo': 'Die Werbung wird angezeigt, nachdem Sie auf "Werbung ansehen" gedrückt haben',
        'watchAdButton': 'Werbung ansehen',
        'cancelButton': 'Abbrechen',
    },
    'th': {
        'adDialogTitle': 'ขอบคุณที่ใช้ What2Eat!',
        'adDialogMessage': 'เพื่อให้แอปนี้ฟรี โปรดดูโฆษณาสั้นๆ สิ่งนี้ช่วยให้เราปรับปรุง What2Eat ต่อไป',
        'adDialogInfo': 'โฆษณาจะแสดงหลังจากกด "ดูโฆษณา"',
        'watchAdButton': 'ดูโฆษณา',
        'cancelButton': 'ยกเลิก',
    },
    'it': {
        'adDialogTitle': 'Grazie per aver utilizzato What2Eat!',
        'adDialogMessage': 'Per mantenere questa app gratuita, guarda un breve annuncio. Questo ci aiuta a continuare a migliorare What2Eat.',
        'adDialogInfo': 'L\'annuncio verrà visualizzato dopo aver premuto "Guarda Annuncio"',
        'watchAdButton': 'Guarda Annuncio',
        'cancelButton': 'Annulla',
    },
    'pt': {
        'adDialogTitle': 'Obrigado por usar What2Eat!',
        'adDialogMessage': 'Para manter este aplicativo gratuito, assista a um anúncio curto. Isso nos ajuda a continuar melhorando o What2Eat.',
        'adDialogInfo': 'O anúncio será exibido após pressionar "Assistir Anúncio"',
        'watchAdButton': 'Assistir Anúncio',
        'cancelButton': 'Cancelar',
    },
    'ru': {
        'adDialogTitle': 'Спасибо за использование What2Eat!',
        'adDialogMessage': 'Чтобы приложение оставалось бесплатным, пожалуйста, посмотрите короткую рекламу. Это помогает нам продолжать улучшать What2Eat.',
        'adDialogInfo': 'Реклама будет показана после нажатия "Смотреть Рекламу"',
        'watchAdButton': 'Смотреть Рекламу',
        'cancelButton': 'Отмена',
    },
    'hi': {
        'adDialogTitle': 'What2Eat का उपयोग करने के लिए धन्यवाद!',
        'adDialogMessage': 'इस ऐप को मुफ़्त रखने के लिए, कृपया एक छोटा विज्ञापन देखें। यह हमें What2Eat में सुधार जारी रखने में मदद करता है।',
        'adDialogInfo': '"विज्ञापन देखें" दबाने के बाद विज्ञापन दिखाई देगा',
        'watchAdButton': 'विज्ञापन देखें',
        'cancelButton': 'रद्द करें',
    },
    'id': {
        'adDialogTitle': 'Terima kasih telah menggunakan What2Eat!',
        'adDialogMessage': 'Untuk menjaga aplikasi ini gratis, silakan tonton iklan singkat. Ini membantu kami terus meningkatkan What2Eat.',
        'adDialogInfo': 'Iklan akan ditampilkan setelah Anda menekan "Tonton Iklan"',
        'watchAdButton': 'Tonton Iklan',
        'cancelButton': 'Batal',
    },
    'ar': {
        'adDialogTitle': 'شكراً لاستخدام What2Eat!',
        'adDialogMessage': 'للحفاظ على هذا التطبيق مجانياً، يرجى مشاهدة إعلان قصير. يساعدنا هذا في الاستمرار في تحسين What2Eat.',
        'adDialogInfo': 'سيظهر الإعلان بعد الضغط على "مشاهدة الإعلان"',
        'watchAdButton': 'مشاهدة الإعلان',
        'cancelButton': 'إلغاء',
    },
    'tr': {
        'adDialogTitle': 'What2Eat\'i kullandığınız için teşekkürler!',
        'adDialogMessage': 'Bu uygulamayı ücretsiz tutmak için lütfen kısa bir reklam izleyin. Bu, What2Eat\'i geliştirmeye devam etmemize yardımcı olur.',
        'adDialogInfo': '"Reklamı İzle"ye bastıktan sonra reklam gösterilecek',
        'watchAdButton': 'Reklamı İzle',
        'cancelButton': 'İptal',
    },
    'pl': {
        'adDialogTitle': 'Dziękujemy za korzystanie z What2Eat!',
        'adDialogMessage': 'Aby utrzymać tę aplikację jako darmową, obejrzyj krótką reklamę. To pomaga nam nadal ulepszać What2Eat.',
        'adDialogInfo': 'Reklama zostanie wyświetlona po naciśnięciu "Obejrzyj Reklamę"',
        'watchAdButton': 'Obejrzyj Reklamę',
        'cancelButton': 'Anuluj',
    },
    'nl': {
        'adDialogTitle': 'Bedankt voor het gebruik van What2Eat!',
        'adDialogMessage': 'Om deze app gratis te houden, bekijk alstublieft een korte advertentie. Dit helpt ons What2Eat te blijven verbeteren.',
        'adDialogInfo': 'Advertentie wordt weergegeven na het drukken op "Advertentie Bekijken"',
        'watchAdButton': 'Advertentie Bekijken',
        'cancelButton': 'Annuleren',
    },
    'sv': {
        'adDialogTitle': 'Tack för att du använder What2Eat!',
        'adDialogMessage': 'För att hålla denna app gratis, titta på en kort annons. Detta hjälper oss att fortsätta förbättra What2Eat.',
        'adDialogInfo': 'Annonsen visas efter att du trycker på "Titta på Annons"',
        'watchAdButton': 'Titta på Annons',
        'cancelButton': 'Avbryt',
    },
    'uk': {
        'adDialogTitle': 'Дякуємо за використання What2Eat!',
        'adDialogMessage': 'Щоб додаток залишався безкоштовним, будь ласка, перегляньте коротку рекламу. Це допомагає нам продовжувати покращувати What2Eat.',
        'adDialogInfo': 'Реклама буде показана після натискання "Переглянути Рекламу"',
        'watchAdButton': 'Переглянути Рекламу',
        'cancelButton': 'Скасувати',
    },
    'el': {
        'adDialogTitle': 'Ευχαριστούμε που χρησιμοποιείτε το What2Eat!',
        'adDialogMessage': 'Για να διατηρήσουμε αυτήν την εφαρμογή δωρεάν, παρακαλούμε δείτε μια σύντομη διαφήμιση. Αυτό μας βοηθά να συνεχίσουμε να βελτιώνουμε το What2Eat.',
        'adDialogInfo': 'Η διαφήμιση θα εμφανιστεί αφού πατήσετε "Δείτε Διαφήμιση"',
        'watchAdButton': 'Δείτε Διαφήμιση',
        'cancelButton': 'Ακύρωση',
    },
    'hu': {
        'adDialogTitle': 'Köszönjük, hogy használja a What2Eat-et!',
        'adDialogMessage': 'Az alkalmazás ingyenességének megőrzéséhez nézzen meg egy rövid hirdetést. Ez segít nekünk a What2Eat folyamatos fejlesztésében.',
        'adDialogInfo': 'A hirdetés a "Hirdetés Megtekintése" gombra kattintás után jelenik meg',
        'watchAdButton': 'Hirdetés Megtekintése',
        'cancelButton': 'Mégse',
    },
    'cs': {
        'adDialogTitle': 'Děkujeme za používání What2Eat!',
        'adDialogMessage': 'Abychom udrželi tuto aplikaci zdarma, podívejte se prosím na krátkou reklamu. To nám pomáhá pokračovat ve zlepšování What2Eat.',
        'adDialogInfo': 'Reklama se zobrazí po stisknutí "Zobrazit Reklamu"',
        'watchAdButton': 'Zobrazit Reklamu',
        'cancelButton': 'Zrušit',
    },
    'ro': {
        'adDialogTitle': 'Vă mulțumim că utilizați What2Eat!',
        'adDialogMessage': 'Pentru a păstra această aplicație gratuită, vă rugăm să vizionați o reclamă scurtă. Acest lucru ne ajută să continuăm să îmbunătățim What2Eat.',
        'adDialogInfo': 'Reclama va fi afișată după apăsarea "Vizionați Reclama"',
        'watchAdButton': 'Vizionați Reclama',
        'cancelButton': 'Anulare',
    },
    'ms': {
        'adDialogTitle': 'Terima kasih kerana menggunakan What2Eat!',
        'adDialogMessage': 'Untuk mengekalkan aplikasi ini percuma, sila tonton iklan pendek. Ini membantu kami terus meningkatkan What2Eat.',
        'adDialogInfo': 'Iklan akan dipaparkan selepas anda menekan "Tonton Iklan"',
        'watchAdButton': 'Tonton Iklan',
        'cancelButton': 'Batal',
    },
}

# Directory containing .arb files
arb_dir = 'lib/l10n'

# Process each language file
for lang_code, strings in translations.items():
    arb_file = os.path.join(arb_dir, f'app_{lang_code}.arb')

    if not os.path.exists(arb_file):
        print(f'Warning: {arb_file} not found, skipping...')
        continue

    # Read existing ARB file
    with open(arb_file, 'r', encoding='utf-8') as f:
        data = json.load(f)

    # Add new strings
    data.update(strings)

    # Write back to file with proper formatting
    with open(arb_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    print(f'Updated {arb_file}')

print('\nAll localization files updated successfully!')
print('Run: flutter pub get')
