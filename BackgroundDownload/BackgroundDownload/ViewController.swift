//
//  ViewController.swift
//  BackgroundDownload
//
//  Created by Vaibhav Sharma on 11/09/23.
//

import UIKit

protocol DownloadManager {
    func startDownloading()
    func pauseDownloading()
    func resumeDownloading()
}

class ViewController: UIViewController, DownloadManager, URLSessionDelegate,URLSessionDownloadDelegate {

    @IBOutlet weak var btnDownload: UIButton!

    @IBOutlet weak var btnPause: UIButton!

    @IBOutlet weak var btnResume: UIButton!
    
    var downloadTask : URLSessionDownloadTask?
    var resumeData : Data?

    private lazy var urlSession: URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "MySession")
        urlSessionConfiguration.isDiscretionary = true
        urlSessionConfiguration.sessionSendsLaunchEvents = true
        if #available(iOS 11, *) {
            urlSessionConfiguration.waitsForConnectivity = true
        }
        return URLSession(configuration: urlSessionConfiguration, delegate: self, delegateQueue: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func downloadFile(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.btnDownload.backgroundColor = UIColor.green
            self.btnResume.backgroundColor = UIColor.red
            self.btnPause.backgroundColor = .red
        }
        startDownloading()
    }


    @IBAction func pauseAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.btnDownload.backgroundColor = UIColor.red
            self.btnResume.backgroundColor = UIColor.red
            self.btnPause.backgroundColor = .green
        }
        pauseDownloading()
    }
    
    @IBAction func resumeAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.btnDownload.backgroundColor = UIColor.red
            self.btnResume.backgroundColor = UIColor.green
            self.btnPause.backgroundColor = .red
        }
        resumeDownloading()
    }
    
    func startDownloading() {
        downloadFile()
    }

    func pauseDownloading() {
        downloadTask?.cancel(byProducingResumeData: { <#Data?#> in
            <#code#>
        })
    }

    func resumeDownloading() {
        guard let resumeData = self.resumeData else{
            return
        }
        downloadTask = urlSession.downloadTask(withResumeData: resumeData)
        downloadTask?.resume()
    }


    func downloadFile() {
        // a url

        let url = URL(string: "https://www.africau.edu/images/default/sample.pdf")!

        downloadTask = urlSession.downloadTask(with: URLRequest(url: url))
        downloadTask?.resume()
    }

    //URLSessionDelegate delegate
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let backgroundCompletionHandler =
                appDelegate.backgroundCompletionHandler else {
                    return
            }
            backgroundCompletionHandler()
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Download error: %@", String(describing: error))
        } else {
            print("Task finished: %@", task)
        }
    }

//URLSessionDownloadTask
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download finished: %@", location.absoluteString)
        // The file at location is temporary and will be gone afterwards
    }

}

extension ViewController {

    override func performSegue(withIdentifier identifier: String, sender: Any?) {

    }
}
