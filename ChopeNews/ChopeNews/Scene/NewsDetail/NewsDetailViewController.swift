//
//  NewsDetailViewController.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import UIKit
import Combine
import Kingfisher

private struct Constant {
    static let title: String = "News Detail"
    static let saveImageName = "heart"
    static let savedImageName = "heart.fill"
}

private struct Layout {
    static let padding = 8.0
    static let itemSpacing = 12.0
    static let imageCorner = 8.0
    static let titleFontSize = 17.0
    static let defaultFontSize = 14.0
}

final class NewsDetailViewController: UIViewController {
    
    // MARK: - View's
    // FIXME:  should use tableview instead of scrollveiew
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Layout.itemSpacing
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Layout.imageCorner
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Layout.titleFontSize)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Layout.defaultFontSize)
        label.textColor = .darkGray
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Layout.defaultFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var saveBarButtonItem: UIBarButtonItem = { [unowned self] in
        UIBarButtonItem(image: UIImage.init(systemName: Constant.saveImageName), style: .plain, target: self, action: #selector(didTapOnSave))
    }()
    
    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    let router: NewsDetailRouting
    let viewModel: NewsDetailViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: NewsDetailViewModelProtocol, router: NewsDetailRouting) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    // MARK: - Bind
    func bind() {
        viewModel.state
            .compactMap(\.news.title)
            .sink { [weak self] text in
                self?.titleLabel.text = text
            }.store(in: &cancellables)
        
        viewModel.state
            .compactMap { URL(string: $0.news.image ?? "" )}
            .sink { [weak self] imageURL in
                self?.newsImageView.kf.setImage(with: imageURL)
            }.store(in: &cancellables)
        
        viewModel.state
            .map(\.news.description)
            .sink { [weak self] text in
                self?.descriptionLabel.text = text
                
            }.store(in: &cancellables)
        
        viewModel.state
            .map(\.news.publishedAt)
            .sink { [weak self] date in
                self?.timeLabel.text = date.fullDateString
            }.store(in: &cancellables)
        
        viewModel.state
            .map(\.isFav)
            .sink { [weak self] isFav in
                self?.saveBarButtonItem.image = UIImage(systemName: isFav ? Constant.savedImageName : Constant.saveImageName)
            }.store(in: &cancellables)
    }
    
    // MARK: - SetupView
    private func setupView() {
        title = Constant.title
        view.backgroundColor = .white
        view.addSubview(scrollView)
        addNavigationBarItems()
        
        scrollView.addSubview(mainStackView)
        [titleLabel, timeLabel, newsImageView, descriptionLabel].forEach(mainStackView.addArrangedSubview(_:))
        setupConstraint()
    }
    
    private func addNavigationBarItems() {
        self.navigationItem.rightBarButtonItems = [saveBarButtonItem]
    }
    
    @objc private func didTapOnSave() {
        viewModel.action(.updateFavorite)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.padding),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.padding),
        ])
        
        let heightConstraint = mainStackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            heightConstraint,
            mainStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
    }
}
