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
        HStack(alignment: .center) {
            KFImage(URL(string: character.image))
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
            Text(character.name)
                .bold()
                .padding()
        }
    }
}

#Preview {
    CharacterCell(character: CharacterData(id: 1, name: "Juan", status: .alive, species: "hola", type: "adios", gender: .female, location: LocationDTO(name: "", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/21.jpeg", episode: []))
}
