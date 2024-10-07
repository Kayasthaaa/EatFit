// ignore_for_file: unused_local_variable

String? validateNumber(String? text) {
  // ? this is validation for phone numbers where alphabets and special charatcers are not allowede
  if (text == null || text.isEmpty) {
    return 'Required';
  } else if (text.contains(RegExp(r'[a-z]')) ||
      text.contains(RegExp(r'[#?!@$_+%^&*-]')) ||
      text.contains(r'[A-Z]')) {
    return 'Invalid Input';
  } else if (text.length < 10 || text.length > 10) {
    return 'Number should be of 10 digits';
  }

  return null;
}

// ? this is validation for passwords where minimum length must be 6
String? validatePassword(String? text) {
  if (text == null || text.isEmpty) {
    return 'Required';
  } else if (text.length < 8) {
    return 'Minimum Length Should be 8';
  }
  return null;
}

// ? this is validation for state, ex: AM and PM
String? validateState(String? value) {
  // Allow empty input
  if (value == null || value.isEmpty) {
    return null;
  } else if (value != 'AM' && value != 'PM' && value != 'am' && value != 'pm') {
    return 'invalid';
  }

  return null;
}

// ? this is validation for state, ex: AM and PM
String? validateNames(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required';
  } else if (value.contains(
        RegExp(r'[0-9]'),
      ) ||
      value.contains(
        RegExp(r'[#?!@$%^&*-]'),
      )) {
    'Invalid Input';
  }
  return null;
}

String? validateEmptyName(String? value) {
  if (value!.contains(
        RegExp(r'[0-9]'),
      ) ||
      value.contains(
        RegExp(r'[#?!@$%^&*-]'),
      )) {
    'Invalid Input';
  }
  return null;
}

//? this validation is for those fields which should not be empty but can contain any details
String? validateFields(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required';
  }
  return null;
}

String? validateNumberProfile(String? text) {
  // ? this is validation for phone numbers where alphabets and special charatcers are not allowede
  if (text!.contains(RegExp(r'[a-z]')) ||
      text.contains(RegExp(r'[#?!_+@$%^&*-]')) ||
      text.contains(r'[A-Z]')) {
    return 'Invalid Input';
  } else if (text.length < 10 || text.length > 10) {
    return 'Number should be of 10 digits';
  }

  return null;
}

String? validateInteger(String? text) {
  if (text == null || text.isEmpty) {
    return 'Required';
  } else if (text.contains(RegExp(r'[a-z]')) ||
      text.contains(RegExp(r'[#?!_+@$%^&*-]')) ||
      text.contains(r'[A-Z]')) {
    return 'Invalid Input';
  }

  return null;
}

String? validateUserName(String? text) {
  // ? this is validation for names
  if (text!.contains(RegExp(r'[0-9]')) ||
      text.contains(
        RegExp(r'[#?!@$%^&*-]'),
      )) {
    return 'Invalid Input';
  } else if (text.isEmpty) {
    return 'Required';
  }

  return null;
}

String? time(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a time"; // Validation for empty input
  }

  // Add leading zero if hour part is single digit
  if (value.split(':').first.length == 1) {
    value = '0$value';
  }

  final RegExp timeRegExp = RegExp(r'^(0[1-9]|1[0-2]):([0-5][0-9])$');
  if (!timeRegExp.hasMatch(value)) {
    return "Invalid time format (hh:mm)";
  }

  // Validate for only numbers
  if (value.contains(RegExp(r'[^\d:]'))) {
    return "Only numbers and colon (:) are allowed";
  }

  // Separate hours and minutes
  final List<int> timeParts = value.split(':').map(int.parse).toList();
  if (timeParts[1] < 0 || timeParts[1] > 59) {
    return "Invalid minutes (00-59)";
  }

  return null; // Return null for valid input
}

String? validateInt(String? text) {
  // ? this is validation for int
  if (text!.contains(RegExp(r'[a-z]')) ||
      text.contains(RegExp(r'[#?!_+@$%^&*-]')) ||
      text.contains(r'[A-Z]') ||
      text.contains(RegExp(r'^([01]?[0-9]|2[0-3])[0-5][0-9]$'))) {
    return 'Invalid Input';
  } else if (text.isEmpty) {
    return 'Required';
  }

  return null;
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}

extension NumX on num {
  Duration get microseconds => Duration(microseconds: toInt());

  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());

  Duration get minutes => Duration(minutes: toInt());

  Duration get hours => Duration(hours: toInt());

  Duration get days => Duration(days: toInt());

  Future get delayedMicroSeconds async => Future.delayed(toInt().microseconds);

  Future get delayedMilliSeconds async => Future.delayed(toInt().milliseconds);

  Future get delayedSeconds async => Future.delayed(toInt().seconds);

  Future get delayedMinutes async => Future.delayed(toInt().minutes);

  Future get delayedHours async => Future.delayed(toInt().hours);
}
