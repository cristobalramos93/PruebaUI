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
            // Vista de carga y éxito
            if viewModel.state == .loading || viewModel.state == .success {
                successView
            }
            // Vista de error
            else if viewModel.state == .error {
                errorView
            }
            
        }
        .onAppear {
            loadCharacters()
        }
    }
    
    // Vista de carga y éxito
    private var successView: some View {
        ZStack {
            characterListView
            if viewModel.state == .loading {
                LottieAnimation(animationName: "load.json")
                    .frame(width: 200, height: 200)
            }
        }
    }
    
    // Vista de éxito
    private var characterListView: some View {
        NavigationView {
            List(viewModel.charactersDataList.characterList, id: \.id) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterCell(character: character)
                        .onAppear() {
                            if viewModel.charactersDataList.characterList.last?.name == character.name && viewModel.charactersDataList.pages != myPage {
                                loadCharacters()
                            }
                        }
                }
            }
            //.listStyle(.plain)
            .navigationTitle("Personajes")
        }

    }
    
    
    // Vista de error
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
    
    // Función para volver a cargar personajes
    private func loadCharacters() {
        myPage += 1
        viewModel.loadCharacterList(page: myPage)
    }
}

#Preview {
    CharactersList()
}
