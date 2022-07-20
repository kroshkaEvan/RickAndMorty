//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Эван Крошкин on 23.04.22.
//

import UIKit
import Foundation

typealias CompletionClosure = ((Swift.Result<Character, Error>) -> Void)

protocol NetworkManagerProtocol {
    func fetchCharacter(completion: @escaping CompletionClosure)
    func fetchPagesCharacters(page: Int,
                              completion: @escaping CompletionClosure)
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    func fetchCharacter(completion: @escaping CompletionClosure) {
        let urlString = Constants.Strings.URL + "/character)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characterCount = try decoder.decode(Character.self, from: data)
                completion(.success(characterCount))
            } catch { return }
            
            if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchPagesCharacters(page: Int,
                              completion: @escaping CompletionClosure) {
        let urlString = Constants.Strings.URL + "/character/?page=\(page)"
//        ?page=\(page)
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characters = try decoder.decode(Character.self, from: data)
                completion(.success(characters))
            } catch { return }
            
            if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

