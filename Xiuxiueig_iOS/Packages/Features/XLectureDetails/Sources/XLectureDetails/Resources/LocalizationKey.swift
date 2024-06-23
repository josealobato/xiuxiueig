// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

enum LocalizationKey: String {

    case navigationTitle

    case titleLabel
    case titleHint
    case titleAdvice

    case categoryLabel
    case noCategory
    case categoryAdvice

    // Category Selector
    case categorySelectorTitle
    case categorySelectorCancelButtonTitle

    // Actions
    case save

    func localize() -> String {

        NSLocalizedString(rawValue, tableName: nil, bundle: Bundle.module, value: "missing translation", comment: "")
    }
}
