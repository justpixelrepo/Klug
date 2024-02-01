//
//  SwiftUIView.swift
//  
//
//  Created by Evans Domina Attafuah on 21/11/2023.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var icon: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                    .condensedLowercased(.semibold, size: 24)
                Spacer()
                if !icon.isEmpty {
                    Image(systemName: icon)
                }
            }
            
            Divider()
        }
    }
}

#Preview {
    SectionHeaderView(title: "Popular", icon: "slider.horizontal.3")
}

#Preview {
    SectionHeaderView(title: "Popular")
}
