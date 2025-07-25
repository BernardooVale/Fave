// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Configurations`
  String get config {
    return Intl.message(
      'Configurations',
      name: 'config',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lingua {
    return Intl.message(
      'Language',
      name: 'lingua',
      desc: '',
      args: [],
    );
  }

  /// `Delete profile(s)`
  String get excluirPerfil {
    return Intl.message(
      'Delete profile(s)',
      name: 'excluirPerfil',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete {quantidade} profile(s)? This action cannot be undone.`
  String deleteProfilesConfirm(int quantidade) {
    return Intl.message(
      'Are you sure you want to delete $quantidade profile(s)? This action cannot be undone.',
      name: 'deleteProfilesConfirm',
      desc: 'Confirmation message for deleting profiles',
      args: [quantidade],
    );
  }

  /// `Are you sure you want to delete {quantidade} items(s)? This action cannot be undone.`
  String deleteItemsConfirm(int quantidade) {
    return Intl.message(
      'Are you sure you want to delete $quantidade items(s)? This action cannot be undone.',
      name: 'deleteItemsConfirm',
      desc: 'Mensagem de confirmação de exclusão de itens',
      args: [quantidade],
    );
  }

  /// `Profiles`
  String get perfis {
    return Intl.message(
      'Profiles',
      name: 'perfis',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get excluir {
    return Intl.message(
      'Delete',
      name: 'excluir',
      desc: '',
      args: [],
    );
  }

  /// `No profile created`
  String get semPerfis {
    return Intl.message(
      'No profile created',
      name: 'semPerfis',
      desc: '',
      args: [],
    );
  }

  /// `Search profile...`
  String get buscarPerfil {
    return Intl.message(
      'Search profile...',
      name: 'buscarPerfil',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get apagar {
    return Intl.message(
      'Delete',
      name: 'apagar',
      desc: '',
      args: [],
    );
  }

  /// `New profile`
  String get novoPerfil {
    return Intl.message(
      'New profile',
      name: 'novoPerfil',
      desc: '',
      args: [],
    );
  }

  /// `Write the profile name`
  String get digiteNomePerfil {
    return Intl.message(
      'Write the profile name',
      name: 'digiteNomePerfil',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get limpar {
    return Intl.message(
      'Clear',
      name: 'limpar',
      desc: '',
      args: [],
    );
  }

  /// `Profile already exists`
  String get perfilExiste {
    return Intl.message(
      'Profile already exists',
      name: 'perfilExiste',
      desc: '',
      args: [],
    );
  }

  /// `Registered profile`
  String get perfilCadastrado {
    return Intl.message(
      'Registered profile',
      name: 'perfilCadastrado',
      desc: '',
      args: [],
    );
  }

  /// `Write a name`
  String get digiteumNome {
    return Intl.message(
      'Write a name',
      name: 'digiteumNome',
      desc: '',
      args: [],
    );
  }

  /// `Confirm removal`
  String get confirmarExclusaoItems {
    return Intl.message(
      'Confirm removal',
      name: 'confirmarExclusaoItems',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get compartilhar {
    return Intl.message(
      'Share',
      name: 'compartilhar',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get numero {
    return Intl.message(
      'Number',
      name: 'numero',
      desc: '',
      args: [],
    );
  }

  /// `Institution`
  String get orgao {
    return Intl.message(
      'Institution',
      name: 'orgao',
      desc: '',
      args: [],
    );
  }

  /// `Issue date`
  String get dataEmissao {
    return Intl.message(
      'Issue date',
      name: 'dataEmissao',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get dataVencimento {
    return Intl.message(
      'Expiration date',
      name: 'dataVencimento',
      desc: '',
      args: [],
    );
  }

  /// `{data}`
  String dateDisplay(DateTime data) {
    final DateFormat dataDateFormat = DateFormat.yMd(Intl.getCurrentLocale());
    final String dataString = dataDateFormat.format(data);

    return Intl.message(
      '$dataString',
      name: 'dateDisplay',
      desc: 'Formato de exibição da data.',
      args: [dataString],
    );
  }

  /// `Edit Password`
  String get editPasswordTitle {
    return Intl.message(
      'Edit Password',
      name: 'editPasswordTitle',
      desc: 'Title of the dialog to edit a password.',
      args: [],
    );
  }

  /// `Password Name`
  String get passwordNameLabel {
    return Intl.message(
      'Password Name',
      name: 'passwordNameLabel',
      desc: 'Label for the password name input field.',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: 'Label for the password input field.',
      args: [],
    );
  }

  /// `Random password`
  String get randomPasswordText {
    return Intl.message(
      'Random password',
      name: 'randomPasswordText',
      desc: 'Text for the link or button to generate a random password.',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButtonText {
    return Intl.message(
      'Cancel',
      name: 'cancelButtonText',
      desc: 'Text for the \'Cancel\' button in edit/confirmation dialogs.',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmButtonText {
    return Intl.message(
      'Confirm',
      name: 'confirmButtonText',
      desc: 'Text for the \'Confirm\' button in edit/confirmation dialogs.',
      args: [],
    );
  }

  /// `Profile not found`
  String get perfilNaoEncontrado {
    return Intl.message(
      'Profile not found',
      name: 'perfilNaoEncontrado',
      desc: '',
      args: [],
    );
  }

  /// `Filter by types`
  String get filterByTypesTitle {
    return Intl.message(
      'Filter by types',
      name: 'filterByTypesTitle',
      desc: 'Title of the filter by item types dialog.',
      args: [],
    );
  }

  /// `Folders`
  String get foldersFilterLabel {
    return Intl.message(
      'Folders',
      name: 'foldersFilterLabel',
      desc: 'Label for the Folders filter option.',
      args: [],
    );
  }

  /// `Passwords`
  String get passwordsFilterLabel {
    return Intl.message(
      'Passwords',
      name: 'passwordsFilterLabel',
      desc: 'Label for the Passwords filter option.',
      args: [],
    );
  }

  /// `Documents`
  String get documentsFilterLabel {
    return Intl.message(
      'Documents',
      name: 'documentsFilterLabel',
      desc: 'Label for the Documents filter option.',
      args: [],
    );
  }

  /// `Apply`
  String get applyButtonText {
    return Intl.message(
      'Apply',
      name: 'applyButtonText',
      desc: 'Text for the \'Apply\' button in the filter dialog.',
      args: [],
    );
  }

  /// `Select an item`
  String get selectAnItemNotification {
    return Intl.message(
      'Select an item',
      name: 'selectAnItemNotification',
      desc:
          'Notification message displayed when the user tries to apply the filter without selecting any item.',
      args: [],
    );
  }

  /// `What do you want to create?`
  String get whatDoYouWantToCreateTitle {
    return Intl.message(
      'What do you want to create?',
      name: 'whatDoYouWantToCreateTitle',
      desc: 'Title of the item creation type selection dialog.',
      args: [],
    );
  }

  /// `Create Folder`
  String get createFolderOption {
    return Intl.message(
      'Create Folder',
      name: 'createFolderOption',
      desc: 'Option to create a new folder.',
      args: [],
    );
  }

  /// `Create Password`
  String get createPasswordOption {
    return Intl.message(
      'Create Password',
      name: 'createPasswordOption',
      desc: 'Option to create a new password.',
      args: [],
    );
  }

  /// `Create Document`
  String get createDocumentOption {
    return Intl.message(
      'Create Document',
      name: 'createDocumentOption',
      desc: 'Option to create a new document.',
      args: [],
    );
  }

  /// `Target must be User or Folder`
  String get targetMustBeUserOrFolderException {
    return Intl.message(
      'Target must be User or Folder',
      name: 'targetMustBeUserOrFolderException',
      desc: 'Exception message when the target type is invalid.',
      args: [],
    );
  }

  /// `New Folder`
  String get newFolderTitle {
    return Intl.message(
      'New Folder',
      name: 'newFolderTitle',
      desc: 'Title of the bottom sheet for creating a new folder.',
      args: [],
    );
  }

  /// `Folder name`
  String get folderNameLabel {
    return Intl.message(
      'Folder name',
      name: 'folderNameLabel',
      desc: 'Label for the folder name input field.',
      args: [],
    );
  }

  /// `Write a name`
  String get writeANameNotification {
    return Intl.message(
      'Write a name',
      name: 'writeANameNotification',
      desc: 'Notification message when a name is required and empty.',
      args: [],
    );
  }

  /// `Write a number`
  String get escrevaNumeroNotificacao {
    return Intl.message(
      'Write a number',
      name: 'escrevaNumeroNotificacao',
      desc: '',
      args: [],
    );
  }

  /// `Document created`
  String get documentoCadastrado {
    return Intl.message(
      'Document created',
      name: 'documentoCadastrado',
      desc: '',
      args: [],
    );
  }

  /// `Folder created`
  String get folderCreatedNotification {
    return Intl.message(
      'Folder created',
      name: 'folderCreatedNotification',
      desc: 'Success notification message when creating a folder.',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordTitle {
    return Intl.message(
      'New Password',
      name: 'newPasswordTitle',
      desc: 'Title of the bottom sheet for creating a new password.',
      args: [],
    );
  }

  /// `Write a password`
  String get writeAPasswordNotification {
    return Intl.message(
      'Write a password',
      name: 'writeAPasswordNotification',
      desc: 'Notification message when a password is required and empty.',
      args: [],
    );
  }

  /// `Password registered`
  String get passwordRegisteredNotification {
    return Intl.message(
      'Password registered',
      name: 'passwordRegisteredNotification',
      desc: 'Success notification message when registering a password.',
      args: [],
    );
  }

  /// `Close`
  String get closeButtonTooltip {
    return Intl.message(
      'Close',
      name: 'closeButtonTooltip',
      desc: 'Tooltip for the close button (in photo view).',
      args: [],
    );
  }

  /// `Remove photo`
  String get removePhotoButtonTooltip {
    return Intl.message(
      'Remove photo',
      name: 'removePhotoButtonTooltip',
      desc: 'Tooltip for the remove photo button (in photo view).',
      args: [],
    );
  }

  /// `New Document`
  String get newDocumentTitle {
    return Intl.message(
      'New Document',
      name: 'newDocumentTitle',
      desc: 'Title of the bottom sheet for creating a new document.',
      args: [],
    );
  }

  /// `Document name*`
  String get documentNameLabel {
    return Intl.message(
      'Document name*',
      name: 'documentNameLabel',
      desc: 'Label for the document name input field.',
      args: [],
    );
  }

  /// `Number*`
  String get documentNumberLabel {
    return Intl.message(
      'Number*',
      name: 'documentNumberLabel',
      desc: 'Label for the document number input field.',
      args: [],
    );
  }

  /// `Issuing body`
  String get issuingBodyLabel {
    return Intl.message(
      'Issuing body',
      name: 'issuingBodyLabel',
      desc: 'Label for the document\'s issuing body input field.',
      args: [],
    );
  }

  /// `Issue date`
  String get issueDateLabel {
    return Intl.message(
      'Issue date',
      name: 'issueDateLabel',
      desc: 'Text for the issue date selection button.',
      args: [],
    );
  }

  /// `Issue: {month}/{day}/{year}`
  String issueDateDisplay(int day, int month, int year) {
    return Intl.message(
      'Issue: $month/$day/$year',
      name: 'issueDateDisplay',
      desc: 'Display format for the issue date.',
      args: [day, month, year],
    );
  }

  /// `Expiration date`
  String get expirationDateLabel {
    return Intl.message(
      'Expiration date',
      name: 'expirationDateLabel',
      desc: 'Text for the expiration date selection button.',
      args: [],
    );
  }

  /// `Expires: {month}/{day}/{year}`
  String expirationDateDisplay(int day, int month, int year) {
    return Intl.message(
      'Expires: $month/$day/$year',
      name: 'expirationDateDisplay',
      desc: 'Display format for the expiration date.',
      args: [day, month, year],
    );
  }

  /// `Add photos`
  String get addPhotosText {
    return Intl.message(
      'Add photos',
      name: 'addPhotosText',
      desc: 'Text for the button/indicator to add photos.',
      args: [],
    );
  }

  /// `Save`
  String get saveButtonText {
    return Intl.message(
      'Save',
      name: 'saveButtonText',
      desc: 'Text for the \'Save\' button.',
      args: [],
    );
  }

  /// `Size`
  String get sizeLabel {
    return Intl.message(
      'Size',
      name: 'sizeLabel',
      desc: 'Label for the password size configuration.',
      args: [],
    );
  }

  /// `Lowercase letters`
  String get lowercaseLettersLabel {
    return Intl.message(
      'Lowercase letters',
      name: 'lowercaseLettersLabel',
      desc:
          'Label for the option to include lowercase letters in the password.',
      args: [],
    );
  }

  /// `Uppercase letters`
  String get uppercaseLettersLabel {
    return Intl.message(
      'Uppercase letters',
      name: 'uppercaseLettersLabel',
      desc:
          'Label for the option to include uppercase letters in the password.',
      args: [],
    );
  }

  /// `Numbers`
  String get numbersLabel {
    return Intl.message(
      'Numbers',
      name: 'numbersLabel',
      desc: 'Label for the option to include numbers in the password.',
      args: [],
    );
  }

  /// `Special characters (!@#$%)`
  String get specialCharactersLabel {
    return Intl.message(
      'Special characters (!@#\$%)',
      name: 'specialCharactersLabel',
      desc:
          'Label for the option to include special characters in the password.',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingData {
    return Intl.message(
      'Loading...',
      name: 'loadingData',
      desc: 'Text displayed while user data is being loaded.',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: 'Message displayed if the user is not found.',
      args: [],
    );
  }

  /// `{count,plural,one{{count} selected}other{{count} selected}}`
  String selectedItemsCount(int count) {
    return Intl.plural(
      count,
      one: '$count selected',
      other: '$count selected',
      name: 'selectedItemsCount',
      desc: 'App Bar title showing how many items are selected.',
      args: [count],
    );
  }

  /// `Hide passwords`
  String get hidePasswordsTooltip {
    return Intl.message(
      'Hide passwords',
      name: 'hidePasswordsTooltip',
      desc: 'Tooltip for the hide passwords button.',
      args: [],
    );
  }

  /// `Show passwords`
  String get showPasswordsTooltip {
    return Intl.message(
      'Show passwords',
      name: 'showPasswordsTooltip',
      desc: 'Tooltip for the show passwords button.',
      args: [],
    );
  }

  /// `Search...`
  String get searchHintText {
    return Intl.message(
      'Search...',
      name: 'searchHintText',
      desc: 'Hint text in the search field.',
      args: [],
    );
  }

  /// `Search`
  String get searchButtonText {
    return Intl.message(
      'Search',
      name: 'searchButtonText',
      desc: 'Text for the search button.',
      args: [],
    );
  }

  /// `No items to show.`
  String get noItemsToShow {
    return Intl.message(
      'No items to show.',
      name: 'noItemsToShow',
      desc:
          'Message displayed when there are no items to show in the filtered list.',
      args: [],
    );
  }

  /// `Favorite`
  String get favoriteTooltip {
    return Intl.message(
      'Favorite',
      name: 'favoriteTooltip',
      desc: 'Tooltip for an item marked as favorite.',
      args: [],
    );
  }

  /// `Mark favorite`
  String get markFavoriteTooltip {
    return Intl.message(
      'Mark favorite',
      name: 'markFavoriteTooltip',
      desc: 'Tooltip to mark an item as favorite.',
      args: [],
    );
  }

  /// `Copy password`
  String get copyPasswordTooltip {
    return Intl.message(
      'Copy password',
      name: 'copyPasswordTooltip',
      desc: 'Tooltip for the copy password button.',
      args: [],
    );
  }

  /// `Password copied`
  String get passwordCopiedNotification {
    return Intl.message(
      'Password copied',
      name: 'passwordCopiedNotification',
      desc: 'Notification message when a password is copied to the clipboard.',
      args: [],
    );
  }

  /// `Copy number`
  String get copyDocumentNumberTooltip {
    return Intl.message(
      'Copy number',
      name: 'copyDocumentNumberTooltip',
      desc: 'Tooltip for the copy document number button.',
      args: [],
    );
  }

  /// `Document copied`
  String get documentNumberCopiedNotification {
    return Intl.message(
      'Document copied',
      name: 'documentNumberCopiedNotification',
      desc:
          'Notification message when a document number is copied to the clipboard.',
      args: [],
    );
  }

  /// `Filters`
  String get filtersButtonLabel {
    return Intl.message(
      'Filters',
      name: 'filtersButtonLabel',
      desc: 'Label for the button to open the filters dialog.',
      args: [],
    );
  }

  /// `Delete selected items`
  String get deleteSelectedItemsTooltip {
    return Intl.message(
      'Delete selected items',
      name: 'deleteSelectedItemsTooltip',
      desc: 'Tooltip for the delete selected items button.',
      args: [],
    );
  }

  /// `Add new item`
  String get addNewItemTooltip {
    return Intl.message(
      'Add new item',
      name: 'addNewItemTooltip',
      desc: 'Tooltip for the add new item button.',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
