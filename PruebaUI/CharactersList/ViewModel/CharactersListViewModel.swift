//
//  CharactersListViewModel.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 22/4/24.
//

import Foundation
import SwiftUI
import Combine

enum ViewState {
    case success
    case error
    case loading
}

class CharactersListViewModel: ObservableObject {
    private var api: ApiRequest?
    var cancellable = Set<AnyCancellable>()
    @Published var charactersDataList = CharactersDataList(characterList: [], pages: 10)
    @Published var state: ViewState = .loading
    
    init(api: ApiRequest) {
        self.api = api
    }
    
    func loadCharacterList(page: Int) {
        state = .loading
        api?.fetchCharacterList(page)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    self.state = .error
                case .finished:
                    break
                }
            }, receiveValue: { data in
                self.state = .success
                self.charactersDataList.characterList.append(contentsOf: data.characterList)
                self.charactersDataList.pages = data.pages
            }).store(in: &cancellable)
    }
}
