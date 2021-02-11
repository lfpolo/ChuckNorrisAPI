import UIKit

class JokeView : UIView {
    lazy var activityIndicatorView : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .black
        return view
    }()
    
    lazy var openWebViewButton : UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var jokeIconImage : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var jokeValueLabel : UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView : UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentView : UIView = {
        let view = UIView(frame: .zero)
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

extension JokeView : CodeView {
    func buildViewHierarchy() {
        self.addSubview(scrollView)
        self.addSubview(activityIndicatorView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(jokeIconImage)
        self.contentView.addSubview(jokeValueLabel)
        self.contentView.addSubview(openWebViewButton)
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
            self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
        self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        if #available(iOS 11.0, *) {
            self.contentView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).isActive = true
        } else {
            self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
        
        self.jokeIconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        self.jokeIconImage.widthAnchor.constraint(equalToConstant: 64).isActive = true
        self.jokeIconImage.heightAnchor.constraint(equalToConstant: 64).isActive = true
        self.jokeIconImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        self.jokeValueLabel.topAnchor.constraint(equalTo: jokeIconImage.bottomAnchor, constant: 30).isActive = true
        self.jokeValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        self.jokeValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        
        self.openWebViewButton.topAnchor.constraint(equalTo: jokeValueLabel.bottomAnchor, constant: 30).isActive = true
        self.openWebViewButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        self.openWebViewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfig() {
        self.jokeValueLabel.numberOfLines = 0
        self.jokeValueLabel.textAlignment = .center
        self.openWebViewButton.setTitle("Ver piada em chucknorris.io", for: .normal)
        self.openWebViewButton.setTitleColor(.systemBlue, for: .normal)
        self.backgroundColor = .backgroundColor
        self.jokeValueLabel.textColor = .textColor

    }
}
