import SwiftUI


public extension Klug {
    
    struct CustomView<Content: View>: View {
        let content: Content

        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        public var body: some View {
            content
        }
    }
    
    enum AccessoryViewType: View {
        case password(_ action: (Bool) -> ())
        case custom(_ view: AnyView)
        case none
        
        public var body: some View {
            switch self {
            case .password(_):
                return Image(systemName: "eye.slash")
            case .custom(_):
                <#code#>
            case .none:
                return EmptyView
            }
        }
    }
    
    typealias IconView = TupleView<(Image, TextField<Text>, AccessoryViewType)>
    
    enum ViewType {
        case stack
    }
}

public extension HStack where Content == Klug.IconView {
     init(
        type: Klug.ViewType,
        @ViewBuilder content: () -> Content
    ) {
        self.init(alignment: .center, spacing: 10, content: content)
    }
}

