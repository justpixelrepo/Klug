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
    
    init(value: A, children: [Tree<A>] = []) {
        self.value = value
        self.children = children
    }
}

let sample = Tree(value: "Root", children: [
    .init(value: "First Child"),
    .init(value: "Second Child")
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

struct Diagram<A, Node: View>: View {
    var tree: Tree<A>
    @ViewBuilder var node: (A) -> Node
    let coordinateSpace = "diagram"
    
    var body: some View {
        VStack(spacing: 20) {
            node(tree.value)
            HStack(spacing: 20) {
                ForEach(tree.children) { child in
                    Diagram(tree: child, node: node)
                }
            }
        }
        .coordinateSpace(name: coordinateSpace)
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
