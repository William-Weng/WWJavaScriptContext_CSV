//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2022/12/15.
//  ~/Library/Caches/org.swift.swiftpm/
//  file:///Users/william/Desktop/WWJavaScriptContext+CSV

import UIKit
import WebKit
import WWPrint
import WWJavaScriptContext
import WWJavaScriptContext_CSV

final class ViewController: UIViewController {
    
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func convertCSV(_ sender: UIButton) {
        
        defer { view.endEditing(true) }
        
        guard let text = myTextView.text,
              let array = WWJavaScriptContext.CSV.shared.convertArray(source: text),
              let jsonString = array._jsonString()
        else {
            return
        }
        
        myWebView.loadHTMLString("\(jsonString)", baseURL: nil)
    }
}
