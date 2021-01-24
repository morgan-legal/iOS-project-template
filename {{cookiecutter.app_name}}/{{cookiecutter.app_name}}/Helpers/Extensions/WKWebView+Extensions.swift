//
//  WKWebView+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 04/08/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import WebKit

extension WKWebView {
    
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
    
}
