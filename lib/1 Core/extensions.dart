import 'package:flutter/material.dart';

extension DurationFormatting on Duration {
  String integer2() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(inMinutes);
    final seconds = twoDigits(inSeconds.remainder(60));

    return [minutes, seconds].join(':');
  }

  String integer3() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(inHours);
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));

    return [hours, minutes, seconds].join(':');
  }

  String integerDynamic() {
    if (inHours > 0) {
      return integer3();
    } else {
      return integer2();
    }
  }

  String textLong2() {
    final minutes = inMinutes;
    final seconds = inSeconds.remainder(60);

    return "$minutes minutes $seconds seconds";
  }

  String textLong3() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    return "$hours hours $minutes minutes $seconds seconds";
  }

  String textLongDynamic() {
    if (inHours > 0) {
      return textLong3();
    } else {
      return textLong2();
    }
  }

  String textShort2() {
    final minutes = inMinutes;
    final seconds = inSeconds.remainder(60);

    return "${minutes}m ${seconds}s";
  }

  String textShort2hour() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);

    return "${hours}h ${minutes}m";
  }

  String textShort3() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    return "${hours}h ${minutes}m ${seconds}s";
  }

  String textShortDynamic() {
    if (inHours > 0) {
      return textShort3();
    } else {
      return textShort2();
    }
  }

  String textLongDynamicWithoutZero() {
    final seconds = inSeconds.remainder(60);
    final minutes = inMinutes.remainder(60);
    final hours = inHours;

    if (hours > 0 && minutes > 0 && seconds == 0) {
      return "${hours}h ${minutes}m";
    } else if (hours == 0 && minutes > 0 && seconds == 0) {
      return "${minutes}m";
    } else if (hours > 0 && minutes == 0 && seconds == 0) {
      return "${hours}h";
    } else if (hours == 0 && minutes == 0 && seconds > 0) {
      return "${seconds}s";
    } else if (hours == 0 && minutes > 0 && seconds > 0) {
      return "${minutes}m ${seconds}s";
    } else {
      return "${hours}h ${minutes}m ${seconds}s";
    }
  }

  String toLevel() {
    // TODO direkt her 15 saat 1 lvl olmasın. 1.1x olarak daha zorlaşsın mesela lvl atlamak veya 10,20,35,50,70,100 gibi manuel kontrol

    return "${inHours ~/ 15} LVL";
  }

  Duration operator /(int value) {
    if (inSeconds == 0) {
      return Duration.zero;
    }

    return Duration(
      hours: inHours ~/ value,
      minutes: (inMinutes ~/ value) % 60,
      seconds: (inSeconds ~/ value) % 60,
    );
  }
}

extension IntFormatting on int {
  String secondToTime() {
    final int hours = this ~/ 3600;
    final int minutes = this % 3600 ~/ 60;
    final int remainingSeconds = this % 60;

    return "${hours}h ${minutes}m ${remainingSeconds}s";
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
