//
//  ActivePhotoView.swift
//  KlugMainApp
//
//  Created by Evans Domina Attafuah on 17/08/2022.
//

import SwiftUI

struct ActivePhotoView: View {
    
    @State private var isActive: Bool = true
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 48)
                .clipShape(Circle())
                .rotationEffect(isActive ? .degrees(0) : .degrees(360))
            
            VStack(alignment: .leading) {
                Text("Luna Alara")
                    .font(.system(size:20.0, weight: .bold, design: .rounded))
                
                Text("@luna")
                    .opacity(0.5)
                    .font(.system(size: 14.0, weight: .bold, design: .monospaced))
            }
            .foregroundColor(isActive ? .white : .primary)
        }
        .padding(20)
        .background(isActive ? .blue : .yellow)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .scaleEffect(isActive ? 1.4 : 1)
        .shadow(color: isActive ? .blue : .yellow, radius: isActive ? 12 : 4)
        .animation(.spring(), value: isActive)
        .onTapGesture {
            isActive.toggle()
        }
    }
}

struct ActivePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ActivePhotoView()
    }
}
