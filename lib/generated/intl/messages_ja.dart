// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(data) => "${data}";

  static String m1(quantidade) => "本当に${quantidade}件のアイテムを削除しますか？この操作は元に戻せません。";

  static String m2(quantidade) =>
      "本当に${quantidade}件のプロフィールを削除しますか？この操作は元に戻せません。";

  static String m3(day, month, year) => "有効期限: ${day}/${month}/${year}";

  static String m4(day, month, year) => "発行日: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} 件選択', other: '${count} 件選択')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip": MessageLookupByLibrary.simpleMessage("新しいアイテムを追加"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("写真を追加"),
        "apagar": MessageLookupByLibrary.simpleMessage("消去"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("適用"),
        "buscarPerfil": MessageLookupByLibrary.simpleMessage("プロフィールを検索..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("閉じる"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("共有"),
        "config": MessageLookupByLibrary.simpleMessage("設定"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("確認"),
        "confirmarExclusaoItems": MessageLookupByLibrary.simpleMessage("削除を確認"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("番号をコピー"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("パスワードをコピー"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("ドキュメントを作成"),
        "createFolderOption": MessageLookupByLibrary.simpleMessage("フォルダを作成"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("パスワードを作成"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("発行日"),
        "dataVencimento": MessageLookupByLibrary.simpleMessage("有効期限"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("選択したアイテムを削除"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("プロフィール名を入力してください"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("名前を入力してください"),
        "documentNameLabel": MessageLookupByLibrary.simpleMessage("ドキュメント名*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("番号がコピーされました"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("番号*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("ドキュメントが登録されました"),
        "documentsFilterLabel": MessageLookupByLibrary.simpleMessage("ドキュメント"),
        "editPasswordTitle": MessageLookupByLibrary.simpleMessage("パスワード編集"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("番号を入力してください"),
        "excluir": MessageLookupByLibrary.simpleMessage("削除"),
        "excluirPerfil": MessageLookupByLibrary.simpleMessage("プロフィールを削除"),
        "expirationDateDisplay": m3,
        "expirationDateLabel": MessageLookupByLibrary.simpleMessage("有効期限"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("お気に入り"),
        "filterByTypesTitle": MessageLookupByLibrary.simpleMessage("種類でフィルター"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("フィルター"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("フォルダが作成されました"),
        "folderNameLabel": MessageLookupByLibrary.simpleMessage("フォルダ名"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("フォルダ"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("パスワードを隠す"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("発行日"),
        "issuingBodyLabel": MessageLookupByLibrary.simpleMessage("発行機関"),
        "limpar": MessageLookupByLibrary.simpleMessage("クリア"),
        "lingua": MessageLookupByLibrary.simpleMessage("言語"),
        "loadingData": MessageLookupByLibrary.simpleMessage("読み込み中..."),
        "lowercaseLettersLabel": MessageLookupByLibrary.simpleMessage("小文字"),
        "markFavoriteTooltip": MessageLookupByLibrary.simpleMessage("お気に入りに追加"),
        "newDocumentTitle": MessageLookupByLibrary.simpleMessage("新しいドキュメント"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("新しいフォルダ"),
        "newPasswordTitle": MessageLookupByLibrary.simpleMessage("新しいパスワード"),
        "noItemsToShow":
            MessageLookupByLibrary.simpleMessage("表示するアイテムがありません。"),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("新しいプロフィール"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("数字"),
        "numero": MessageLookupByLibrary.simpleMessage("番号"),
        "orgao": MessageLookupByLibrary.simpleMessage("機関"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("パスワードがコピーされました"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("パスワード"),
        "passwordNameLabel": MessageLookupByLibrary.simpleMessage("パスワード名"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("パスワードが登録されました"),
        "passwordsFilterLabel": MessageLookupByLibrary.simpleMessage("パスワード"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("プロフィールが登録されました"),
        "perfilExiste": MessageLookupByLibrary.simpleMessage("プロフィールはすでに存在します"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("プロフィールが見つかりません"),
        "perfis": MessageLookupByLibrary.simpleMessage("プロフィール"),
        "randomPasswordText": MessageLookupByLibrary.simpleMessage("ランダムパスワード"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("写真を削除"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("保存"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("検索"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("検索..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("アイテムを選択してください"),
        "selectedItemsCount": m5,
        "semPerfis": MessageLookupByLibrary.simpleMessage("プロフィールが作成されていません"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("パスワードを表示"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("サイズ"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("特殊文字 (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage("ターゲットはユーザーまたはフォルダでなければなりません"),
        "uppercaseLettersLabel": MessageLookupByLibrary.simpleMessage("大文字"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("ユーザーが見つかりません"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("何を作成しますか？"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("名前を入力してください"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("パスワードを入力してください")
      };
}
