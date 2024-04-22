//
//  ContentView.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 22/4/24.
//

import SwiftUI

struct CharactersList: View {
    @StateObject var viewModel = CharactersListViewModel(api: ApiRequest())
    @State private var myPage = 1
    private var totalPages = 0
    var charactersList: [CharacterData] = []
    
    var body: some View {
        List(viewModel.charactersDataList?.characterList ?? [], id: \.name) { character in
            CharacterCell(character: character)//cambiar !
                .onAppear() {
                    if viewModel.charactersDataList?.characterList.last?.name == character.name && viewModel.charactersDataList?.pages != myPage {
                        myPage += 1
                        viewModel.loadCharacterList(page: myPage, characterList: viewModel.charactersDataList!.characterList)
                    }
                }
        }
        
        .onAppear {
            viewModel.loadCharacterList(page: myPage, characterList: [])
            self.myPage = myPage + 1
        }
    }
    
}

#Preview {
    CharactersList()
}
