//
//  ContentView.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 22/4/24.
//

import SwiftUI

struct CharactersList: View {
    @StateObject var viewModel = CharactersListViewModel(api: ApiRequest())
    @State private var myPage = 0
    
    var body: some View {
        VStack {
            if viewModel.state == .loading || viewModel.state == .success {
                successView
            }
            else if viewModel.state == .error {
                errorView
            }
        }
        .onAppear {
            loadCharacters()
        }
    }
    
    private var successView: some View {
        ZStack {
            characterListView
            if viewModel.state == .loading {
                LottieAnimation(animationName: "load.json")
                    .frame(width: 200, height: 200)
            }
        }
    }
    
    private var characterListView: some View {
        NavigationStack {
            List(viewModel.filteredCharacters, id: \.id) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterCell(character: character)
                        .onAppear {
                            if viewModel.charactersDataList.characterList.last?.name == character.name &&
                                viewModel.charactersDataList.pages != myPage {
                                loadCharacters()
                            }
                        }
                }
            }
            .navigationTitle("Personajes")
            .searchable(text: $viewModel.searchText, prompt: "Buscar personaje...")
        }
    }
        
    private var errorView: some View {
        VStack {
            Spacer()
            LottieAnimation(animationName: "error.json")
                .frame(width: 200, height: 200)
            
            Button(action: {
                viewModel.loadCharacterList(page: myPage)
            }) {
                Text("Reintentar")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            Spacer()
        }
    }
    
    private func loadCharacters() {
        guard myPage < viewModel.charactersDataList.pages else { return }
        myPage += 1
        viewModel.loadCharacterList(page: myPage)
    }
}

#Preview {
    CharactersList()
}
