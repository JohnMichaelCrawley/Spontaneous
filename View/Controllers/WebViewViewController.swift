//
//  SendFeedbackViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    private let WEBKIT: WKWebView =
    {
        let preferences = WKWebpagePreferences()
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        
        preferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = preferences
        
        return webView
    }()
    
    
    private let url: URL
    
    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder)
    {
        fatalError()
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(WEBKIT)
        WEBKIT.load(URLRequest(url: url ))
        
        configureButtons()
        
        
        // Do any additional setup after loading the view.
        
        
    }
    
    private func configureButtons()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    
    
    @objc func didTapDone()
    {
       // WEBKIT.close
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapRefresh()
    {
        WEBKIT.load(URLRequest(url: url))
    }
    
    
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        WEBKIT.frame = view.bounds
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
