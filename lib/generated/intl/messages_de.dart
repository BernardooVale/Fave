// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "Möchten Sie wirklich ${quantidade} Element(e) löschen? Diese Aktion kann nicht rückgängig gemacht werden.";

  static String m2(quantidade) =>
      "Möchten Sie wirklich ${quantidade} Profil(e) löschen? Diese Aktion kann nicht rückgängig gemacht werden.";

  static String m3(day, month, year) => "Ablauf: ${day}/${month}/${year}";

  static String m4(day, month, year) => "Ausgabe: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} ausgewählt', other: '${count} ausgewählt')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Neues Element hinzufügen"),
        "addPhotosText":
            MessageLookupByLibrary.simpleMessage("Fotos hinzufügen"),
        "apagar": MessageLookupByLibrary.simpleMessage("Löschen"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Anwenden"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Profil suchen..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Schließen"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Teilen"),
        "config": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("Bestätigen"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Löschen bestätigen"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Nummer kopieren"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Passwort kopieren"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Dokument erstellen"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Ordner erstellen"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Passwort erstellen"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("Ausgabedatum"),
        "dataVencimento": MessageLookupByLibrary.simpleMessage("Ablaufdatum"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip": MessageLookupByLibrary.simpleMessage(
            "Ausgewählte Elemente löschen"),
        "digiteNomePerfil": MessageLookupByLibrary.simpleMessage(
            "Geben Sie den Profilnamen ein"),
        "digiteumNome":
            MessageLookupByLibrary.simpleMessage("Geben Sie einen Namen ein"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Dokumentname*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Nummer kopiert"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Nummer*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Dokument gespeichert"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Dokumente"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Passwort bearbeiten"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Geben Sie eine Nummer ein"),
        "excluir": MessageLookupByLibrary.simpleMessage("Löschen"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Profil(e) löschen"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Ablaufdatum"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Favorit"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Nach Typ filtern"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Filter"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Ordner erstellt"),
        "folderNameLabel": MessageLookupByLibrary.simpleMessage("Ordnername"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Ordner"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Passwörter verbergen"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("Ausgabedatum"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Ausstellende Behörde"),
        "limpar": MessageLookupByLibrary.simpleMessage("Leeren"),
        "lingua": MessageLookupByLibrary.simpleMessage("Sprache"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Lade Daten..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Kleinbuchstaben"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Als Favorit markieren"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("Neues Dokument"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("Neuer Ordner"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Neues Passwort"),
        "noItemsToShow": MessageLookupByLibrary.simpleMessage(
            "Keine Elemente zum Anzeigen."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("Neues Profil"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Zahlen"),
        "numero": MessageLookupByLibrary.simpleMessage("Nummer"),
        "orgao": MessageLookupByLibrary.simpleMessage("Behörde"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Passwort kopiert"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Passwort"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("Passwortname"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Passwort gespeichert"),
        "passwordsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Passwörter"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Profil gespeichert"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("Profil existiert bereits"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Profil nicht gefunden"),
        "perfis": MessageLookupByLibrary.simpleMessage("Profile"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Zufälliges Passwort"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Foto entfernen"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Speichern"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Suchen"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Suchen..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Bitte ein Element auswählen"),
        "selectedItemsCount": m5,
        "semPerfis":
            MessageLookupByLibrary.simpleMessage("Kein Profil erstellt"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Passwörter anzeigen"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Größe"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("Sonderzeichen (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "Ziel muss ein Benutzer oder Ordner sein"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Großbuchstaben"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Benutzer nicht gefunden"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("Was möchten Sie erstellen?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Geben Sie einen Namen ein"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Geben Sie ein Passwort ein")
      };
}
