//
//  FriendsService .swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 29.06.2022.
//

import Foundation
import UIKit

struct FriendsResponse: Decodable {
    var response: Response
}
struct Response: Decodable {
    var count: Int
    var items: [Item]
 
}
struct Item: Decodable {
    var id: Int
    var avatar: String?
    var firstName: String
    var lastName: String
    //var city: City
//    var trackCode: String
//    var isClosed: Bool?
//    var canAccess: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case avatar  = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
        //case city = "city"
//        case trackCode = "track_code"
//        case isClosed = "is_closed"
//        case canAccess = "can_access_closed"
       
    }

    
}
//struct City: Decodable {
//    var id: Int
//    var title: String
//}


            
enum ServiceError: Error {
    case serviceUnvailable
    case decodingError
}


final class FriendService {
    
    func loadUsers(completion: @escaping((Result<FriendsResponse, ServiceError>) -> ())) {
        
        guard let id = Session.instance.userId else { return }
        guard let token = Session.instance.token else { return }
        let decoder = JSONDecoder()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(id)),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "v", value: "5.131"),
            //URLQueryItem(name: "fields", value: "city"),
            URLQueryItem(name: "fields", value: "photo_100")
          
        ]
        
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
           
            guard let data = data else {
                return
            }
              
            do {
                let result = try decoder.decode(FriendsResponse.self, from: data)
                completion(.success(result))
               
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }

}
        
