// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "Sei sicuro di voler eliminare ${quantidade} elemento/i? Questa azione non può essere annullata.";

  static String m2(quantidade) =>
      "Sei sicuro di voler eliminare ${quantidade} profilo/i? Questa azione non può essere annullata.";

  static String m3(day, month, year) => "Scadenza: ${day}/${month}/${year}";

  static String m4(day, month, year) => "Emissione: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} selezionato', other: '${count} selezionati')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Aggiungi nuovo elemento"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("Aggiungi foto"),
        "apagar": MessageLookupByLibrary.simpleMessage("Cancella"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Applica"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Cerca profilo..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Annulla"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Chiudi"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Condividi"),
        "config": MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("Conferma"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Conferma eliminazione"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Copia numero"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Copia password"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Crea documento"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Crea cartella"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Crea password"),
        "dataEmissao":
            MessageLookupByLibrary.simpleMessage("Data di emissione"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("Data di scadenza"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip": MessageLookupByLibrary.simpleMessage(
            "Elimina elementi selezionati"),
        "digiteNomePerfil": MessageLookupByLibrary.simpleMessage(
            "Inserisci il nome del profilo"),
        "digiteumNome":
            MessageLookupByLibrary.simpleMessage("Inserisci un nome"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Nome del documento*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Numero copiato"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Numero*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Documento salvato"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Documenti"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Modifica password"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Inserisci un numero"),
        "excluir": MessageLookupByLibrary.simpleMessage("Elimina"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Elimina profilo/i"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Data di scadenza"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Preferito"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Filtra per tipo"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Filtri"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Cartella creata"),
        "folderNameLabel":
            MessageLookupByLibrary.simpleMessage("Nome della cartella"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Cartelle"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Nascondi password"),
        "issueDateDisplay": m4,
        "issueDateLabel":
            MessageLookupByLibrary.simpleMessage("Data di emissione"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Ente emittente"),
        "limpar": MessageLookupByLibrary.simpleMessage("Pulisci"),
        "lingua": MessageLookupByLibrary.simpleMessage("Lingua"),
        "loadingData":
            MessageLookupByLibrary.simpleMessage("Caricamento dati..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Lettere minuscole"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Segna come preferito"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo documento"),
        "newFolderTitle":
            MessageLookupByLibrary.simpleMessage("Nuova cartella"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Nuova password"),
        "noItemsToShow": MessageLookupByLibrary.simpleMessage(
            "Nessun elemento da mostrare."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("Nuovo profilo"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Numeri"),
        "numero": MessageLookupByLibrary.simpleMessage("Numero"),
        "orgao": MessageLookupByLibrary.simpleMessage("Ente"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Password copiata"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("Nome della password"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Password salvata"),
        "passwordsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Profilo salvato"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("Il profilo esiste già"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Profilo non trovato"),
        "perfis": MessageLookupByLibrary.simpleMessage("Profili"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Password casuale"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Rimuovi foto"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Salva"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Cerca"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Cerca..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Seleziona un elemento"),
        "selectedItemsCount": m5,
        "semPerfis":
            MessageLookupByLibrary.simpleMessage("Nessun profilo creato"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Mostra password"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Lunghezza"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("Caratteri speciali (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "La destinazione deve essere un utente o una cartella"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Lettere maiuscole"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Utente non trovato"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("Cosa vuoi creare?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Inserisci un nome"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Inserisci una password")
      };
}
