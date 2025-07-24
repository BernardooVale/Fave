// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "Are you sure you want to delete ${quantidade} items(s)? This action cannot be undone.";

  static String m2(quantidade) =>
      "Are you sure you want to delete ${quantidade} profile(s)? This action cannot be undone.";

  static String m3(day, month, year) => "Expires: ${month}/${day}/${year}";

  static String m4(day, month, year) => "Issue: ${month}/${day}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} selected', other: '${count} selected')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Add new item"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("Add photos"),
        "apagar": MessageLookupByLibrary.simpleMessage("Delete"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Apply"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Search profile..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Cancel"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Close"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Share"),
        "config": MessageLookupByLibrary.simpleMessage("Configurations"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Confirm removal"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Copy number"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Copy password"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Create Document"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Create Folder"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Create Password"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("Issue date"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("Delete selected items"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("Write the profile name"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("Write a name"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Document name*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Document copied"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Number*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Document created"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Documents"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Edit Password"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Write a number"),
        "excluir": MessageLookupByLibrary.simpleMessage("Delete"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Delete profile(s)"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Favorite"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Filter by types"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Filters"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Folder created"),
        "folderNameLabel": MessageLookupByLibrary.simpleMessage("Folder name"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Folders"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Hide passwords"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("Issue date"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Issuing body"),
        "limpar": MessageLookupByLibrary.simpleMessage("Clear"),
        "lingua": MessageLookupByLibrary.simpleMessage("Language"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Loading..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Lowercase letters"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Mark favorite"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("New Document"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("New Folder"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "noItemsToShow":
            MessageLookupByLibrary.simpleMessage("No items to show."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("New profile"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Numbers"),
        "numero": MessageLookupByLibrary.simpleMessage("Number"),
        "orgao": MessageLookupByLibrary.simpleMessage("Institution"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Password copied"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("Password Name"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Password registered"),
        "passwordsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Passwords"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Registered profile"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("Profile already exists"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Profile not found"),
        "perfis": MessageLookupByLibrary.simpleMessage("Profiles"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Random password"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Remove photo"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Save"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Search"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Search..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Select an item"),
        "selectedItemsCount": m5,
        "semPerfis": MessageLookupByLibrary.simpleMessage("No profile created"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Show passwords"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Size"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("Special characters (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "Target must be User or Folder"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Uppercase letters"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("User not found"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("What do you want to create?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Write a name"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Write a password")
      };
}
