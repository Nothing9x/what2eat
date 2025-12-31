import 'package:flutter/material.dart' hide TimeOfDay;
import 'package:flutter/material.dart' as material show TimeOfDay;
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/notification_settings.dart' as model;
import '../providers/category_provider.dart';
import '../services/notification_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  late bool _enabled;
  late model.TimeOfDay _selectedTime;
  late List<int> _selectedWeekdays;
  late bool _onceNextDay;
  late model.OperationMode _selectedMode;

  @override
  void initState() {
    super.initState();
    final provider = context.read<CategoryProvider>();
    final settings = provider.selectedCategory?.notificationSettings ?? model.NotificationSettings();

    _enabled = settings.enabled;
    _selectedTime = settings.time;
    _selectedWeekdays = List.from(settings.weekdays);
    _onceNextDay = settings.onceNextDay;
    _selectedMode = settings.mode;
  }

  Future<void> _selectTime() async {
    final material.TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: material.TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFEC9213),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = model.TimeOfDay(hour: picked.hour, minute: picked.minute);
      });
    }
  }

  void _toggleWeekday(int weekday) {
    setState(() {
      if (_selectedWeekdays.contains(weekday)) {
        _selectedWeekdays.remove(weekday);
      } else {
        _selectedWeekdays.add(weekday);
      }
      _selectedWeekdays.sort();
    });
  }

  void _saveSettings() {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.read<CategoryProvider>();
    final category = provider.selectedCategory;

    if (category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.selectCategoryFirst)),
      );
      return;
    }

    final settings = model.NotificationSettings(
      enabled: _enabled,
      time: _selectedTime,
      weekdays: _selectedWeekdays,
      onceNextDay: _onceNextDay,
      mode: _selectedMode,
    );

    provider.updateCategoryNotificationSettings(
      category.id, 
      settings,
      notificationTimeToChooseText: l10n.notificationTimeToChoose,
      notificationTodayEatText: (mealName) => l10n.notificationTodayEat(mealName),
    );

    // Debug: Check pending notifications
    NotificationService().getPendingNotifications();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.save)),
    );

    Navigator.pop(context);
  }

  Future<void> _testNotification() async {
    await NotificationService().showTestNotification();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test notification sent!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF221a10) : const Color(0xFFFFFDF5);
    final surfaceColor = isDark ? const Color(0xFF2d2418) : Colors.white;
    final primaryColor = const Color(0xFFEC9213);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Background decorations
          Positioned(
            top: -40,
            right: -40,
            child: Opacity(
              opacity: 0.1,
              child: Transform.rotate(
                angle: 0.785,
                child: Icon(
                  Icons.settings_suggest,
                  size: 150,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -40,
            child: Opacity(
              opacity: 0.1,
              child: Transform.rotate(
                angle: -0.2,
                child: Icon(
                  Icons.notifications_active,
                  size: 120,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: bgColor.withOpacity(0.8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          l10n.notificationSettings.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Schedule Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Header with toggle
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.schedule,
                                      color: Colors.blue,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.enableNotifications,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          l10n.selectTime,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: _enabled,
                                    onChanged: (value) {
                                      setState(() => _enabled = value);
                                    },
                                    activeColor: primaryColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Time Display
                              InkWell(
                                onTap: _enabled ? _selectTime : null,
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF221a10) : const Color(0xFFFFFDF5),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        l10n.selectTime.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            _selectedTime.format24Hour().split(':')[0] + ':' + _selectedTime.format24Hour().split(':')[1],
                                            style: TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w900,
                                              color: _enabled ? null : Colors.grey[400],
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            _selectedTime.hour >= 12 ? 'PM' : 'AM',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: _enabled ? Colors.grey[600] : Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (_enabled)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Weekdays
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.selectDays,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildWeekdayButton(l10n.monday.substring(0, 2), 1),
                                      _buildWeekdayButton(l10n.tuesday.substring(0, 2), 2),
                                      _buildWeekdayButton(l10n.wednesday.substring(0, 2), 3),
                                      _buildWeekdayButton(l10n.thursday.substring(0, 2), 4),
                                      _buildWeekdayButton(l10n.friday.substring(0, 2), 5),
                                      _buildWeekdayButton(l10n.saturday.substring(0, 2), 6),
                                      _buildWeekdayButton(l10n.sunday.substring(0, 2), 7),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Once next day toggle
                              Container(
                                padding: const EdgeInsets.only(top: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.event_note,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        l10n.notifyOnceOnly,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: _onceNextDay,
                                      onChanged: _enabled ? (value) {
                                        setState(() => _onceNextDay = value);
                                      } : null,
                                      activeColor: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Operation Mode Section
                        Text(
                          l10n.notificationSettings.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Notify Only Option
                        _buildModeOption(
                          mode: model.OperationMode.notifyOnly,
                          icon: Icons.notifications_active,
                          title: l10n.enableNotifications,
                          description: l10n.spinHint,
                        ),
                        const SizedBox(height: 12),
                        // Auto Spin Option
                        _buildModeOption(
                          mode: model.OperationMode.autoSpin,
                          icon: Icons.autorenew,
                          title: l10n.spinButton,
                          description: l10n.spinning,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Save Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    bgColor.withOpacity(0),
                    bgColor,
                    bgColor,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Test Notification Button
                  TextButton.icon(
                    onPressed: _testNotification,
                    icon: const Icon(Icons.notifications_active),
                    label: Text(l10n.testNotification),
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Save Button
                  ElevatedButton(
                    onPressed: _saveSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: primaryColor.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.save, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          l10n.save,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayButton(String label, int weekday) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFFEC9213);
    final isSelected = _selectedWeekdays.contains(weekday);
    final isDisabled = !_enabled || _onceNextDay;

    return InkWell(
      onTap: isDisabled ? null : () => _toggleWeekday(weekday),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDisabled
              ? (isDark ? Colors.grey[800] : Colors.grey[200])
              : (isSelected ? primaryColor : (isDark ? Colors.grey[800] : Colors.grey[200])),
          boxShadow: isSelected && !isDisabled
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDisabled
                  ? Colors.grey[500]
                  : (isSelected ? Colors.white : Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeOption({
    required model.OperationMode mode,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF2d2418) : Colors.white;
    final primaryColor = const Color(0xFFEC9213);
    final isSelected = _selectedMode == mode;

    return InkWell(
      onTap: _enabled ? () {
        setState(() => _selectedMode = mode);
      } : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor : (isDark ? Colors.grey[600]! : Colors.grey[400]!),
                  width: 2,
                ),
                color: isSelected ? primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: surfaceColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
