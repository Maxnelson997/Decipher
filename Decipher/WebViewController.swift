//
//  WebviewController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WebViewController: DecipherController, UIWebViewDelegate {
    
    var loadAnimation:NVActivityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .ballPulseSync, color: UIColor.MNGreen, padding: 0)
    
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
        view.addSubview(loadAnimation)
        loadAnimation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 25),
            loadAnimation.widthAnchor.constraint(equalToConstant: 50),
            loadAnimation.heightAnchor.constraint(equalToConstant: 50),
            ])
        let urlrequest = URLRequest(url: url!)
        webView.delegate = self
        webView.backgroundColor = UIColor.MNOriginalDarkGray
//        if let httpResponse = response as? HTTPURLResponse {
//            let statusCode = httpResponse.statusCode
//
//            if (statusCode != 200) {
//                print ("dataTaskWithRequest HTTP status code:", statusCode)
//                return;
//            }
//        }
        webView.loadRequest(urlrequest)
        
        
    
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadAnimation.stopAnimating()
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadAnimation.startAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
        var message:String = "error loading"
        if error.localizedDescription == "The requested URL was not found on this server." {
            message = "This link is not valid."
        } else if error.localizedDescription == "The Internet connection appears to be offline." {
            message = "no internet conncection. make sure you are connected to wifi or a cellular network."
        }
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        loadAnimation.stopAnimating()
    }
    

    
    
}
