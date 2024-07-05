//
//  ViewController.swift
//  Baby's diary
//
//  Created by mac on 19.06.2024.
//
import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
   
    private var viewModel: [OnboardingPageViewModel] = [
        OnboardingPageViewModel(imageName: "onboarding1", title: "Добро пожаловать!", description: "Наше приложение поможет вам улучшить качество сна вашего ребенка!"),
        OnboardingPageViewModel(imageName: "onboarding2", title: "Сон", description: "С функцией отслеживания сна вы легко сможете добавлять и управлять временем сна вашего ребенка, записывая начало и окончание каждого периода. Это поможет следить за режимом и качеством сна, анализировать данные и улучшать привычки сна малыша."),
        OnboardingPageViewModel(imageName: "onboarding3", title: "Статистика", description: "С функцией статистики сна вы сможете отслеживать и анализировать режимы сна ребенка, записывая данные. Делитесь этой статистикой с экспертами для профессиональных рекомендаций."),
        OnboardingPageViewModel(imageName: "onboarding4", title: "Консультация", description: "С функцией консультации ИИ вы получите персонализированные рекомендации на основе статистики сна вашего ребенка. Используя алгоритмы OpenAI, приложение анализирует данные и предлагает решения для улучшения качества сна.")
    ]
    
    private lazy var pageViewController: UIPageViewController = {
           let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
           pvc.dataSource = self
           pvc.delegate = self
           return pvc
       }()

       private lazy var pageControl: UIPageControl = {
           let pageControl = UIPageControl()
           pageControl.translatesAutoresizingMaskIntoConstraints = false
           pageControl.numberOfPages = viewModel.count
           pageControl.currentPage = 0
           return pageControl
       }()

       private lazy var skipButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Пропустить", for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
           return button
       }()

       private lazy var nextButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Дальше", for: .normal)
           button.clipsToBounds = true
           button.backgroundColor = .blue
           button.tintColor = .white
           button.alpha = 0.5
           button.layer.cornerRadius = 7
           button.translatesAutoresizingMaskIntoConstraints = false
           button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           return button
       }()

       override func viewDidLoad() {
           super.viewDidLoad()

           setupPageViewController()

           view.addSubview(pageControl)
           view.addSubview(skipButton)
           view.addSubview(nextButton)

           NSLayoutConstraint.activate([
               pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
               pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
               skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 280),
               nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
               nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-100),
               nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           ])
       }

       private func viewController(at index: Int) -> OnboardingPageViewController? {
           guard index >= 0 && index < viewModel.count else { return nil }
           let vc = OnboardingPageViewController()
           vc.viewModel = viewModel[index]
           return vc
       }

       private func setupPageViewController() {
           if let initialVC = viewController(at: 0) {
               pageViewController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
           }

           addChild(pageViewController)
           view.addSubview(pageViewController.view)
           pageViewController.didMove(toParent: self)

           pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
               pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])
       }

       // MARK: - UIPageViewControllerDataSource

       func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
           guard let vc = viewController as? OnboardingPageViewController,
                 let index = viewModel.firstIndex(where: { $0.title == vc.viewModel?.title }),
                 index > 0 else {
               return nil
           }
           return self.viewController(at: index - 1)
       }

       func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           guard let vc = viewController as? OnboardingPageViewController,
                 let index = viewModel.firstIndex(where: { $0.title == vc.viewModel?.title }),
                 index < viewModel.count - 1 else {
               return nil
           }
           return self.viewController(at: index + 1)
       }

       // MARK: - UIPageViewControllerDelegate

       func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
           guard completed,
                 let currentVC = pageViewController.viewControllers?.first as? OnboardingPageViewController,
                 let index = viewModel.firstIndex(where: { $0.title == currentVC.viewModel?.title }) else {
               return
           }
           pageControl.currentPage = index
           updateNextButtonTitle(for: index)
       }

       // MARK: - Button Actions

       @objc private func skipButtonTapped() {
           // Implement logic for skip button action
           print("Skip button tapped")
       }
    @objc private func nextButtonTapped() {
        guard let currentVC = pageViewController.viewControllers?.first as? OnboardingPageViewController,
              let currentIndex = viewModel.firstIndex(where: { $0.title == currentVC.viewModel?.title }) else {
            return
        }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex < viewModel.count, let nextVC = viewController(at: nextIndex) {
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: { [weak self] _ in
                self?.pageControl.currentPage = nextIndex
                self?.updateNextButtonTitle(for: nextIndex)
            })
        } else {
            
            print("Finish button tapped")
            
        }
    }
       private func updateNextButtonTitle(for index: Int) {
           let isLastPage = index == viewModel.count - 1
           nextButton.setTitle(isLastPage ? "Завершить" : "Дальше", for: .normal)
       }
   }
