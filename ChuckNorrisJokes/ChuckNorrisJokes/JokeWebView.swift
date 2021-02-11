import UIKit
import WebKit

class JokeWebView : UIView {
    lazy var activityIndicatorView : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .black
        return view
    }()
    
    lazy var webView : WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JokeWebView : CodeView {
    func buildViewHierarchy() {
        self.addSubview(webView)
        self.addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        self.webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfig() {
        self.webView.backgroundColor = .backgroundColor
    }
}
