//
//  OpenPDFViewController.swift
//  BackgroundDownload
//
//  Created by Vaibhav Sharma on 18/09/23.
//

import UIKit
import WebKit

class OpenPDFViewController: UIViewController {

    var webView: WKWebView!

    var fileURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        webView = WKWebView()
        self.view = webView

    }

    override func viewWillAppear(_ animated: Bool) {
        let uRLRequest =  URLRequest(url: URL(string: "https://developer.apple.com/forums/thread/108394")!)
       // Do any additional setup after loading the view.
       webView.load(uRLRequest)
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
