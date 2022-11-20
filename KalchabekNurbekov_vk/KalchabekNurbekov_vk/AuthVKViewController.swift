//
//  AuthVKViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 14.06.2022.
//

import UIKit
import WebKit

class AuthVKViewController: UIViewController {
    var session = Session.instance

    override func viewDidLoad() {
        super.viewDidLoad()
       
        webView.navigationDelegate = self
        loadAuthVK()
      
    }
    @IBOutlet weak var webView: WKWebView!
    
    func loadAuthVK() {
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: "8193498"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,groups,wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        guard let url = urlConstructor.url  else { return }
        print(url)
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}

extension AuthVKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // проверка на полученый адрес и получение данных из урла
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        if let token = params["access_token"], let userID = params["user_id"] {
            session.token = token
            session.userId = Int(userID)!
            
            
            decisionHandler(.cancel)
            
            // переход на контроллер с логином и вход в приложение при успешной авторизации
            performSegue(withIdentifier: "AuthVKSuccessful", sender: nil)
        } else {
            decisionHandler(.allow)
            // просто переход на контроллер с логином при неуспешной авторизации
            performSegue(withIdentifier: "AuthVKUnsuccessful", sender: nil)
        }
    }
}


