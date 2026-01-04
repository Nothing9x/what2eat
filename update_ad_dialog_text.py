#!/usr/bin/env python3
import json
import os

# Updated ad dialog text - after ad, user must spin again
translations = {
    'en': {
        'adDialogInfo': 'After watching the ad, press the Spin button to continue',
    },
    'vi': {
        'adDialogInfo': 'Sau khi xem quảng cáo, bấm nút Quay để tiếp tục',
    },
    'zh': {
        'adDialogInfo': '观看广告后，按旋转按钮继续',
    },
    'ja': {
        'adDialogInfo': '広告を見た後、スピンボタンを押して続ける',
    },
    'ko': {
        'adDialogInfo': '광고를 본 후 회전 버튼을 눌러 계속하세요',
    },
    'es': {
        'adDialogInfo': 'Después de ver el anuncio, presiona el botón Girar para continuar',
    },
    'fr': {
        'adDialogInfo': 'Après avoir regardé la publicité, appuyez sur le bouton Tourner pour continuer',
    },
    'de': {
        'adDialogInfo': 'Nach dem Ansehen der Werbung drücken Sie die Drehen-Taste, um fortzufahren',
    },
    'th': {
        'adDialogInfo': 'หลังจากดูโฆษณา กดปุ่มหมุนเพื่อดำเนินการต่อ',
    },
    'it': {
        'adDialogInfo': 'Dopo aver visto l\'annuncio, premi il pulsante Gira per continuare',
    },
    'pt': {
        'adDialogInfo': 'Após assistir ao anúncio, pressione o botão Girar para continuar',
    },
    'ru': {
        'adDialogInfo': 'После просмотра рекламы нажмите кнопку Крутить, чтобы продолжить',
    },
    'hi': {
        'adDialogInfo': 'विज्ञापन देखने के बाद, जारी रखने के लिए स्पिन बटन दबाएं',
    },
    'id': {
        'adDialogInfo': 'Setelah menonton iklan, tekan tombol Putar untuk melanjutkan',
    },
    'ar': {
        'adDialogInfo': 'بعد مشاهدة الإعلان، اضغط على زر الدوران للمتابعة',
    },
    'tr': {
        'adDialogInfo': 'Reklamı izledikten sonra devam etmek için Döndür düğmesine basın',
    },
    'pl': {
        'adDialogInfo': 'Po obejrzeniu reklamy naciśnij przycisk Obróć, aby kontynuować',
    },
    'nl': {
        'adDialogInfo': 'Druk na het bekijken van de advertentie op de Draaien-knop om door te gaan',
    },
    'sv': {
        'adDialogInfo': 'Efter att ha tittat på annonsen, tryck på Snurra-knappen för att fortsätta',
    },
    'uk': {
        'adDialogInfo': 'Після перегляду реклами натисніть кнопку Крутити, щоб продовжити',
    },
    'el': {
        'adDialogInfo': 'Αφού δείτε τη διαφήμιση, πατήστε το κουμπί Περιστροφή για να συνεχίσετε',
    },
    'hu': {
        'adDialogInfo': 'A hirdetés megtekintése után nyomja meg a Pörgetés gombot a folytatáshoz',
    },
    'cs': {
        'adDialogInfo': 'Po shlédnutí reklamy stiskněte tlačítko Točit pro pokračování',
    },
    'ro': {
        'adDialogInfo': 'După vizionarea reclamei, apăsați butonul Învârte pentru a continua',
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

    # Update the text
    data.update(strings)

    # Write back to file with proper formatting
    with open(arb_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    print(f'Updated {arb_file}')

print('\nAll localization files updated!')
print('Run: flutter pub get')
