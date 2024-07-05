//
//  OnboardingPageViewController.swift
//  Baby's diary
//
//  Created by mac on 24.06.2024.
//

import UIKit

/*class OnboardingPageViewController: UIViewController {
   
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "baby")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var labelOne: UILabel = {
        let label = UILabel()
        label.text = "Hi there!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    private lazy var labelTwo: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    private lazy var verticalStackViewOne: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        view.addSubview(verticalStackView)
        view.addSubview(verticalStackViewOne)
        view.backgroundColor = .white
        
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(labelOne)
        verticalStackViewOne.addArrangedSubview(labelTwo)
        
        setupConstreint()
    }
    
    func setupConstreint() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            verticalStackViewOne.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 20),
            verticalStackViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
}*/
class OnboardingPageViewController: UIViewController {

    // MARK: - UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var  titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
    var viewModel: OnboardingPageViewModel? {
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
       /* NSLayoutConstraint.activate([
                    contentStackView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                   contentStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                    contentStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                   // NSLayoutConstraint(item: contentStackView, attribute: .centerY, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 0.8, constant: 0)
                ])*/
                
                
                NSLayoutConstraint.activate([
                    // Constraints for contentStackView
                               contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                               contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                              contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                               
                               // Constraints for imageView
                               imageView.heightAnchor.constraint(equalToConstant: 200),
                               imageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),

                               // Constraints for titleLabel
                               titleLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),

                               // Constraints for descriptionLabel
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
