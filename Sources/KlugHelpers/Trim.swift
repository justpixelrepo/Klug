import SwiftUI

struct Compass: View {
    @Binding var rotation: Double
    private let delta = 0.78
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.6, to: 1)
                .fill(Color.white)
            Circle()
                .trim(from: 0.6, to: 1)
                .rotationEffect(.radians(rotation))
            Circle()
                .trim(from: 0.6, to: 1)
                .rotationEffect(.radians(rotation + (delta * 1)))
            Circle()
                .trim(from: 0.6, to: 1)
                .rotationEffect(.radians(rotation + (delta * 2)))
            Circle()
                .trim(from: 0.6, to: 1)
                .rotationEffect(.radians(rotation + (delta * 3)))
            Circle()
                .trim(from: 0.6, to: 1)
                .rotationEffect(.radians(rotation + (delta * 4)))
            Circle()
                .trim(from: 0.6, to: 1)
                .rotationEffect(.radians(rotation + (delta * 5)))
        }
        .scaleEffect(0.6)
    }
}

struct CompassView: View {
    @State private var bottomDegrees = 0.78
    var body: some View {
        VStack {
            ZStack {
                Compass(rotation: $bottomDegrees)
                Text("N")
                    .offset(y: -140)
                Text("E")
                    .offset(x: 140)
                Text("S")
                    .offset(y: 140)
                Text("W")
                    .offset(x: -140)
                Text("")
            }
            .font(.title)
            Spacer()
            Text("\(bottomDegrees)")
            Slider(value: $bottomDegrees, in: 0.0...180.0)
        }
    }
}

struct TrimView: View {
    var body: some View {
        Circle()
            .trim(from: 0.5, to: 1)
            .fill(.mint)
            .shadow(color: .mint.opacity(0.5), radius: 0.4, x: 0.4, y: 0.7)
            .padding()
            .padding()
    }
}

struct TrimPath: View {
    var body: some View {
        Path { path in
            path.addLines([
                .init(x: 2, y: 1),
                .init(x: 1, y: 0),
                .init(x: 0, y: 1),
                .init(x: 1, y: 2),
                .init(x: 3, y: 0),
                .init(x: 4, y: 1),
                .init(x: 3, y: 2),
                .init(x: 2, y: 1)
            ])
        }
        .trim(from: 0.25, to: 1.0)
        .scale(50, anchor: .topLeading)
        .stroke(Color.black, lineWidth: 3)
    }
}


struct TrimView_Preview: PreviewProvider {
    static var previews: some View {
        TrimView()
        CompassView()
        TrimPath()
    }
}
