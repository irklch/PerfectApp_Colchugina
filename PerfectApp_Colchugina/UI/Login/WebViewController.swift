//
//  WebViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 06.08.2021.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {

    //MARK: - Private property

    private let vkRequest = VKRequestsAdapter()

    //MARK: - Public property

    @IBOutlet var vkWebView: WKWebView! {
        didSet {
            vkWebView.navigationDelegate = self
        }
    }

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        openVKAuth()
    }

    //MARK: - Private methods

    private func openVKAuth() {
        guard let url = URLs.vkAuth() else {return}
        let request = URLRequest.init(url: url)
        vkWebView.load(request)
    }

    private func presentNavigationBarController() {
        self.performSegue(withIdentifier: "presentTabBar", sender: nil)
    }

    //MARK: - Public method

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }

        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String:String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        guard let token = params["access_token"] else {return}
        Session.shared.token = token
        print(Session.shared.token)

        guard let id = params["user_id"] else {return}
        Session.shared.id = id
        print(Session.shared.id)

        decisionHandler(.cancel)
        presentNavigationBarController()
    }
}
