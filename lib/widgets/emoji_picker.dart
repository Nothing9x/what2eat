import 'package:flutter/material.dart';

class EmojiPicker extends StatelessWidget {
  final String? selectedEmoji;
  final Function(String) onEmojiSelected;

  const EmojiPicker({
    super.key,
    this.selectedEmoji,
    required this.onEmojiSelected,
  });

  static const List<String> foodEmojis = [
    '🍚', '🥖', '🍜', '🍔', '🍲', '🍕',
    '🍱', '🍛', '🍝', '🍣', '🍤', '🍥',
    '🥗', '🥙', '🥪', '🌮', '🌯', '🥘',
    '🍳', '🥞', '🧇', '🥓', '🍗', '🍖',
    '🌭', '🍟', '🍿', '🧆', '🥟', '🍢',
    '🍙', '🍘', '🍥', '🥠', '🥮', '🍡',
    '🥧', '🧁', '🍰', '🎂', '🍮', '🍭',
    '🍬', '🍫', '🍩', '🍪', '☕', '🍵',
    '🧃', '🥤', '🧋', '🍹', '🍺', '🍻',
    '🏪', '🍽️', '🥄', '🥢', '🍴', '🔪',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2d2418) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Chọn biểu tượng',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: foodEmojis.length,
              itemBuilder: (context, index) {
                final emoji = foodEmojis[index];
                final isSelected = emoji == selectedEmoji;

                return InkWell(
                  onTap: () {
                    onEmojiSelected(emoji);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEC9213).withOpacity(0.2)
                          : (isDark ? Colors.grey[800] : Colors.grey[100]),
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(
                              color: const Color(0xFFEC9213),
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Future<String?> show({
    required BuildContext context,
    String? selectedEmoji,
  }) async {
    return await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EmojiPicker(
        selectedEmoji: selectedEmoji,
        onEmojiSelected: (emoji) {}, // This will be overridden by onTap
      ),
    );
  }
}
