//
//  MaskPatch.swift
//  TrueLoveProject
//
//  Created by Bomi on 2020/5/17.
//  Copyright © 2020 PrototypeC. All rights reserved.
//

import Foundation

class MaskPatchClient {
    
    let baseURL: URL
    let session: URLSession
    let responseQueue: DispatchQueue?
    
    init(baseURL: URL,
         session: URLSession,
         responseQueue: DispatchQueue?) {
        self.baseURL = baseURL
        self.session = session
        self.responseQueue = responseQueue
    }
    
    func getDogs(completion:
        @escaping ([MaskInfos]?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: "", relativeTo: baseURL)!
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                error == nil,
                let data = data else {
                    self.dispatchResult(error: error, completion: completion)
                    return
            }
            let decoder = JSONDecoder()
            do {
                let masks = try decoder.decode([MaskInfos].self, from: data)
                self.dispatchResult(models: masks, completion: completion)
            } catch {
                self.dispatchResult(error: error, completion: completion)
            }
        }
        task.resume()
        return task
    }
    
    private func dispatchResult<Type>(
        models: Type? = nil,
        error: Error? = nil,
        completion: @escaping (Type?, Error?) -> Void) {
        guard let responseQueue = responseQueue else {
            completion(models, error)
            return
        }
        responseQueue.async {
            completion(models, error)
        }
    }
}

