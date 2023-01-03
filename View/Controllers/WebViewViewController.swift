//
//  SendFeedbackViewController.swift
//  Spontaneous
//
//  Created by John Michael Crawley on 19/12/2022.
//
/*
 INFORMATION ON THIS CLASS / FILE:
 This file helps create a webpage popup
 that is resusable to create popups
 on a view controller that access a web
 page as a modelity
 */
// IMPORT LIST
import UIKit
import WebKit

class WebViewViewController: UIViewController {
    // VARIABLES//
    /*
     Create a webview with properties of
     - preferences
     - configuration
     - webview
     then add allow JS to preference
     and config' = to preferences
     and then return the webview
     */
    private let WEBKIT: WKWebView =
    {
        let preferences = WKWebpagePreferences()
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        preferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = preferences
        return webView
    }()
    private let url: URL    // url to hold a URL
    // Init' URL and add a title to the page
    init(url: URL, title: String) {
        
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    // Report any errors
    required init?(coder: NSCoder)
    {
        fatalError()
    }
    
    /*
     View Did Load:
     This func is called when loading a view controller
     hierarchy into memory.
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground    // Set background colour
        view.addSubview(WEBKIT)                     // Add Webkit to subview
        WEBKIT.load(URLRequest(url: url ))          // Load URL
        configureButtons()                          // Add config' buttons
    }
    // Config' two buttons. Refresh and done.
    private func configureButtons()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    // Func to dismiss popup when the user presses DONE
    @objc func didTapDone()
    {
       // WEBKIT.close
        dismiss(animated: true, completion: nil)
    }
    // Func to refresh the page when the user presses REFRESH
    @objc func didTapRefresh()
    {
        WEBKIT.load(URLRequest(url: url))
    }
    // Func for view load subviews
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        WEBKIT.frame = view.bounds
    }
}
