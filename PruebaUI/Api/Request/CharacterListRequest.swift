//
//  CharacterListRequest.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation
import Combine

enum ApiError: Error {
    case error
}

class ApiRequest {
    var api: API?
    var urlComponents = URLComponents()
    
    func fetchCharacterList(_ page: Int) -> Future<CharactersDataList, Error> {
        Future<CharactersDataList, Error> { promise in
            let offsetQuery = URLQueryItem(name: "page", value: String(page))
            self.urlComponents.scheme = "https"
            self.urlComponents.host = "rickandmortyapi.com"
            self.urlComponents.path = "/api/character/"
            self.urlComponents.queryItems = [offsetQuery]
            self.api = API(url: self.urlComponents.url ?? URL(fileURLWithPath: ""))
            guard let api = self.api else { return promise(.failure(ApiError.error))}
            var charactersList: [CharacterData] = []
            var pages = 0
            api.performRequest { data, response, error in
                guard let data = data else { return promise(.failure(ApiError.error))}
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CharacterListDTO.self, from: data)
                    charactersList = response.results.map {
                        return CharacterData(name: $0.name,
                                             status: $0.status,
                                             species: $0.species,
                                             type: $0.type,
                                             gender: $0.gender,
                                             location: $0.location,
                                             image: $0.image,
                                             episode: $0.episode)
                    }
                    pages = response.info.pages
                } catch let err {
                    promise(.failure(err))
                }
                DispatchQueue.main.async {
                    promise(.success(CharactersDataList(characterList: charactersList, pages: pages)))
                }
            }
        }
    }
}
