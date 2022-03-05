//
//  HoleRowConfiguration.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import UIKit
import Core
import Combine

fileprivate enum Layout {
    static let padding: CGFloat = 8.0
}

struct HoleRowConfiguration: UIContentConfiguration {
    let page: Int?
    let load = PassthroughSubject<Int?, Never>()
    
    func makeContentView() -> UIView & UIContentView {
        HoleRowView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> HoleRowConfiguration {
        self
    }
}

class HoleRowView: UIView, UIContentView {
    // MARK: - ViewstableView.rowHeight = UITableView.automaticDimension
    private var cancellables = Set<AnyCancellable>()
    private lazy var container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.semanticContentAttribute = .forceRightToLeft
        return stackView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - Properties
    private var holeRowConfiguration: HoleRowConfiguration? {
        configuration as? HoleRowConfiguration
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
        addSubview(activityIndicator)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: Layout.padding),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.padding),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    // MARK: - fetch Config on View
    
    private func configView() {
        guard let holeConfig = holeRowConfiguration else { return }
        holeConfig.load.send(holeConfig.page)
    }
    
}
