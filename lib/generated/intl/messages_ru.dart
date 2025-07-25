// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "Вы уверены, что хотите удалить ${quantidade} элемент(ов)? Это действие невозможно отменить.";

  static String m2(quantidade) =>
      "Вы уверены, что хотите удалить ${quantidade} профиль(ей)? Это действие невозможно отменить.";

  static String m3(day, month, year) => "Истекает: ${day}/${month}/${year}";

  static String m4(day, month, year) => "Выдано: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} выбран', few: '${count} выбраны', many: '${count} выбрано', other: '${count} выбрано')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Добавить новый элемент"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("Добавить фото"),
        "apagar": MessageLookupByLibrary.simpleMessage("Удалить"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Применить"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Поиск профиля..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Отмена"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Поделиться"),
        "config": MessageLookupByLibrary.simpleMessage("Настройки"),
        "confirmButtonText":
            MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Подтвердите удаление"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Копировать номер"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Копировать пароль"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Создать документ"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Создать папку"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Создать пароль"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("Дата выдачи"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("Дата окончания"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("Удалить выбранное"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("Введите имя профиля"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("Введите имя"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Имя документа*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Номер скопирован"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Номер*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Документ сохранён"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Документы"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Редактировать пароль"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Введите номер"),
        "excluir": MessageLookupByLibrary.simpleMessage("Удалить"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Удалить профиль(и)"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Дата окончания"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Избранное"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Фильтр по типу"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Фильтры"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Папка создана"),
        "folderNameLabel": MessageLookupByLibrary.simpleMessage("Имя папки"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Папки"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Скрыть пароли"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("Дата выдачи"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Орган выдачи"),
        "limpar": MessageLookupByLibrary.simpleMessage("Очистить"),
        "lingua": MessageLookupByLibrary.simpleMessage("Язык"),
        "loadingData":
            MessageLookupByLibrary.simpleMessage("Загрузка данных..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Строчные буквы"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Отметить как избранное"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("Новый документ"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("Новая папка"),
        "newPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Новый пароль"),
        "noItemsToShow": MessageLookupByLibrary.simpleMessage(
            "Нет элементов для отображения."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("Новый профиль"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Цифры"),
        "numero": MessageLookupByLibrary.simpleMessage("Номер"),
        "orgao": MessageLookupByLibrary.simpleMessage("Орган"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Пароль скопирован"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Пароль"),
        "passwordNameLabel": MessageLookupByLibrary.simpleMessage("Имя пароля"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Пароль сохранён"),
        "passwordsFilterLabel": MessageLookupByLibrary.simpleMessage("Пароли"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Профиль сохранён"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("Профиль уже существует"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Профиль не найден"),
        "perfis": MessageLookupByLibrary.simpleMessage("Профили"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Случайный пароль"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Удалить фото"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Поиск"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Поиск..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Выберите элемент"),
        "selectedItemsCount": m5,
        "semPerfis": MessageLookupByLibrary.simpleMessage("Профили не созданы"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Показать пароли"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Длина"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("Спец. символы (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "Цель должна быть пользователем или папкой"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Прописные буквы"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Пользователь не найден"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("Что вы хотите создать?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Введите имя"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Введите пароль")
      };
}
