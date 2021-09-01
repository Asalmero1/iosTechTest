//
//  WebViewController.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 01/09/21.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:DetailView.webpass)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
