//
//  GroupsService.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 05.07.2022.
//





import Foundation
import UIKit

struct GroupsResponse:  Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Item]
        
        struct Item: Decodable {
            var id: Int
            var name: String
            var activity: String
            var logo: String
    
            enum CodingKeys: String, CodingKey {
                case name
                case logo = "photo_100"
                case id
                case activity
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
                logo = try container.decode(String.self, forKey: .logo)
                id = try container.decode(Int.self, forKey: .id)
                activity = try container.decode(String.self, forKey: .activity)
            }
        }
    }

}



final class GroupsService {
    
    func loadGroups(completion: @escaping((Result<GroupsResponse, ServiceError>) -> ())) {
        
        guard let id = Session.instance.userId else { return }
        guard let token = Session.instance.token else { return }
        let decoder = JSONDecoder()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(id)),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "fields", value: "activity")
        ]
        
        guard let url = urlComponents.url else {return}
        print(url)
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
                let result = try decoder.decode(GroupsResponse.self, from: data)
                completion(.success(result))
               
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }

}
        
