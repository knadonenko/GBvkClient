//
//  WebKitLoginViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 20.12.2020.
//

import UIKit
import WebKit
import Alamofire

class WebKitLoginViewController: UIViewController, WKNavigationDelegate {
    
    let session = Session.shared
    let network = NetworkRequests()
    
    @IBOutlet weak var webKitView: WKWebView! {
        didSet {
            webKitView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7705025"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webKitView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
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
        
        let token = params["access_token"]
        
//        print(token)
        
        session.token = token
        
        if !token!.isEmpty {
            self.dismiss(animated: false, completion: nil)
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        
//        network.getFriendsList(session.token)
//        network.getPersonalPhotoList(session.token, "1")
//        network.getGroupsList(session.token)
//        network.getGroupsSearch(session.token, "steam")
        
        decisionHandler(.cancel)
    }
    
}
