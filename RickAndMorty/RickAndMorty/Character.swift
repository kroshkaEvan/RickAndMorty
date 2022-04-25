//
//  Character.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import Foundation

struct Character: Codable {
    let info: Info
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let episode: [String]
    let image: String
    let url: String
    let created: String
    let location: Location
    let origin: Location
}

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
}

struct Info: Codable {
    let count: Int
    let next: String
}
