// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "Voulez-vous vraiment supprimer ${quantidade} élément(s) ? Cette action est irréversible.";

  static String m2(quantidade) =>
      "Voulez-vous vraiment supprimer ${quantidade} profil(s) ? Cette action est irréversible.";

  static String m3(day, month, year) => "Expiration : ${day}/${month}/${year}";

  static String m4(day, month, year) => "Émission : ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} sélectionné', other: '${count} sélectionnés')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Ajouter un nouvel élément"),
        "addPhotosText":
            MessageLookupByLibrary.simpleMessage("Ajouter des photos"),
        "apagar": MessageLookupByLibrary.simpleMessage("Effacer"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Appliquer"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Rechercher un profil..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Annuler"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Fermer"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Partager"),
        "config": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("Confirmer"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Confirmer la suppression"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Copier le numéro"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Copier le mot de passe"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Créer un document"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Créer un dossier"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Créer un mot de passe"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("Date d\'émission"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("Date d\'expiration"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip": MessageLookupByLibrary.simpleMessage(
            "Supprimer les éléments sélectionnés"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("Saisissez le nom du profil"),
        "digiteumNome":
            MessageLookupByLibrary.simpleMessage("Saisissez un nom"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Nom du document*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Numéro copié"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Numéro*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Document enregistré"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Documents"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Modifier le mot de passe"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Écrivez un numéro"),
        "excluir": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Supprimer le(s) profil(s)"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Date d\'expiration"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Favori"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Filtrer par types"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Filtres"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Dossier créé"),
        "folderNameLabel":
            MessageLookupByLibrary.simpleMessage("Nom du dossier"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Dossiers"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Masquer les mots de passe"),
        "issueDateDisplay": m4,
        "issueDateLabel":
            MessageLookupByLibrary.simpleMessage("Date d\'émission"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Organisme émetteur"),
        "limpar": MessageLookupByLibrary.simpleMessage("Effacer"),
        "lingua": MessageLookupByLibrary.simpleMessage("Langue"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Chargement..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Lettres minuscules"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Marquer comme favori"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("Nouveau document"),
        "newFolderTitle":
            MessageLookupByLibrary.simpleMessage("Nouveau dossier"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
        "noItemsToShow":
            MessageLookupByLibrary.simpleMessage("Aucun élément à afficher."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("Nouveau profil"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Nombres"),
        "numero": MessageLookupByLibrary.simpleMessage("Numéro"),
        "orgao": MessageLookupByLibrary.simpleMessage("Organisme"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Mot de passe copié"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("Nom du mot de passe"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Mot de passe enregistré"),
        "passwordsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Mots de passe"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Profil enregistré"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("Le profil existe déjà"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Profil non trouvé"),
        "perfis": MessageLookupByLibrary.simpleMessage("Profils"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Mot de passe aléatoire"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Supprimer la photo"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Enregistrer"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Rechercher"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Rechercher..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Sélectionnez un élément"),
        "selectedItemsCount": m5,
        "semPerfis": MessageLookupByLibrary.simpleMessage("Aucun profil créé"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Afficher les mots de passe"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Taille"),
        "specialCharactersLabel": MessageLookupByLibrary.simpleMessage(
            "Caractères spéciaux (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "la cible doit être un utilisateur ou un dossier"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Lettres majuscules"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Utilisateur non trouvé"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("Que souhaitez-vous créer ?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Écrivez un nom"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Écrivez un mot de passe")
      };
}
