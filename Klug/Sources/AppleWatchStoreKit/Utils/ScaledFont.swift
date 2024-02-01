import Foundation
import SwiftUI


struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

enum WeightFontSmallCapsType {
    case lowercase
    case uppercase
    case regular
}

struct WeightFont: ViewModifier {
    var weight: UIFont.Weight = .bold
    var width: UIFont.Width
    var size: CGFloat
    var type: WeightFontSmallCapsType = .regular
    
    func body(content: Content) -> some View {
        switch type {
        case .uppercase:
            return content
                .font(Font(UIFont.systemFont(ofSize: size, weight: weight, width: width)).uppercaseSmallCaps())
        case .lowercase:
            return content
                .font(Font(UIFont.systemFont(ofSize: size, weight: weight, width: width)).lowercaseSmallCaps())
        default:
            return content
                .font(Font(UIFont.systemFont(ofSize: size, weight: weight, width: width)))
        }
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {

    func custom(font: CustomFont, size: CGFloat) -> some View {
        return scaledFont(name: font.rawValue, size: size)
    }
    
    func condensed(size: CGFloat, type: WeightFontSmallCapsType = .regular) -> some View {
        return weighted(size: size, width: .condensed, type: type)
    }
    
    func expanded(size: CGFloat, type: WeightFontSmallCapsType = .regular) -> some View {
        return weighted(size: size, width: .expanded, type: type)
    }
    
    func compressed(size: CGFloat, type: WeightFontSmallCapsType = .regular) -> some View {
        return weighted(size: size, width: .compressed, type: type)
    }

    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
    
    func weighted(size: CGFloat, width: UIFont.Width, weight: UIFont.Weight = .regular, type: WeightFontSmallCapsType = .regular) -> some View {
        return self.modifier(WeightFont(weight: weight, width: width, size: size, type: type))
    }
}

struct LibraryContent: LibraryContentProvider {
    
    @LibraryContentBuilder
    func modifiers(base: Text) -> [LibraryItem] {
        LibraryItem(
            base.custom(font: .bold, size: 24),
            title: "Custom Font",
            category: .other
        )
    }
}

enum CustomFont: String {
    case ultralight = "AvenirNextCondensed-UltraLight"
    case regular = "AvenirNextCondensed-Regular"
    case medium = "AvenirNextCondensed-Medium"
    case bold = "AvenirNextCondensed-Bold"
    case demibold = "AvenirNextCondensed-DemiBold"
    case heavy = "AvenirNextCondensed-Heavy"
}


extension Text {
    func condensed(_ weight: Font.Weight, size: CGFloat) -> some View {
        return self.condensed(size: size, type: .regular).fontWeight(weight)
    }
    
    func condensedLowercased(_ weight: Font.Weight, size: CGFloat) -> some View {
        return self.condensed(size: size, type: .lowercase).fontWeight(weight)
    }
    
    func compressed(_ weight: Font.Weight, size: CGFloat) -> some View {
        return self.compressed(size: size, type: .regular).fontWeight(weight)
    }
    
    func compressedLowercased(_ weight: Font.Weight, size: CGFloat) -> some View {
        return self.compressed(size: size, type: .lowercase).fontWeight(weight)
    }
}
