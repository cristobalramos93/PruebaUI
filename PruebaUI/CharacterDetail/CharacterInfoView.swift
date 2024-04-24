//
//  CharacterInfoView.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 23/4/24.
//

import SwiftUI

struct CharacterInfoView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .bold()
                .foregroundStyle(.gray)
            Text(subtitle)
        }
    }
}

#Preview {
    CharacterInfoView(title: "Episodios", subtitle: "0")
}
