// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(data) => "${data}";

  static String m1(quantidade) => "您确定要删除 ${quantidade} 个项目吗？此操作无法撤销。";

  static String m2(quantidade) => "您确定要删除 ${quantidade} 个个人资料吗？此操作无法撤销。";

  static String m3(day, month, year) => "到期：${day}/${month}/${year}";

  static String m4(day, month, year) => "签发：${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} 个已选择', other: '${count} 个已选择')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip": MessageLookupByLibrary.simpleMessage("添加新项目"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("添加照片"),
        "apagar": MessageLookupByLibrary.simpleMessage("清除"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("应用"),
        "buscarPerfil": MessageLookupByLibrary.simpleMessage("搜索个人资料..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("取消"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("关闭"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("分享"),
        "config": MessageLookupByLibrary.simpleMessage("设置"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("确认"),
        "confirmarExclusaoItems": MessageLookupByLibrary.simpleMessage("确认删除"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("复制编号"),
        "copyPasswordTooltip": MessageLookupByLibrary.simpleMessage("复制密码"),
        "createDocumentOption": MessageLookupByLibrary.simpleMessage("创建文档"),
        "createFolderOption": MessageLookupByLibrary.simpleMessage("创建文件夹"),
        "createPasswordOption": MessageLookupByLibrary.simpleMessage("创建密码"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("签发日期"),
        "dataVencimento": MessageLookupByLibrary.simpleMessage("到期日期"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("删除选中项目"),
        "digiteNomePerfil": MessageLookupByLibrary.simpleMessage("请输入个人资料名称"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("请输入名称"),
        "documentNameLabel": MessageLookupByLibrary.simpleMessage("文档名称*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("编号已复制"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("编号*"),
        "documentoCadastrado": MessageLookupByLibrary.simpleMessage("文档已保存"),
        "documentsFilterLabel": MessageLookupByLibrary.simpleMessage("文档"),
        "editPasswordTitle": MessageLookupByLibrary.simpleMessage("编辑密码"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("请输入编号"),
        "excluir": MessageLookupByLibrary.simpleMessage("删除"),
        "excluirPerfil": MessageLookupByLibrary.simpleMessage("删除个人资料"),
        "expirationDateDisplay": m3,
        "expirationDateLabel": MessageLookupByLibrary.simpleMessage("到期日期"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("收藏"),
        "filterByTypesTitle": MessageLookupByLibrary.simpleMessage("按类型筛选"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("筛选器"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("文件夹已创建"),
        "folderNameLabel": MessageLookupByLibrary.simpleMessage("文件夹名称"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("文件夹"),
        "hidePasswordsTooltip": MessageLookupByLibrary.simpleMessage("隐藏密码"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("签发日期"),
        "issuingBodyLabel": MessageLookupByLibrary.simpleMessage("签发机构"),
        "limpar": MessageLookupByLibrary.simpleMessage("清空"),
        "lingua": MessageLookupByLibrary.simpleMessage("语言"),
        "loadingData": MessageLookupByLibrary.simpleMessage("正在加载..."),
        "lowercaseLettersLabel": MessageLookupByLibrary.simpleMessage("小写字母"),
        "markFavoriteTooltip": MessageLookupByLibrary.simpleMessage("标记为收藏"),
        "newDocumentTitle": MessageLookupByLibrary.simpleMessage("新建文档"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("新建文件夹"),
        "newPasswordTitle": MessageLookupByLibrary.simpleMessage("新建密码"),
        "noItemsToShow": MessageLookupByLibrary.simpleMessage("没有可显示的项目。"),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("新建个人资料"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("数字"),
        "numero": MessageLookupByLibrary.simpleMessage("编号"),
        "orgao": MessageLookupByLibrary.simpleMessage("机构"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("密码已复制"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("密码"),
        "passwordNameLabel": MessageLookupByLibrary.simpleMessage("密码名称"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("密码已保存"),
        "passwordsFilterLabel": MessageLookupByLibrary.simpleMessage("密码"),
        "perfilCadastrado": MessageLookupByLibrary.simpleMessage("个人资料已保存"),
        "perfilExiste": MessageLookupByLibrary.simpleMessage("个人资料已存在"),
        "perfilNaoEncontrado": MessageLookupByLibrary.simpleMessage("未找到个人资料"),
        "perfis": MessageLookupByLibrary.simpleMessage("个人资料"),
        "randomPasswordText": MessageLookupByLibrary.simpleMessage("随机密码"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("删除照片"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("保存"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("搜索"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("搜索..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("请选择一个项目"),
        "selectedItemsCount": m5,
        "semPerfis": MessageLookupByLibrary.simpleMessage("未创建个人资料"),
        "showPasswordsTooltip": MessageLookupByLibrary.simpleMessage("显示密码"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("长度"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("特殊字符 (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage("目标必须是用户或文件夹"),
        "uppercaseLettersLabel": MessageLookupByLibrary.simpleMessage("大写字母"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("未找到用户"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("您想创建什么？"),
        "writeANameNotification": MessageLookupByLibrary.simpleMessage("请输入名称"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("请输入密码")
      };
}
