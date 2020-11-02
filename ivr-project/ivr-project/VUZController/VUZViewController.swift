//
//  VUZViewController.swift
//  ivr-project
//
//  Created by Kim Irina on 01.11.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import UIKit
import WebKit

class VUZViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        let myURL = URL(string: "https://msk.postupi.online/vuzi")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        setupUI()
    }

    private func setupUI() {
        view.addSubview(webView)
        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

