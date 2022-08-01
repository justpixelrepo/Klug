import Foundation

private enum Constants {
    static let hostnameRegex =
        "(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})"

    static let privateIpAddress =
        "^(10(\\.(25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){3}|((172\\.(1[6-9]|2[0-9]|3[01]))|192\\.168)(\\.(25[0-5]|2[0-4][0-9]|1[0-9]{1,2}|[0-9]{1,2})){2})$"
}

public extension String {
    var isValidName: Bool {
        let trimmedString = trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.count > 2, trimmedString.contains(" ") { return true }

        return false
    }

    var isValidEmail: Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let range = NSRange(location: 0, length: count)
        let firstMatch = detector?.firstMatch(in: self, options: .reportCompletion, range: range)
        let email = firstMatch?.url?.absoluteString.replacingOccurrences(of: "mailto:", with: "")
        return firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto" && email == self
    }

    var isValidPasswordLength: Bool {
        count >= 8 && count <= 63
    }

    var isValidWebAddress: Bool {
        isValidIpAddress || isValidHostname
    }

    var isValidHostname: Bool {
        matches(pattern: Constants.hostnameRegex)
    }

    var isValidIpAddress: Bool {
        isIPv6 || isIPv4
    }

    var isIPv4: Bool {
        var socketAddress = sockaddr_in()
        return withCString(
            {
                cstring in inet_pton(AF_INET, cstring, &socketAddress.sin_addr)
            }
        ) == 1
    }

    var isIPv6: Bool {
        var socketAddress = sockaddr_in6()
        return withCString(
            {
                cstring in inet_pton(AF_INET6, cstring, &socketAddress.sin6_addr)
            }
        ) == 1
    }

    var isPrivateIPAddress: Bool {
        range(of: Constants.privateIpAddress, options: .regularExpression) != nil
    }

    func matches(pattern: String) -> Bool {
        range(
            of: pattern,
            options: .regularExpression,
            range: nil,
            locale: nil
        ) != nil
    }

    func isValidPortNumber() -> Bool {
        guard let integer = Int(self) else { return false }
        return (1...65535).contains(integer)
    }
}
