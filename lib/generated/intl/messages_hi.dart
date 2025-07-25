// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
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
  String get localeName => 'hi';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "क्या आप वाकई ${quantidade} आइटम हटाना चाहते हैं? यह कार्रवाई पूर्ववत नहीं की जा सकती।";

  static String m2(quantidade) =>
      "क्या आप वाकई ${quantidade} प्रोफ़ाइल हटाना चाहते हैं? यह कार्रवाई पूर्ववत नहीं की जा सकती।";

  static String m3(day, month, year) => "समाप्ति: ${day}/${month}/${year}";

  static String m4(day, month, year) => "जारी: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} चुना गया', other: '${count} चुने गए')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("नया आइटम जोड़ें"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("फोटो जोड़ें"),
        "apagar": MessageLookupByLibrary.simpleMessage("मिटाएँ"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("लागू करें"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल खोजें..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("रद्द करें"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("बंद करें"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("साझा करें"),
        "config": MessageLookupByLibrary.simpleMessage("सेटिंग्स"),
        "confirmButtonText":
            MessageLookupByLibrary.simpleMessage("पुष्टि करें"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("हटाने की पुष्टि करें"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("संख्या कॉपी करें"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("पासवर्ड कॉपी करें"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("दस्तावेज़ बनाएं"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("फ़ोल्डर बनाएं"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("पासवर्ड बनाएं"),
        "dataEmissao":
            MessageLookupByLibrary.simpleMessage("जारी करने की तारीख"),
        "dataVencimento": MessageLookupByLibrary.simpleMessage("समाप्ति तिथि"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("चयनित आइटम हटाएं"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल का नाम दर्ज करें"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("नाम दर्ज करें"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("दस्तावेज़ का नाम*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("संख्या कॉपी की गई"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("संख्या*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("दस्तावेज़ सहेजा गया"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("दस्तावेज़"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("पासवर्ड संपादित करें"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("एक संख्या लिखें"),
        "excluir": MessageLookupByLibrary.simpleMessage("हटाएँ"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल हटाएँ"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("समाप्ति तिथि"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("पसंदीदा"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("प्रकार से फ़िल्टर करें"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("फ़िल्टर"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("फ़ोल्डर बनाया गया"),
        "folderNameLabel":
            MessageLookupByLibrary.simpleMessage("फ़ोल्डर का नाम"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("फ़ोल्डर"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("पासवर्ड छुपाएं"),
        "issueDateDisplay": m4,
        "issueDateLabel":
            MessageLookupByLibrary.simpleMessage("जारी करने की तारीख"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("जारी करने वाला संस्था"),
        "limpar": MessageLookupByLibrary.simpleMessage("साफ़ करें"),
        "lingua": MessageLookupByLibrary.simpleMessage("भाषा"),
        "loadingData": MessageLookupByLibrary.simpleMessage("लोड हो रहा है..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("छोटे अक्षर"),
        "markFavoriteTooltip": MessageLookupByLibrary.simpleMessage(
            "पसंदीदा के रूप में चिह्नित करें"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("नया दस्तावेज़"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("नया फ़ोल्डर"),
        "newPasswordTitle": MessageLookupByLibrary.simpleMessage("नया पासवर्ड"),
        "noItemsToShow": MessageLookupByLibrary.simpleMessage(
            "कोई आइटम नहीं दिखाने के लिए।"),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("नया प्रोफ़ाइल"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("संख्याएं"),
        "numero": MessageLookupByLibrary.simpleMessage("संख्या"),
        "orgao": MessageLookupByLibrary.simpleMessage("संस्था"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("पासवर्ड कॉपी किया गया"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("पासवर्ड का नाम"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("पासवर्ड सहेजा गया"),
        "passwordsFilterLabel": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल सहेजी गई"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल पहले से मौजूद है"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("प्रोफ़ाइल नहीं मिली"),
        "perfis": MessageLookupByLibrary.simpleMessage("प्रोफाइल"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("यादृच्छिक पासवर्ड"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("फोटो हटाएं"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("सहेजें"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("खोजें"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("खोजें..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("कृपया कोई आइटम चुनें"),
        "selectedItemsCount": m5,
        "semPerfis": MessageLookupByLibrary.simpleMessage(
            "कोई प्रोफ़ाइल बनाई नहीं गई है"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("पासवर्ड दिखाएं"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("आकार"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("विशेष वर्ण (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "लक्ष्य उपयोगकर्ता या फ़ोल्डर होना चाहिए"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("बड़े अक्षर"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("उपयोगकर्ता नहीं मिला"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("आप क्या बनाना चाहते हैं?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("एक नाम लिखें"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("पासवर्ड लिखें")
      };
}
