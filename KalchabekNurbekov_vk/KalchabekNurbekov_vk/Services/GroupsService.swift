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
            var name: String
            var logo: String  // уже тут нужно писать желаемые названия
            
            // не нужные в приложении поля, которые есть в json-е
            //var id: Int
            //var screen_name: String
            //var photo_50: String
            
            // enum и init нужны если нужно иметь другие названия переменных в отличии от даннных в json
            // например: logo = "photo_50" (я хочу: logo, а в jsone это: photo_50 )
            // но все равно нужно указать другие значения, например: name (без уточнения)
            enum CodingKeys: String, CodingKey {
                case name
                case logo = "photo_50"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
                logo = try container.decode(String.self, forKey: .logo)
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
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(id)),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
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
                let result = try decoder.decode(GroupsResponse.self, from: data)
                completion(.success(result))
               
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }

}
        
