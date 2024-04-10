//
//  Strings.swift
//
//  AlexFofonov in 2024
//

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
enum L10n {
    /// Plural format key: "%#@Age@"
    static func ages(_ p1: Int) -> String {
        L10n.tr("Localizable", "ages", p1)
    }

    enum Base {
        /// Отменить
        static var cancel: String {
            L10n.tr("Localizable", "base.cancel")
        }

        /// Завершить
        static var complete: String {
            L10n.tr("Localizable", "base.complete")
        }

        /// Удалить
        static var delete: String {
            L10n.tr("Localizable", "base.delete")
        }

        /// Редактировать
        static var edit: String {
            L10n.tr("Localizable", "base.edit")
        }

        /// Сохранить
        static var save: String {
            L10n.tr("Localizable", "base.save")
        }

        enum Resume {
            /// Возраст
            static var age: String {
                L10n.tr("Localizable", "base.resume.age")
            }

            /// Дата рождения
            static var birthday: String {
                L10n.tr("Localizable", "base.resume.birthday")
            }

            /// Ресурс
            static var contact: String {
                L10n.tr("Localizable", "base.resume.contact")
            }

            /// Контакты
            static var contacts: String {
                L10n.tr("Localizable", "base.resume.contacts")
            }

            /// Поле
            static var field: String {
                L10n.tr("Localizable", "base.resume.field")
            }

            /// Информация
            static var fields: String {
                L10n.tr("Localizable", "base.resume.fields")
            }

            /// Должность
            static var job: String {
                L10n.tr("Localizable", "base.resume.job")
            }

            /// Контакт
            static var link: String {
                L10n.tr("Localizable", "base.resume.link")
            }

            /// Основное
            static var main: String {
                L10n.tr("Localizable", "base.resume.main")
            }

            /// Имя
            static var name: String {
                L10n.tr("Localizable", "base.resume.name")
            }

            /// Резюме
            static var title: String {
                L10n.tr("Localizable", "base.resume.title")
            }
        }
    }

    enum Main {
        enum ConfirmationDialog {
            /// Удалить резюме
            static var deleteResume: String {
                L10n.tr("Localizable", "main.confirmation-dialog.delete-resume")
            }

            /// Редактировать резюме
            static var editResume: String {
                L10n.tr("Localizable", "main.confirmation-dialog.edit-resume")
            }
        }

        enum DeleteResumeAlert {
            /// Резюме будет стерто без возможности восстановления
            static var description: String {
                L10n.tr("Localizable", "main.delete-resume-alert.description")
            }

            /// Удаление резюме
            static var title: String {
                L10n.tr("Localizable", "main.delete-resume-alert.title")
            }
        }

        enum ResumeSection {
            /// Время создать свое резюме!
            static var empty: String {
                L10n.tr("Localizable", "main.resume-section.empty")
            }
        }

        enum Toolbar {
            /// MyRecap
            static var title: String {
                L10n.tr("Localizable", "main.toolbar.title")
            }
        }
    }

    enum ResumeEditor {
        /// Добавить контакт
        static var addContact: String {
            L10n.tr("Localizable", "resume-editor.add-contact")
        }

        /// Добавить информацию
        static var addField: String {
            L10n.tr("Localizable", "resume-editor.add-field")
        }

        /// Выбрать фото
        static var selectPhoto: String {
            L10n.tr("Localizable", "resume-editor.select-photo")
        }

        enum Toolbar {
            /// Редактор резюме
            static var title: String {
                L10n.tr("Localizable", "resume-editor.toolbar.title")
            }
        }
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        // swiftlint:disable:next nslocalizedstring_key
        let format = NSLocalizedString(key, tableName: table, bundle: BundleToken.bundle, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
