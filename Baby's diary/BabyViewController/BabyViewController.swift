
import UIKit

class AddBabyViewController: UIViewController {
    
    // UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Добавить малыша")
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var babyNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Имя малыша")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var babyNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    private lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"День рождения")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.text = String(localized:"Не выбрано")
        textField.textColor = .systemPurple
        textField.textAlignment = .center // Center the text
        return textField
    }()
    
    private lazy var calendarView: UICalendarView = {
        let calendar = UICalendarView()
        calendar.isHidden = true
        calendar.delegate = self
        return calendar
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Вес")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Рост")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var heightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    private lazy var headCircumferenceLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Обхват головы")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var headCircumferenceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(birthDateTapped))
        birthDateTextField.addGestureRecognizer(tapGesture)
        birthDateTextField.isUserInteractionEnabled = true
    }
    
    private func setupUI() {
        // Create a stack view for each label-textfield pair
        let babyNameStackView = createStackView(with: babyNameLabel, textField: babyNameTextField)
        let birthDateStackView = createStackView(with: birthDateLabel, textField: birthDateTextField)
        let weightStackView = createStackView(with: weightLabel, textField: weightTextField)
        let heightStackView = createStackView(with: heightLabel, textField: heightTextField)
        let headCircumferenceStackView = createStackView(with: headCircumferenceLabel, textField: headCircumferenceTextField)
        
        // Main stack view
        let mainStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            babyNameStackView,
            birthDateStackView,
            calendarView, // Include calendar view in the main stack view
            weightStackView,
            heightStackView,
            headCircumferenceStackView
        ])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 15
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillProportionally
        
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func createStackView(with label: UILabel, textField: UITextField) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
    
    @objc private func birthDateTapped() {
        let isHidden = calendarView.isHidden
        UIView.animate(withDuration: 0.3) {
            self.calendarView.isHidden = !isHidden
        }
    }
}

extension AddBabyViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents,
              let date = Calendar.current.date(from: dateComponents) else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        birthDateTextField.text = dateFormatter.string(from: date)
        birthDateTextField.textColor = .black
        
        UIView.animate(withDuration: 0.3) {
            self.calendarView.isHidden = true
        }
    }
}

