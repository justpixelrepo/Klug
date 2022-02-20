import SwiftUI

#warning("Gradient using foregroundStyle Pre (iOS 15)")
//extension Text {
//    public func foregroundLinearGradient(
//        colors: [Color],
//        startPoint: UnitPoint,
//        endPoint: UnitPoint
//    ) -> some View
//    {
//        self.overlay {
//            LinearGradient(
//                colors: colors,
//                startPoint: startPoint,
//                endPoint: endPoint
//            )
//                .mask(
//                    self
//
//                )
//        }
//    }
//}

struct GradientTextView_Preview: PreviewProvider {
    static var previews: some View {
        Text("The simplicity of Apple.\nIn a credit card.")
            .font(Font.system(size: 46, weight: .bold))
            .multilineTextAlignment(.center)
//            .foregroundLinearGradient(
//                    colors: [.red, .blue, .green, .yellow],
//                    startPoint: .leading,
//                    endPoint: .trailing
//                )
            .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
    }
}
