import SwiftUI

struct AnimateAlignment: View {
    @State private var change = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: change ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 100)
                    .animation(.default, value: change)
                HStack {
                    Spacer()
                }
            }
            
            HStack(alignment: change ? .bottom : .top) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 100)
                    .animation(.default, value: change)
                VStack {
                    Spacer()
                }
            }.frame(maxHeight: .infinity)
            
            Button("Change") {
                change.toggle()
            }
            
            GeometryReader { gp in
                RoundedRectangle(cornerRadius:20)
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
                .position(change ? CGPoint(x: 50, y: 50) : CGPoint(x: gp.size.width - 50, y: gp.size.height - 50))
                .animation(.default, value: change)
            }
        }.font(.title)
    }
}


struct AnimateAlignmentPreview: PreviewProvider {
    static var previews: some View {
        AnimateAlignment()
    }
}
