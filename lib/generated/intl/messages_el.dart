// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a el locale. All the
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
  String get localeName => 'el';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "Είστε σίγουροι ότι θέλετε να διαγράψετε ${quantidade} αντικείμενα; Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.";

  static String m2(quantidade) =>
      "Είστε σίγουροι ότι θέλετε να διαγράψετε ${quantidade} προφίλ; Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.";

  static String m3(day, month, year) => "Λήξη: ${day}/${month}/${year}";

  static String m4(day, month, year) => "Έκδοση: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} επιλεγμένο', other: '${count} επιλεγμένα')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Προσθήκη νέου αντικειμένου"),
        "addPhotosText":
            MessageLookupByLibrary.simpleMessage("Προσθήκη φωτογραφιών"),
        "apagar": MessageLookupByLibrary.simpleMessage("Διαγραφή"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Εφαρμογή"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Αναζήτηση προφίλ..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Ακύρωση"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Κλείσιμο"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Κοινή χρήση"),
        "config": MessageLookupByLibrary.simpleMessage("Ρυθμίσεις"),
        "confirmButtonText":
            MessageLookupByLibrary.simpleMessage("Επιβεβαίωση"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Επιβεβαίωση διαγραφής"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Αντιγραφή αριθμού"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Αντιγραφή κωδικού"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Δημιουργία εγγράφου"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Δημιουργία φακέλου"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Δημιουργία κωδικού"),
        "dataEmissao":
            MessageLookupByLibrary.simpleMessage("Ημερομηνία έκδοσης"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("Ημερομηνία λήξης"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip": MessageLookupByLibrary.simpleMessage(
            "Διαγραφή επιλεγμένων αντικειμένων"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("Εισάγετε όνομα προφίλ"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("Εισάγετε όνομα"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Όνομα εγγράφου*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Ο αριθμός αντιγράφηκε"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Αριθμός*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Το έγγραφο καταχωρήθηκε"),
        "documentsFilterLabel": MessageLookupByLibrary.simpleMessage("Έγγραφα"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Επεξεργασία κωδικού"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Εισάγετε έναν αριθμό"),
        "excluir": MessageLookupByLibrary.simpleMessage("Διαγραφή"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Διαγραφή προφίλ"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Ημερομηνία λήξης"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Αγαπημένα"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Φιλτράρισμα κατά τύπο"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Φίλτρα"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Ο φάκελος δημιουργήθηκε"),
        "folderNameLabel":
            MessageLookupByLibrary.simpleMessage("Όνομα φακέλου"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Φάκελοι"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Απόκρυψη κωδικών"),
        "issueDateDisplay": m4,
        "issueDateLabel":
            MessageLookupByLibrary.simpleMessage("Ημερομηνία έκδοσης"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Φορέας έκδοσης"),
        "limpar": MessageLookupByLibrary.simpleMessage("Καθαρισμός"),
        "lingua": MessageLookupByLibrary.simpleMessage("Γλώσσα"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Φόρτωση..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Πεζά γράμματα"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Σήμανση ως αγαπημένο"),
        "newDocumentTitle": MessageLookupByLibrary.simpleMessage("Νέο έγγραφο"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("Νέος φάκελος"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Νέος κωδικός"),
        "noItemsToShow": MessageLookupByLibrary.simpleMessage(
            "Δεν υπάρχουν στοιχεία για εμφάνιση."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("Νέο προφίλ"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Αριθμοί"),
        "numero": MessageLookupByLibrary.simpleMessage("Αριθμός"),
        "orgao": MessageLookupByLibrary.simpleMessage("Οργανισμός"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Ο κωδικός αντιγράφηκε"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Κωδικός"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("Όνομα κωδικού"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Ο κωδικός καταχωρήθηκε"),
        "passwordsFilterLabel": MessageLookupByLibrary.simpleMessage("Κωδικοί"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Το προφίλ καταχωρήθηκε"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("Το προφίλ υπάρχει ήδη"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Το προφίλ δεν βρέθηκε"),
        "perfis": MessageLookupByLibrary.simpleMessage("Προφίλ"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Τυχαίος κωδικός"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Αφαίρεση φωτογραφίας"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Αποθήκευση"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Αναζήτηση"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Αναζήτηση..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Επιλέξτε ένα στοιχείο"),
        "selectedItemsCount": m5,
        "semPerfis":
            MessageLookupByLibrary.simpleMessage("Δεν υπάρχουν προφίλ"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Εμφάνιση κωδικών"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Μέγεθος"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("Ειδικοί χαρακτήρες (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "Ο προορισμός πρέπει να είναι χρήστης ή φάκελος"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Κεφαλαία γράμματα"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Ο χρήστης δεν βρέθηκε"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("Τι θέλετε να δημιουργήσετε;"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Εισάγετε ένα όνομα"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Εισάγετε κωδικό")
      };
}
