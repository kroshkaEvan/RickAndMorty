//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import UIKit
import Foundation

typealias CompletionClosure = ((Swift.Result<Character, Error>) -> Void)

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchCharacter(completed: @escaping CompletionClosure) {
        let urlString = Constants.Strings.URL + "/character)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characterCount = try decoder.decode(Character.self, from: data)
                completed(.success(characterCount))
            } catch { return }
        }
        task.resume()
    }
    
    func fetchPagesCharacters(page: Int, completed: @escaping CompletionClosure) {
        let urlString = Constants.Strings.URL + "/character/?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characters = try decoder.decode(Character.self, from: data)
                completed(.success(characters))
            } catch { return }
        }
        task.resume()
    }
}
