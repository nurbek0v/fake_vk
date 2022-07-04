//
//  FriendsService .swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 29.06.2022.
//

import Foundation

struct FriendsResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Item]
        
        struct Item: Decodable {
            var id: Int
            var avatar: String
            var firstName: String
            var lastName: String
            
           // var city: City
            
            //var deactivated: String?
            
            // enum и init нужны если нужно иметь другие названия переменных в отличии от даннных в json
            // например: logo = "photo_50" (я хочу: logo, а в jsone это: photo_50 )
            // но все равно нужно указать другие значения, например: id (без уточнения)
            private enum CodingKeys: String, CodingKey {
                case id
                case avatar  = "photo_50"
                case firstName = "first_name"
                case lastName = "last_name"
                //case city
                
                //case deactivated
            }
//            struct City: Decodable {
//                var id: Int
//                var title: String
//            }
        }
    }
}
            
enum ServiceError: Error {
    case serviceUnvailable
    case decodingError
}


final class FriendService {
    
    func loadUsers(completion: @escaping((Result<[Friend], ServiceError>) -> ())) {
        
        guard let id = Session.instance.userId else { return }
        guard let token = Session.instance.token else { return }
        let decoder = JSONDecoder()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        //поиск по друзьям, показывает только used id друзей
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(id)),
            URLQueryItem(name: "access_token", value: String(token)),
            URLQueryItem(name: "v", value: "5.131"),
            //добавляет информацию по каждому другу
            URLQueryItem(name: "fields", value: "photo_50"),
           // URLQueryItem(name: "fields", value: "photo_50")
           // URLQueryItem(name: "fields", value: "city")
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
                var fullNamesFriends: [Friend] = []
                for i in 0...result.response.items.count-1 {
                    let name = ((result.response.items[i].firstName) + " " + (result.response.items[i].lastName))
                    let avatar = result.response.items[i].avatar
                    let id = String(result.response.items[i].id)
                    fullNamesFriends.append(Friend.init(name: name, avatar: avatar, ownerId: id))
                }
                //complition(fullNamesFriends)
               
                completion(.success(fullNamesFriends))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }

}
        
