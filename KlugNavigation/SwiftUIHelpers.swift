//
//  SwiftUIHelpers.swift
//  KlugNavigation
//
//  Created by Evans Domina Attafuah on 09/10/2021.
//

import SwiftUI
import CasePaths

public extension Binding {
    func isPresent<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        .init(
            get: { self.wrappedValue != nil },
            set: { isPresented in
                if !isPresented {
                    self.wrappedValue = nil
                }
            }
        )
    }
}

extension View {
    
    func alert<A: View, M: View, T>(
        title: (T) -> Text,
        presenting data: Binding<T?>,
        @ViewBuilder actions: @escaping (T) -> A,
        @ViewBuilder message: @escaping (T) -> M) -> some View {
            self.alert(
                data.wrappedValue.map(title) ?? Text("Delete"),
                isPresented: data.isPresent(),
                presenting: data.wrappedValue,
                actions: actions,
                message: message)
        }
    
    func confirmationDialog<A: View, M: View, T>(
        title: (T) -> Text,
        titleVisibility: Visibility = .automatic,
        presenting data: Binding<T?>,
        @ViewBuilder actions: @escaping (T) -> A,
        @ViewBuilder message: @escaping (T) -> M) -> some View {
            self.confirmationDialog(
                data.wrappedValue.map(title) ?? Text("Delete"),
                isPresented: data.isPresent(),
                titleVisibility: titleVisibility,
                presenting: data.wrappedValue,
                actions: actions,
                message: message)
        }
    
}

struct IfCaseLet<Enum, Case, Content>: View where Content: View {
  let binding: Binding<Enum>
  let casePath: CasePath<Enum, Case>
  let content: (Binding<Case>) -> Content

  init(
    _ binding: Binding<Enum>,
    pattern casePath: CasePath<Enum, Case>,
    @ViewBuilder content: @escaping (Binding<Case>) -> Content
  ) {
    self.binding = binding
    self.casePath = casePath
    self.content = content
      
      let keyPath = \Item.id
      let casePath = /Item.Status.inStock
  }
    
    var body: some View {
        if let `case` = (fatalError() as! Case?) {
            self.content(
                Binding(
                    get: { `case` },
                    set: { binding.wrappedValue = self.pattern($0) }
                )
            )
        }
    }
}
