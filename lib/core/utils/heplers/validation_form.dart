import '../app_utils/app_strings.dart';

class ValidationForm {
  static String? phoneValidator(String? value) {
    bool isValid =
        RegExp(r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})")
            .hasMatch(value!);
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPhoneNumber;
    } else if (!isValid) {
      return AppStrings.phoneNumberNotValid;
    }
    return null;
  }

  static String? passwordValidator(String? v) {
    if (v?.isEmpty ?? true) {
      return AppStrings.pleaseEnterPassword;
    } else if (v!.length <= 5) {
      return AppStrings.passwordNotValid;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(
    String? v,
    String text,
  ) {
    if (v?.isEmpty ?? true) {
      return AppStrings.passwordNotMatch;
    } else if (text != v) {
      return AppStrings.passwordNotMatch;
    } else {
      return null;
    }
  }

  static String? nameValidator(String? v) {
    if ((v?.isEmpty ?? true)) {
      return AppStrings.pleaseEnterName;
    } else {
      // Split the name by spaces and check if it has exactly four parts
      List<String> nameParts = v!.trim().split(RegExp(r'\s+'));
      if (nameParts.length != 4) {
        return AppStrings.pleaseEnterName;
      }
    }
    return null;
  }

  static String? bankNameValidator(String? v) {
    if ((v?.isEmpty ?? true)) {
      return AppStrings.pleaseEnterBankName;
    }
    return null;
  }

  static String? bankNumberValidator(String? v) {
    if ((v?.isEmpty ?? true)) {
      return AppStrings.pleaseEnterBankNumber;
    }
    return null;
  }
  static String? addressValidator(String? v) {
    if ((v?.isEmpty ?? true)) {
      return AppStrings.pleaseEnterAddress;
    }
    return null;
  }

  static String? idNumberValidator(String? v) {
    if ((v?.isEmpty ?? true)) {
      return AppStrings.pleaseEnterIdNumber;
    } else if (v!.length != 10) {
      return AppStrings.idNumberNotValid;
    }
    return null;
  }
 static String? orderPriceValidator(String? v) {
    if ((v?.isEmpty ?? true)) {
      return AppStrings.pleaseEnterIdNumber;
    } else if (v!.length != 10) {
      return AppStrings.idNumberNotValid;
    }
    return null;
  }

  static String? dateValidator(String? date) {
    if (date?.isEmpty ?? true) {
      return AppStrings.pleaseEnterDate;
    } else {
      // Regular expression to match the date format YYYY-MM-DD
      bool isValid = RegExp(r"^\d{4}-\d{2}-\d{2}$").hasMatch(date!);
      if (!isValid) {
        return AppStrings.dateNotValid;
      }
    }
    return null;
  }

  static String? timeValidator(String? date) {
    if (date?.isEmpty ?? true) {
      return AppStrings.pleaseEnterDate;
    } 
    return null;
  }

  static String? manufactureYearValidator(String? year) {
    if (year?.isEmpty ?? true) {
      return AppStrings.pleaseEnterManufactureYear;
    }
    return null;
  }

  static String? blateAlphaValidator(String? alpha) {
    if (alpha?.isEmpty ?? true) {
      return AppStrings.pleaseEnterBlateAlpha;
    } else if (!RegExp(r"^[A-Za-z\u0600-\u06FF]+$").hasMatch(alpha!)) {
      return AppStrings.blateAlphaNotValid;
    }
    return null;
  }

  static String? blateNumberValidator(String? number) {
    if (number?.isEmpty ?? true) {
      return AppStrings.pleaseEnterBlateNumber;
    } else if (!RegExp(r"^\d+$").hasMatch(number!)) {
      return AppStrings.blateNumberNotValid;
    }
    return null;
  }

  static String? carModelValidator(String? model) {
    if (model?.isEmpty ?? true) {
      return AppStrings.pleaseEnterCarModel;
    }
    return null;
  }

  static String? carTypeValidator(String? type) {
    if (type?.isEmpty ?? true) {
      return AppStrings.pleaseEnterCarType;
    }
    return null;
  }

  static String? codeValidator(String? v, String? code) {
    if (v?.isEmpty ?? true) {
      return AppStrings.pleaseEnterCode;
    } else if (v != code) {
      return AppStrings.invalidCode;
    } else {
      return null;
    }
  }
}
