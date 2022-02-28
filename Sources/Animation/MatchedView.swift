import SwiftUI

struct MatchedView: View {
    @Namespace var namespace
    @State var show = false
    var body: some View {
        ZStack {
            if !show {
                VStack {
                    
                    Text("SwiftUI")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("20 sections - 3 hours".uppercased())
                        .font(.footnote.weight(.semibold))
                        .matchedGeometryEffect(id: "subtitle", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Build an iOS app for iOS 15 with custom layouts, animations and ...")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "text", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red.matchedGeometryEffect(id: "background", in: namespace))
                .padding(20)
            } else {
                VStack {
                    Spacer()
                    Text("Build an iOS app for iOS 15 with custom layouts, animations and ...")
                                .font(.footnote)
                                .matchedGeometryEffect(id: "text", in: namespace)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    Text("20 sections - 3 hours".uppercased())
                        .font(.footnote.weight(.semibold))
                        .matchedGeometryEffect(id: "subtitle", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("SwiftUI")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                   
                }
                .padding(20)
                .foregroundColor(.black)
                .background(Color.blue.matchedGeometryEffect(id: "background", in: namespace))
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}


struct MatchedViewPreview: PreviewProvider {
    static var previews: some View {
        MatchedView().ignoresSafeArea()
    }
}
