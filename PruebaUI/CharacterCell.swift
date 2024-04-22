//
//  CharacterCell.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 22/4/24.
//

import SwiftUI
import Kingfisher

struct CharacterCell: View {
    var character: CharacterData
    
    var body: some View {
        HStack {
            KFImage(URL(string: character.image))
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
            Text(character.name)
        }
    }
}

#Preview {
    CharacterCell(character: CharacterData(name: "Juan", status: .alive, species: "hola", type: "adios", gender: .female, location: LocationDTO(name: "", url: ""), image: "https://www.tiendapadelpoint.com/pala-siux-fenix-pro-4-2024-1?search=siux", episode: []))
}
