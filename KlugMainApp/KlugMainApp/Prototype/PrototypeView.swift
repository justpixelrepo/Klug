//
//  PrototypeView.swift
//  KlugMainApp
//
//  Created by Evans Domina Attafuah on 17/08/2022.
//

import SwiftUI

struct PrototypeView: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PrototypeView_Previews: PreviewProvider {
    static var previews: some View {
        PrototypeView()
    }
}
