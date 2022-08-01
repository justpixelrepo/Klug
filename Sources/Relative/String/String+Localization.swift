import Foundation

public extension String {
    private enum Constants {
        static let languageCode = "languageCode"
        static let suiteName = "group.justpixel.io"
    }

    private static let defaults = UserDefaults(suiteName: Constants.suiteName)
        ?? UserDefaults.standard

    static func localized(_ key: String, tableName: String, defaultValue: String,
                          from bundle: Bundle = .main) -> String
    {
        if let languageCode = defaults.string(forKey: Constants.languageCode) {
            if let path = bundle.path(forResource: languageCode, ofType: "lproj"),
               let bundle = Bundle(path: path)
            {
                return NSLocalizedString(
                    key,
                    tableName: tableName,
                    bundle: bundle,
                    value: defaultValue,
                    comment: ""
                )
            }
        }
        return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: defaultValue, comment: "")
    }
}
