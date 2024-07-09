//
//  OnboardingPageViewController.swift
//  Baby's diary
//
//  Created by mac on 24.06.2024.
//

import UIKit

class OnboardingPageViewController: UIViewController {

    // MARK: - UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var  titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var  descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 40
        return stackView
    }()
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - ViewModel
    var viewModel: OnboardingPageModel? {
        didSet {
            bindViewModel()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
    }
    private func setupConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        imageView.heightAnchor.constraint(equalToConstant: 200),
        imageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
        descriptionLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        imageView.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}
