// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "${quantidade}개의 항목을 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.";

  static String m2(quantidade) =>
      "${quantidade}개의 프로필을 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.";

  static String m3(day, month, year) => "만료: ${day}/${month}/${year}";

  static String m4(day, month, year) => "발행: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count}개 선택됨', other: '${count}개 선택됨')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip": MessageLookupByLibrary.simpleMessage("새 항목 추가"),
        "addPhotosText": MessageLookupByLibrary.simpleMessage("사진 추가"),
        "apagar": MessageLookupByLibrary.simpleMessage("삭제"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("적용"),
        "buscarPerfil": MessageLookupByLibrary.simpleMessage("프로필 검색..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("취소"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("닫기"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("공유"),
        "config": MessageLookupByLibrary.simpleMessage("설정"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("확인"),
        "confirmarExclusaoItems": MessageLookupByLibrary.simpleMessage("삭제 확인"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("번호 복사"),
        "copyPasswordTooltip": MessageLookupByLibrary.simpleMessage("비밀번호 복사"),
        "createDocumentOption": MessageLookupByLibrary.simpleMessage("문서 생성"),
        "createFolderOption": MessageLookupByLibrary.simpleMessage("폴더 생성"),
        "createPasswordOption": MessageLookupByLibrary.simpleMessage("비밀번호 생성"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("발행일"),
        "dataVencimento": MessageLookupByLibrary.simpleMessage("만료일"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("선택한 항목 삭제"),
        "digiteNomePerfil": MessageLookupByLibrary.simpleMessage("프로필 이름 입력"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("이름 입력"),
        "documentNameLabel": MessageLookupByLibrary.simpleMessage("문서 이름*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("번호가 복사되었습니다"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("번호*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("문서가 저장되었습니다"),
        "documentsFilterLabel": MessageLookupByLibrary.simpleMessage("문서"),
        "editPasswordTitle": MessageLookupByLibrary.simpleMessage("비밀번호 수정"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("번호를 입력하세요"),
        "excluir": MessageLookupByLibrary.simpleMessage("삭제"),
        "excluirPerfil": MessageLookupByLibrary.simpleMessage("프로필 삭제"),
        "expirationDateDisplay": m3,
        "expirationDateLabel": MessageLookupByLibrary.simpleMessage("만료일"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("즐겨찾기"),
        "filterByTypesTitle": MessageLookupByLibrary.simpleMessage("유형별 필터"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("필터"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("폴더가 생성되었습니다"),
        "folderNameLabel": MessageLookupByLibrary.simpleMessage("폴더 이름"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("폴더"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("비밀번호 숨기기"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("발행일"),
        "issuingBodyLabel": MessageLookupByLibrary.simpleMessage("발행 기관"),
        "limpar": MessageLookupByLibrary.simpleMessage("지우기"),
        "lingua": MessageLookupByLibrary.simpleMessage("언어"),
        "loadingData": MessageLookupByLibrary.simpleMessage("로딩 중..."),
        "lowercaseLettersLabel": MessageLookupByLibrary.simpleMessage("소문자"),
        "markFavoriteTooltip": MessageLookupByLibrary.simpleMessage("즐겨찾기로 표시"),
        "newDocumentTitle": MessageLookupByLibrary.simpleMessage("새 문서"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("새 폴더"),
        "newPasswordTitle": MessageLookupByLibrary.simpleMessage("새 비밀번호"),
        "noItemsToShow": MessageLookupByLibrary.simpleMessage("표시할 항목이 없습니다."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("새 프로필"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("숫자"),
        "numero": MessageLookupByLibrary.simpleMessage("번호"),
        "orgao": MessageLookupByLibrary.simpleMessage("기관"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("비밀번호가 복사되었습니다"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("비밀번호"),
        "passwordNameLabel": MessageLookupByLibrary.simpleMessage("비밀번호 이름"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("비밀번호가 저장되었습니다"),
        "passwordsFilterLabel": MessageLookupByLibrary.simpleMessage("비밀번호"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("프로필이 저장되었습니다"),
        "perfilExiste": MessageLookupByLibrary.simpleMessage("프로필이 이미 존재합니다"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("프로필을 찾을 수 없습니다"),
        "perfis": MessageLookupByLibrary.simpleMessage("프로필"),
        "randomPasswordText": MessageLookupByLibrary.simpleMessage("무작위 비밀번호"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("사진 제거"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("저장"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("검색"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("검색..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("항목을 선택하세요"),
        "selectedItemsCount": m5,
        "semPerfis": MessageLookupByLibrary.simpleMessage("생성된 프로필이 없습니다"),
        "showPasswordsTooltip": MessageLookupByLibrary.simpleMessage("비밀번호 표시"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("크기"),
        "specialCharactersLabel":
            MessageLookupByLibrary.simpleMessage("특수 문자 (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage("대상은 사용자 또는 폴더여야 합니다"),
        "uppercaseLettersLabel": MessageLookupByLibrary.simpleMessage("대문자"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("사용자를 찾을 수 없습니다"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("무엇을 생성하시겠습니까?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("이름을 입력하세요"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("비밀번호를 입력하세요")
      };
}
