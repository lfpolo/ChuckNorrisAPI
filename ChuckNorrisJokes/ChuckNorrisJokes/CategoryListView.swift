import UIKit

class CategoryListView : UIView {
    lazy var activityIndicatorView : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .black
        return view
    }()
    
    lazy var categoryListTableView : UITableView = {
        let view = UITableView(frame: .zero)
        view.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
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

extension CategoryListView : CodeView {
    func buildViewHierarchy() {
        self.addSubview(categoryListTableView)
        self.addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        self.categoryListTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.categoryListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.categoryListTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.categoryListTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfig() {
        self.categoryListTableView.separatorStyle = .none
        self.categoryListTableView.backgroundColor = .backgroundColor
    }
}
