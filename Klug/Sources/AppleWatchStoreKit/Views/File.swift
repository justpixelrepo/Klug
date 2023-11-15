import SwiftUI

public struct WatchStoreContentView: View {
    
    public init(){}
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    WatchStoreContentView()
}
