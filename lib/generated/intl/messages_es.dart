// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "¿Realmente desea eliminar ${quantidade} item(s)? Esta acción no se puede deshacer.";

  static String m2(quantidade) =>
      "¿Realmente desea eliminar ${quantidade} perfil(es)? Esta acción no se puede deshacer.";

  static String m3(day, month, year) => "Vencimiento: ${day}/${month}/${year}";

  static String m4(day, month, year) => "Emisión: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} seleccionado', other: '${count} seleccionados')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Agregar nuevo ítem"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("Agregar fotos"),
        "apagar": MessageLookupByLibrary.simpleMessage("Borrar"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Aplicar"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Buscar perfil..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Cerrar"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Compartir"),
        "config": MessageLookupByLibrary.simpleMessage("Configuraciones"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Confirmar eliminación"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Copiar número"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Copiar contraseña"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Crear documento"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Crear carpeta"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Crear contraseña"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("Fecha de emisión"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("Fecha de vencimiento"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip": MessageLookupByLibrary.simpleMessage(
            "Eliminar ítems seleccionados"),
        "digiteNomePerfil": MessageLookupByLibrary.simpleMessage(
            "Escriba el nombre del perfil"),
        "digiteumNome":
            MessageLookupByLibrary.simpleMessage("Escriba un nombre"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Nombre del documento*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Documento copiado"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Número*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Documento registrado"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Documentos"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Editar contraseña"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Escriba un número"),
        "excluir": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Eliminar perfil(es)"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Fecha de vencimiento"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Favorito"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Filtrar por tipos"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Filtros"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Carpeta creada"),
        "folderNameLabel":
            MessageLookupByLibrary.simpleMessage("Nombre de la carpeta"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Carpetas"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Ocultar contraseñas"),
        "issueDateDisplay": m4,
        "issueDateLabel":
            MessageLookupByLibrary.simpleMessage("Fecha de emisión"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Órgano expedidor"),
        "limpar": MessageLookupByLibrary.simpleMessage("Limpiar"),
        "lingua": MessageLookupByLibrary.simpleMessage("Idioma"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Cargando..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Letras minúsculas"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Marcar como favorito"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("Nuevo documento"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("Nueva carpeta"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
        "noItemsToShow":
            MessageLookupByLibrary.simpleMessage("No hay ítems para mostrar."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("Nuevo perfil"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Números"),
        "numero": MessageLookupByLibrary.simpleMessage("Número"),
        "orgao": MessageLookupByLibrary.simpleMessage("Órgano"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Contraseña copiada"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("Nombre de la contraseña"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Contraseña registrada"),
        "passwordsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Contraseñas"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Perfil registrado"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("El perfil ya existe"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Perfil no encontrado"),
        "perfis": MessageLookupByLibrary.simpleMessage("Perfiles"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Contraseña aleatoria"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Quitar foto"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Guardar"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Buscar"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Buscar..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Seleccione algún ítem"),
        "selectedItemsCount": m5,
        "semPerfis":
            MessageLookupByLibrary.simpleMessage("Ningún perfil creado"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Mostrar contraseñas"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Tamaño"),
        "specialCharactersLabel": MessageLookupByLibrary.simpleMessage(
            "Caracteres especiales (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "El objetivo debe ser Usuario o Carpeta"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Letras mayúsculas"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Usuario no encontrado"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("¿Qué desea crear?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Escriba un nombre"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Escriba una contraseña")
      };
}
