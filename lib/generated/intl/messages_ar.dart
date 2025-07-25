// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "هل تريد حقًا حذف ${quantidade} عنصر(عناصر)؟ لا يمكن التراجع عن هذا الإجراء.";

  static String m2(quantidade) =>
      "هل تريد حقًا حذف ${quantidade} ملف(ات) شخصي؟ لا يمكن التراجع عن هذا الإجراء.";

  static String m3(day, month, year) => "الانتهاء: ${day}/${month}/${year}";

  static String m4(day, month, year) => "الإصدار: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} محدد', other: '${count} محددة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("إضافة عنصر جديد"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("إضافة صور"),
        "apagar": MessageLookupByLibrary.simpleMessage("مسح"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("تطبيق"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("ابحث عن ملف شخصي..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("إغلاق"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("مشاركة"),
        "config": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("تأكيد الحذف"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("نسخ الرقم"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("نسخ كلمة المرور"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("إنشاء وثيقة"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("إنشاء مجلد"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("إنشاء كلمة مرور"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("تاريخ الإصدار"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("تاريخ الانتهاء"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("حذف العناصر المحددة"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("أدخل اسم الملف الشخصي"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("أدخل اسمًا"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("اسم الوثيقة*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("تم نسخ الرقم"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("الرقم*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("تم تسجيل الوثيقة"),
        "documentsFilterLabel": MessageLookupByLibrary.simpleMessage("الوثائق"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("تعديل كلمة المرور"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("اكتب رقمًا"),
        "excluir": MessageLookupByLibrary.simpleMessage("حذف"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("حذف الملف الشخصي(الملفات)"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("تاريخ الانتهاء"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("مفضل"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("تصفية حسب الأنواع"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("الفلاتر"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("تم إنشاء المجلد"),
        "folderNameLabel": MessageLookupByLibrary.simpleMessage("اسم المجلد"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("المجلدات"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("إخفاء كلمات المرور"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("تاريخ الإصدار"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("الجهة المُصدرة"),
        "limpar": MessageLookupByLibrary.simpleMessage("تنظيف"),
        "lingua": MessageLookupByLibrary.simpleMessage("اللغة"),
        "loadingData": MessageLookupByLibrary.simpleMessage("جار التحميل..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("أحرف صغيرة"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("وضع كمفضل"),
        "newDocumentTitle": MessageLookupByLibrary.simpleMessage("وثيقة جديدة"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("مجلد جديد"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("كلمة مرور جديدة"),
        "noItemsToShow":
            MessageLookupByLibrary.simpleMessage("لا توجد عناصر لعرضها."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("ملف شخصي جديد"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("أرقام"),
        "numero": MessageLookupByLibrary.simpleMessage("الرقم"),
        "orgao": MessageLookupByLibrary.simpleMessage("الهيئة"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("تم نسخ كلمة المرور"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("اسم كلمة المرور"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("تم تسجيل كلمة المرور"),
        "passwordsFilterLabel":
            MessageLookupByLibrary.simpleMessage("كلمات المرور"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("تم تسجيل الملف الشخصي"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("الملف الشخصي موجود بالفعل"),
        "perfilNaoEncontrado": MessageLookupByLibrary.simpleMessage(
            "لم يتم العثور على الملف الشخصي"),
        "perfis": MessageLookupByLibrary.simpleMessage("الملفات الشخصية"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("كلمة مرور عشوائية"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("إزالة الصورة"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("حفظ"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("بحث"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("بحث..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("اختر عنصرًا"),
        "selectedItemsCount": m5,
        "semPerfis":
            MessageLookupByLibrary.simpleMessage("لم يتم إنشاء أي ملف شخصي"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("إظهار كلمات المرور"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("الحجم"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("أحرف خاصة (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "يجب أن تكون الوجهة مستخدمًا أو مجلدًا"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("أحرف كبيرة"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("المستخدم غير موجود"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("ماذا تريد أن تنشئ؟"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("اكتب اسمًا"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("اكتب كلمة مرور")
      };
}
