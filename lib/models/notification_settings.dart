class NotificationSettings {
  final bool enabled;
  final TimeOfDay time;
  final List<int> weekdays; // 1-7 (Monday-Sunday)
  final bool onceNextDay;
  final OperationMode mode;

  NotificationSettings({
    this.enabled = false,
    this.time = const TimeOfDay(hour: 11, minute: 30),
    this.weekdays = const [1, 2, 3, 4, 5], // Mon-Fri default
    this.onceNextDay = false,
    this.mode = OperationMode.notifyOnly,
  });

  NotificationSettings copyWith({
    bool? enabled,
    TimeOfDay? time,
    List<int>? weekdays,
    bool? onceNextDay,
    OperationMode? mode,
  }) {
    return NotificationSettings(
      enabled: enabled ?? this.enabled,
      time: time ?? this.time,
      weekdays: weekdays ?? this.weekdays,
      onceNextDay: onceNextDay ?? this.onceNextDay,
      mode: mode ?? this.mode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'hour': time.hour,
      'minute': time.minute,
      'weekdays': weekdays,
      'onceNextDay': onceNextDay,
      'mode': mode.name,
    };
  }

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      enabled: json['enabled'] as bool? ?? false,
      time: TimeOfDay(
        hour: json['hour'] as int? ?? 11,
        minute: json['minute'] as int? ?? 30,
      ),
      weekdays: (json['weekdays'] as List<dynamic>?)?.cast<int>() ?? [1, 2, 3, 4, 5],
      onceNextDay: json['onceNextDay'] as bool? ?? false,
      mode: OperationMode.values.firstWhere(
        (e) => e.name == json['mode'],
        orElse: () => OperationMode.notifyOnly,
      ),
    );
  }
}

enum OperationMode {
  notifyOnly,
  autoSpin,
}

class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  String format24Hour() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String formatAmPm() {
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final period = hour >= 12 ? 'PM' : 'AM';
    return '${h.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}
