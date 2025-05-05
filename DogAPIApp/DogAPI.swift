//
//  DogAPI.swift
//  DogAPIApp
//
//  Created by HUGHES, DARIAN M. on 5/5/25.
//

import Foundation

struct DogImageResponse: Decodable {
    let message: [String]
    let status: String
}

enum DogAPI {
    static func fetchRandomImages(count: Int=10, completion: @escaping (Result<[String], Error>) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random/\(count)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let e = error { return completion(.failure(e)) }
            guard let data = data,
                    let resp = try? JSONDecoder().decode(DogImageResponse.self, from: data),
                  resp.status == "success"
            else {
                return completion(.failure(NSError(domain:"ParseError", code:-1)))
            }
            completion(.success(resp.message))
        }
        .resume()
    }
    
    static func fetchBreedImages(breed: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let breedName = breed.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: "https://dog.ceo/api/breed/\(breedName)/images/random/10")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let e = error { return completion(.failure(e)) }
            guard let data = data,
                  let resp = try? JSONDecoder().decode(DogImageResponse.self, from: data),
                  resp.status == "success"
            else {
                return completion(.failure(NSError(domain:"ParseError", code:-1)))
            }
            completion(.success(resp.message))
        }
        .resume()
    }
}

