//
//  NetworkDataFetcher.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 11.11.2022.
//

import Foundation
protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = Session.instance.userId else { return }
        let params = ["fields": "photo_100", "user_ids": "\(userId)"]
        networking.request(path: API.user, params: params) { data, error in
            if let error = error {
                print("error received \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
        
    }
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        var params = ["filters": "post,photo"]
        params["start_from"] = nextBatchFrom
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("error received \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    
}
