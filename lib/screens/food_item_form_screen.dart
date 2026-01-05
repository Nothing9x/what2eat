import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/food_item.dart';
import '../providers/category_provider.dart';
import '../widgets/emoji_picker.dart';

class FoodItemFormScreen extends StatefulWidget {
  final String categoryId;
  final FoodItem? item;

  const FoodItemFormScreen({
    super.key,
    required this.categoryId,
    this.item,
  });

  @override
  State<FoodItemFormScreen> createState() => _FoodItemFormScreenState();
}

class _FoodItemFormScreenState extends State<FoodItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  String _selectedEmoji = '🍽️';

  bool get isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController = TextEditingController(text: widget.item?.description ?? '');
    _imageUrlController = TextEditingController(text: widget.item?.imageUrl ?? '');
    _selectedEmoji = widget.item?.icon ?? '🍽️';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF221a10) : const Color(0xFFF8F7F6);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          isEditing ? AppLocalizations.of(context)!.editFoodTitle : AppLocalizations.of(context)!.addFoodTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildEmojiSelector(isDark),
            const SizedBox(height: 24),
            _buildNameField(isDark),
            const SizedBox(height: 24),
            _buildDescriptionField(isDark),
            const SizedBox(height: 24),
            _buildImageUrlField(isDark),
            const SizedBox(height: 32),
            _buildSaveButton(),
            if (isEditing) ...[
              const SizedBox(height: 12),
              _buildDeleteButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.iconLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _showEmojiPicker,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2c241b) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
            child: Row(
              children: [
                Text(_selectedEmoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 16),
                Text(
                  AppLocalizations.of(context)!.iconSelectHint,
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.foodNameLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.foodNameHint,
            filled: true,
            fillColor: isDark ? const Color(0xFF2c241b) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppLocalizations.of(context)!.foodNameRequired;
            }
            if (value.trim().length > 50) {
              return AppLocalizations.of(context)!.foodNameTooLong;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.descriptionLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.descriptionHint,
            filled: true,
            fillColor: isDark ? const Color(0xFF2c241b) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
          ),
          validator: (value) {
            if (value != null && value.trim().length > 200) {
              return AppLocalizations.of(context)!.descriptionTooLong;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildImageUrlField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.imageLinkLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _imageUrlController,
          decoration: InputDecoration(
            hintText: 'https://example.com/image.jpg',
            filled: true,
            fillColor: isDark ? const Color(0xFF2c241b) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
          ),
          validator: (value) {
            if (value != null && value.trim().isNotEmpty) {
              final uri = Uri.tryParse(value.trim());
              if (uri == null || !uri.hasScheme) {
                return AppLocalizations.of(context)!.invalidLink;
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _handleSave,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEC9213),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        isEditing ? AppLocalizations.of(context)!.updateButton : AppLocalizations.of(context)!.addButton,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return OutlinedButton(
      onPressed: _handleDelete,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: Colors.red),
      ),
      child: Text(
        AppLocalizations.of(context)!.deleteButton,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _showEmojiPicker() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EmojiPicker(
        selectedEmoji: _selectedEmoji,
        onEmojiSelected: (emoji) {
          setState(() => _selectedEmoji = emoji);
        },
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = context.read<CategoryProvider>();
      final item = FoodItem(
        id: widget.item?.id,
        categoryId: widget.categoryId,
        name: _nameController.text.trim(),
        icon: _selectedEmoji,
        description: _descriptionController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
      );

      if (isEditing) {
        await provider.updateFoodItem(widget.categoryId, item);
      } else {
        await provider.addFoodItem(widget.categoryId, item);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? AppLocalizations.of(context)!.foodUpdated : AppLocalizations.of(context)!.foodAdded),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorLabel(e.toString()))),
        );
      }
    }
  }

  Future<void> _handleDelete() async {
    // This will be handled by parent screen
    Navigator.pop(context);
  }
}
