protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfig()
}

extension CodeView {
    func setupView() {
        self.buildViewHierarchy()
        self.setupConstraints()
        self.setupAdditionalConfig()
    }
}
