
import SwiftUI

// https://developer.apple.com/wwdc21/10119

struct ContentView: View {
    var body: some View {
        VStack {
            Text("WWDC 2021")
                .accessibilityAddTraits(.isHeader)
            Text("SwiftUI Accessibility")
            Text("Beyond the Basics")
            Image(systemName:
                "checkmark.seal.fill")
        }
    }
}

struct BudgetSlider: View {
    @Binding var value: Double
    var label: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                Text(value.toDollars()).bold()
            }
        }
    }
}

struct NavigationBarView: View {
    var body: some View {
        HStack {
            Text("Wallet Pal")
                .font(.largeTitle)
                .bold()

            Spacer()

            Button("Edit Budgets", action: {})
                .buttonStyle(
                    SymbolButtonStyle(
                        systemName: "slider.vertical.3"))
        }
    }
}

struct SymbolButtonStyle: ButtonStyle {
    let systemName: String

    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: systemName)
            .accessibilityRepresentation { configuration.label }
    }
}

struct Budget: Identifiable {
    var month: String
    var amount: Double

    var id: String { month }
}

struct BudgetHistoryGraph: View {
    var budgets: [Budget]

    var body: some View {
        GeometryReader { _ in
            VStack {
                Canvas { ctx, size in
                    let inset: CGFloat = 25
                    let insetSize = CGSize(width: size.width, height: size.height - inset * 2)
                    let width = insetSize.width / CGFloat(budgets.count)
                    let max = budgets.map(\.amount).max() ?? 0
                    for n in budgets.indices {
                        let x = width * CGFloat(n)
                        let height = (CGFloat(budgets[n].amount) / CGFloat(max)) * insetSize.height
                        let y = insetSize.height - height
                        let p = Path(
                            roundedRect: CGRect(
                                x: x + 2.5,
                                y: y + inset,
                                width: width - 5,
                                height: height),
                            cornerRadius: 4)
                        ctx.fill(p, with: .color(Color.green))

                        ctx.draw(Text(budgets[n].amount.toDollars()), at: CGPoint(x: x + width / 2, y: y + inset / 2))

                        ctx.draw(Text(budgets[n].month), at: CGPoint(x: x + width / 2, y: y + height + 1.5 * inset))
                    }
                }
                .accessibilityLabel("Budget History Graph")
                .accessibilityChildren {
                    HStack {
                        ForEach(budgets) { budget in
                            Rectangle()
                                .accessibilityLabel(budget.month)
                                .accessibilityValue(budget.amount.toDollars())
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(white: 0.9)))
        .padding(.horizontal)
    }
}

struct SliderShape: View {
    var value: Double

    private struct BackgroundTrack: View {
        var cornerRadius: CGFloat
        var body: some View {
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous)
                .foregroundColor(Color(white: 0.2))
        }
    }

    private struct OverlayTrack: View {
        var cornerRadius: CGFloat
        var body: some View {
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous)
                .foregroundColor(Color(white: 0.95))
        }
    }

    private struct Knob: View {
        var cornerRadius: CGFloat
        var body: some View {
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous)
                .strokeBorder(Color(white: 0.7), lineWidth: 1)
                .shadow(radius: 3)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                BackgroundTrack(cornerRadius: geometry.size.height / 2)

                OverlayTrack(cornerRadius: geometry.size.height / 2)
                    .frame(
                        width: max(geometry.size.height, geometry.size.width * CGFloat(value) + geometry.size.height / 2),
                        height: geometry.size.height)

                Knob(cornerRadius: geometry.size.height / 2)
                    .frame(
                        width: geometry.size.height,
                        height: geometry.size.height)
                    .offset(x: max(0, geometry.size.width * CGFloat(value) - geometry.size.height / 2), y: 0)
            }
        }
    }
}

struct StandardSlider: View {
    @Binding var value: Double
    var label: String

    var body: some View {
        Slider(value: $value, in: 0 ... 1) {
            Text(label)
        }
    }
}

extension Double {
    func toDollars() -> String {
        return "$\(Int(self))"
    }
}

struct ContentPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
        NavigationBarView()
    }
}
