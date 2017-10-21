//
//  WebviewController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit

class WebViewController: DecipherController {
    
    
    let webView = UIWebView()
    var url:URL!
    
    override func start() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        let urlrequest = URLRequest(url: url!)
        webView.loadRequest(urlrequest)
    }
    
    
}
