//
//  CharactersDataList.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation

class CharactersDataList: Codable {
    var characterList: [CharacterData]
    var pages: Int
    
    init(characterList: [CharacterData], pages: Int) {
        self.characterList = characterList
        self.pages = pages
    }
}
