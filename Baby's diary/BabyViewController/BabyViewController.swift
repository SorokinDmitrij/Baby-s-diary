

import UIKit

class AddBabyViewController: UIViewController, UITextFieldDelegate {

    // UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Добавить малыша")
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
        textField.delegate = self
        return textField
    }()
    
    private lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"День рождения")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var birthDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized:"Не выбрано"), for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(birthDateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var calendarView: UICalendarView = {
        let calendar = UICalendarView()
        calendar.isHidden = true
        calendar.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        return calendar
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Вес (в килограммах)")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.keyboardType = .decimalPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Рост (в сантиметрах)")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var heightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.keyboardType = .decimalPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var headCircumferenceLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Обхват головы (в сантиметрах)")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var headCircumferenceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.keyboardType = .decimalPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized:"Добавить малыша"), for: .normal)
        button.addTarget(self, action: #selector(addBaby), for: .touchUpInside)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var activityLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized:"Добавляем малыша ....")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        // Create a stack view for each label-textfield pair
        let babyNameStackView = createStackView(with: babyNameLabel, textField: babyNameTextField)
        let birthDateStackView = createStackView(with: birthDateLabel, textField: birthDateButton)
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
            headCircumferenceStackView,
            addButton,
            activityIndicator,
            activityLabel
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
    
    private func createStackView(with label: UILabel, textField: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func birthDateButtonTapped() {
        let isHidden = calendarView.isHidden
        UIView.animate(withDuration: 0.3) {
            self.calendarView.isHidden = !isHidden
        }
    }
    
    @objc private func addBaby() {
        // Show activity indicator and label
        activityIndicator.startAnimating()
        activityLabel.isHidden = false
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.activityLabel.isHidden = true
            // Handle completion (e.g., show an alert or update UI)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == weightTextField || textField == heightTextField || textField == headCircumferenceTextField {
            addDoneButtonOnKeyboard(textField: textField)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.keyboardType == .decimalPad {
            addDoneButtonOnKeyboard(textField: textField)
        }
        return true
    }
    
    private func addDoneButtonOnKeyboard(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: String(localized:"Готово"), style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([flexSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
}

// UICalendarSelectionSingleDateDelegate
extension AddBabyViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents,
              let date = Calendar.current.date(from: dateComponents) else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy" // Set the desired date format
        birthDateButton.setTitle(dateFormatter.string(from: date), for: .normal)
        birthDateButton.setTitleColor(.black, for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.calendarView.isHidden = true
        }
    }
}
