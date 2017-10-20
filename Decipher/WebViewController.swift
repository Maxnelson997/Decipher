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
        NSLayoutConstraint.activate(webView.getConstraintsTo(view: view, withInsets: .zero))
        
        let urlrequest = URLRequest(url: url!)
        webView.loadRequest(urlrequest)
    }

}
