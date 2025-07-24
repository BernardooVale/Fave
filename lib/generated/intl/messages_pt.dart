// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(data) => "${data}";

  static String m1(quantidade) =>
      "Deseja realmente excluir ${quantidade} items(s)? Esta ação não pode ser desfeita.";

  static String m2(quantidade) =>
      "Deseja realmente excluir ${quantidade} perfil(s)? Esta ação não pode ser desfeita.";

  static String m3(day, month, year) => "Vencimento: ${day}/${month}/${year}";

  static String m4(day, month, year) => "Emissão: ${day}/${month}/${year}";

  static String m5(count) =>
      "${Intl.plural(count, one: '${count} selecionado', other: '${count} selecionados')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewItemTooltip":
            MessageLookupByLibrary.simpleMessage("Adicionar novo item"),
        "addPhotosText":
            MessageLookupByLibrary.simpleMessage("Adicionar fotos"),
        "apagar": MessageLookupByLibrary.simpleMessage("Apagar"),
        "applyButtonText": MessageLookupByLibrary.simpleMessage("Aplicar"),
        "buscarPerfil":
            MessageLookupByLibrary.simpleMessage("Buscar perfil..."),
        "cancelButtonText": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "closeButtonTooltip": MessageLookupByLibrary.simpleMessage("Fechar"),
        "compartilhar": MessageLookupByLibrary.simpleMessage("Compartilhar"),
        "config": MessageLookupByLibrary.simpleMessage("Configurações"),
        "confirmButtonText": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmarExclusaoItems":
            MessageLookupByLibrary.simpleMessage("Confirmar exclusão"),
        "copyDocumentNumberTooltip":
            MessageLookupByLibrary.simpleMessage("Copiar número"),
        "copyPasswordTooltip":
            MessageLookupByLibrary.simpleMessage("Copiar senha"),
        "createDocumentOption":
            MessageLookupByLibrary.simpleMessage("Criar Documento"),
        "createFolderOption":
            MessageLookupByLibrary.simpleMessage("Criar Pasta"),
        "createPasswordOption":
            MessageLookupByLibrary.simpleMessage("Criar Senha"),
        "dataEmissao": MessageLookupByLibrary.simpleMessage("Data de emissão"),
        "dataVencimento":
            MessageLookupByLibrary.simpleMessage("Data de vencimento"),
        "dateDisplay": m0,
        "deleteItemsConfirm": m1,
        "deleteProfilesConfirm": m2,
        "deleteSelectedItemsTooltip":
            MessageLookupByLibrary.simpleMessage("Excluir itens selecionados"),
        "digiteNomePerfil":
            MessageLookupByLibrary.simpleMessage("Digite o nome do perfil"),
        "digiteumNome": MessageLookupByLibrary.simpleMessage("Digite um nome"),
        "documentNameLabel":
            MessageLookupByLibrary.simpleMessage("Nome do documento*"),
        "documentNumberCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Documento copiado"),
        "documentNumberLabel": MessageLookupByLibrary.simpleMessage("Número*"),
        "documentoCadastrado":
            MessageLookupByLibrary.simpleMessage("Documento cadastrado"),
        "documentsFilterLabel":
            MessageLookupByLibrary.simpleMessage("Documentos"),
        "editPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Editar Senha"),
        "escrevaNumeroNotificacao":
            MessageLookupByLibrary.simpleMessage("Escreva um número"),
        "excluir": MessageLookupByLibrary.simpleMessage("Excluir"),
        "excluirPerfil":
            MessageLookupByLibrary.simpleMessage("Excluir perfil(s)"),
        "expirationDateDisplay": m3,
        "expirationDateLabel":
            MessageLookupByLibrary.simpleMessage("Data vencimento"),
        "favoriteTooltip": MessageLookupByLibrary.simpleMessage("Favorito"),
        "filterByTypesTitle":
            MessageLookupByLibrary.simpleMessage("Filtrar por tipos"),
        "filtersButtonLabel": MessageLookupByLibrary.simpleMessage("Filtros"),
        "folderCreatedNotification":
            MessageLookupByLibrary.simpleMessage("Pasta criada"),
        "folderNameLabel":
            MessageLookupByLibrary.simpleMessage("Nome da pasta"),
        "foldersFilterLabel": MessageLookupByLibrary.simpleMessage("Pastas"),
        "hidePasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Ocultar senhas"),
        "issueDateDisplay": m4,
        "issueDateLabel": MessageLookupByLibrary.simpleMessage("Data emissão"),
        "issuingBodyLabel":
            MessageLookupByLibrary.simpleMessage("Órgão expedidor"),
        "limpar": MessageLookupByLibrary.simpleMessage("Limpar"),
        "lingua": MessageLookupByLibrary.simpleMessage("Idioma"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Carregando..."),
        "lowercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Letras minúsculas"),
        "markFavoriteTooltip":
            MessageLookupByLibrary.simpleMessage("Marcar favorito"),
        "newDocumentTitle":
            MessageLookupByLibrary.simpleMessage("Novo Documento"),
        "newFolderTitle": MessageLookupByLibrary.simpleMessage("Nova Pasta"),
        "newPasswordTitle": MessageLookupByLibrary.simpleMessage("Nova Senha"),
        "noItemsToShow":
            MessageLookupByLibrary.simpleMessage("Nenhum item para mostrar."),
        "novoPerfil": MessageLookupByLibrary.simpleMessage("Novo perfil"),
        "numbersLabel": MessageLookupByLibrary.simpleMessage("Números"),
        "numero": MessageLookupByLibrary.simpleMessage("Numero"),
        "orgao": MessageLookupByLibrary.simpleMessage("Órgão"),
        "passwordCopiedNotification":
            MessageLookupByLibrary.simpleMessage("Senha copiada"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Senha"),
        "passwordNameLabel":
            MessageLookupByLibrary.simpleMessage("Nome da Senha"),
        "passwordRegisteredNotification":
            MessageLookupByLibrary.simpleMessage("Senha cadastrada"),
        "passwordsFilterLabel": MessageLookupByLibrary.simpleMessage("Senhas"),
        "perfilCadastrado":
            MessageLookupByLibrary.simpleMessage("Perfil cadastrado"),
        "perfilExiste":
            MessageLookupByLibrary.simpleMessage("Perfil já existe"),
        "perfilNaoEncontrado":
            MessageLookupByLibrary.simpleMessage("Perfil não encontrado"),
        "perfis": MessageLookupByLibrary.simpleMessage("Perfis"),
        "randomPasswordText":
            MessageLookupByLibrary.simpleMessage("Senha aleatória"),
        "removePhotoButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Remover foto"),
        "saveButtonText": MessageLookupByLibrary.simpleMessage("Salvar"),
        "searchButtonText": MessageLookupByLibrary.simpleMessage("Buscar"),
        "searchHintText": MessageLookupByLibrary.simpleMessage("Pesquisar..."),
        "selectAnItemNotification":
            MessageLookupByLibrary.simpleMessage("Selecione algum item"),
        "selectedItemsCount": m5,
        "semPerfis":
            MessageLookupByLibrary.simpleMessage("Nenhum perfil criado"),
        "showPasswordsTooltip":
            MessageLookupByLibrary.simpleMessage("Mostrar senhas"),
        "sizeLabel": MessageLookupByLibrary.simpleMessage("Tamanho"),
        "specialCharactersLabel": MessageLookupByLibrary.simpleMessage(
            "Caracteres especiais (!@#\$%)"),
        "targetMustBeUserOrFolderException":
            MessageLookupByLibrary.simpleMessage(
                "target deve ser Usuario ou Pasta"),
        "uppercaseLettersLabel":
            MessageLookupByLibrary.simpleMessage("Letras maiúsculas"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Usuário não encontrado"),
        "whatDoYouWantToCreateTitle":
            MessageLookupByLibrary.simpleMessage("O que deseja criar?"),
        "writeANameNotification":
            MessageLookupByLibrary.simpleMessage("Escreva um nome"),
        "writeAPasswordNotification":
            MessageLookupByLibrary.simpleMessage("Escreva uma senha")
      };
}
