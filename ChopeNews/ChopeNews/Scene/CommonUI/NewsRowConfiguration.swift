//
//  NewsRowConfiguration.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import UIKit
import Core
import Combine
import Kingfisher

fileprivate enum Layout {
    static let logoImageSize = CGSize(width: 48.0, height: 48.0)
    static let buyViewSize = CGSize(width: 96.0, height: 32.0)
    static let padding: CGFloat = 16.0
}

struct NewsRowConfiguration: UIContentConfiguration {
    let news: News
    
    func makeContentView() -> UIView & UIContentView {
        NewsRowView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> NewsRowConfiguration {
        self
    }
}

class NewsRowView: UIView, UIContentView {
    // MARK: - Views
    private var cancellables = Set<AnyCancellable>()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.semanticContentAttribute = .forceRightToLeft
        return stackView
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.semanticContentAttribute = .forceRightToLeft
        return stackView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Properties
    private var newsRowConfiguration: NewsRowConfiguration? {
        configuration as? NewsRowConfiguration
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configView()
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupView()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupView
    private func setupView() {
        addSubview(mainStackView)
        [logoImageView, textsStackView].forEach(mainStackView.addArrangedSubview(_:))
        [titleLabel, descriptionLabel].forEach(textsStackView.addArrangedSubview(_:))
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.padding)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: Layout.logoImageSize.width),
            logoImageView.heightAnchor.constraint(equalToConstant: Layout.logoImageSize.height)
        ])
    }
    // MARK: - fetch Config on View
    
    private func configView() {
        guard let newsConfig = newsRowConfiguration else { return }
        titleLabel.text = newsConfig.news.title
        descriptionLabel.text = newsConfig.news.publishedAt.ISO8601Format()
        if let urlString = newsConfig.news.image, let url = URL(string: urlString) {
            logoImageView.kf.setImage(with: url)
        }
    }
    
}
