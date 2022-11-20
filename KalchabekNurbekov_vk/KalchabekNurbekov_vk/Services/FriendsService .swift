//
//  FriendsService .swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 29.06.2022.
//


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
   // var city: City
    
    private enum CodingKeys: String, CodingKey {
        case id
        case avatar  = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
       // case city
          
    }
   
}

//struct City: Decodable {
//    var id: Int
//    var title: String
//    
//   
//}





enum ServiceError: Error {
    case serviceUnvailable
    case decodingError
}
protocol FriendServiceDelegate {
    func didUpdateFrineds(items: [Item])
    func didFinishWithError(error: Error)
}

final class FriendService {
    var delegate: FriendServiceDelegate?
    func loadUsers() {
        
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
            // URLQueryItem(name: "fields", value: "city"),
            URLQueryItem(name: "fields", value: "photo_100,city")
            
        ]
        
        guard let url = urlComponents.url else {return}
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("\(error.localizedDescription) не удалось отправить запрос")
            }
            
            if let safeData = data  {
                do {
                    let result = try decoder.decode(FriendsResponse.self, from: safeData)
                    let items = result.response.items
                    DispatchQueue.main.async {
                        self.delegate?.didUpdateFrineds(items: items)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print("error to read data")
            }
        }.resume()
    }
}
