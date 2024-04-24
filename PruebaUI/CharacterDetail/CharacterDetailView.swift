//
//  SwiftUIView.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 23/4/24.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    var character: CharacterData
    
    var body: some View {
        ScrollView() {
            VStack (alignment: .leading, spacing: 30) {
                Spacer().frame(height: 20)
                KFImage(URL(string: character.image))
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                Spacer().frame(height: 10)
                    CharacterInfoView(title: "Name", subtitle: character.name)
                    CharacterInfoView(title: "Episodes", subtitle: String(character.episode.count))
                    CharacterInfoView(title: "Status", subtitle: character.status.rawValue)
                    CharacterInfoView(title: "Species", subtitle: character.species)
                    CharacterInfoView(title: "Location", subtitle: character.location.name)
                    CharacterInfoView(title: "Gender", subtitle: character.gender.rawValue)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CharacterDetailView(character: CharacterData(id: 1, name: "Juan", status: .alive, species: "hola", type: "adios", gender: .female, location: LocationDTO(name: "Tierra", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/21.jpeg", episode: []))
}
