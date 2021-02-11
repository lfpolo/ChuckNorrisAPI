import UIKit
import WebKit

class JokeWebViewController : UIViewController {
    var url : URL
    var jokeWebView = JokeWebView()
    
    init(url : URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = jokeWebView
    }
    
    override func viewDidLoad() {
        self.jokeWebView.webView.navigationDelegate = self
        self.jokeWebView.webView.load(URLRequest(url: url))
    }
}

extension JokeWebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.jokeWebView.activityIndicatorView.startAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.jokeWebView.activityIndicatorView.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.jokeWebView.activityIndicatorView.stopAnimating()
        }
    }
}
