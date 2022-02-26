//
//  SwiftUIView.swift
//
//
//  Created by Evans Domina Attafuah on 16/02/2022.
//

import SwiftUI

struct Tree<A>: Identifiable {
    var value: A
    var children = [Tree<A>]()
    var id = UUID()
    
    init(_ value: A, children: [Tree<A>] = []) {
        self.value = value
        self.children = children
    }
}

let sample = Tree("Root", children: [
    .init("First Child With Some More Text"),
    .init("Second Child"),
    .init("Third"),
    .init("A fourth child", children: [
        .init("Level 3 One"),
        .init("Level 3 Two"),
        .init("Level 3 Two"),
        .init("Level 3 Two"),
    ]),
])

struct Line: Shape {
    var from: CGPoint
    var to: CGPoint
    
    func path(in rect: CGRect) -> Path {
        .init { p in
            p.move(to: from)
            p.addLine(to: to)
        }
    }
}

struct FrameKey: PreferenceKey {
    static func reduce(value: inout [UUID: CGRect], nextValue: () -> [UUID: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
    
    static var defaultValue: [UUID: CGRect] { [:] }
}

extension View {
    func measureFrame(in coordinateSpace: CoordinateSpace, id: UUID) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear.preference(key: FrameKey.self, value: [id: proxy.frame(in: coordinateSpace)])
            }
        )
    }
}

struct NodeCenter: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[HorizontalAlignment.center]
    }
}

extension HorizontalAlignment {
    static let nodeCenter = Self(NodeCenter.self)
}

extension CGRect {
    subscript(point: UnitPoint) -> CGPoint {
        CGPoint(x: minX + point.x * width, y: minY + point.y * height)
    }
}

struct Diagram<A, Node: View>: View {
    var tree: Tree<A>
    @ViewBuilder var node: (A) -> Node
    let coordinateSpace = "diagram"
    
    func computeGuideIDs() -> Set<UUID> {
        var ids: Set<UUID> = []
        let centerIdx = tree.children.count/2
        ids.insert(tree.children[centerIdx].id)
        if tree.children.count.isMultiple(of: 2) {
            ids.insert(tree.children[centerIdx - 1].id)
        }
        return ids
    }
    
    var body: some View {
        VStack(alignment: .nodeCenter, spacing: 20) {
            node(tree.value)
                .measureFrame(in: .named(coordinateSpace), id: tree.id)
            if !tree.children.isEmpty {
                let guideIDs = computeGuideIDs()
                HStack(alignment: .top, spacing: 20) {
                    ForEach(tree.children) { child in
                        let subtree = Diagram(tree: child, node: node)
                            .measureFrame(in: .named(coordinateSpace), id: child.id)
                        let alignment: HorizontalAlignment = guideIDs.contains(child.id) ? .nodeCenter : .center
                        subtree.alignmentGuide(alignment) { $0[HorizontalAlignment.center] }
                    }
                }
            }
        }
        .backgroundPreferenceValue(FrameKey.self) { frames in
            let rootFrame = frames[tree.id]!
            let childFrames: [(UUID, CGRect)] = frames.filter { $0.key != tree.id }
            ForEach(childFrames, id: \.0) { (_, childFrame) in
                Line(from: rootFrame[.bottom], to: childFrame[.top])
                    .stroke(lineWidth: 1)
            }
        }
        .coordinateSpace(name: coordinateSpace)
        .preference(key: FrameKey.self, value: [:])
    }
}

struct AdvanceAlignmentView: View {
    var body: some View {
        Diagram(tree: sample) { value in
            Text(value)
                .fixedSize()
                .padding()
                .background(.tertiary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AdvanceAlignment_Previews: PreviewProvider {
    static var previews: some View {
        AdvanceAlignmentView()
    }
}
