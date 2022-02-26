import SwiftUI

struct PageTabView: View {
    var body: some View {
        
        TabView {
            Color.green.ignoresSafeArea()
            Color.red.ignoresSafeArea()
            Color.blue.ignoresSafeArea()
        }
        .ignoresSafeArea()
        .tabViewStyle(.page)
     
        
        
    }
}

struct TabView_Preview: PreviewProvider {
    static var previews: some View {
        PageTabView()
            .ignoresSafeArea()
    }
}
