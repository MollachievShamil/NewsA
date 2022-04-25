//
//  ProfileVC.swift
//  FourthProject
//
//  Created by shamil.mollachiev on 20.04.2022.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    var presenter: ProfilePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        addTextFields()
        setupViews()
        setupConstraints()
        setupDataPicker()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTransition(alpha: 0)
        setupLabels()
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.setTransition(alpha: 1)
        }
    }
    
    // MARK: - SetupLabels
    func setupLabels() {
        presenter.getInfoForLabels { firstName, dateOfBirth, gender, image in
            firstNameTextField.text = firstName
            dateTextField.text = dateOfBirth
            genderTextField.text = gender
            imageView.image = image
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "dd-MM-yyyy"
            let date = dateFormatter.date(from: dateOfBirth)
            datePicker.date = date!
            segmentControl.selectedSegmentIndex = gender == "female" ? 0 : 1
        }
    }
    // MARK: - Func for animation
    func setTransition(alpha: Double) {
        self.imageView.alpha = alpha
        self.changePhotoButton.alpha = alpha
        self.dateTextField.alpha = alpha
        self.segmentControl.alpha = alpha
        self.imageView.alpha = alpha
        self.genderTextField.alpha = alpha
        self.saveChangesButton.alpha = alpha
        self.genderTextField.alpha = alpha
        self.firstNameTextField.alpha = alpha
        self.datePicker.alpha = alpha
    }
    
    // MARK: - Picker
    let picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()
    
    // MARK: - SegmentControl
    let segmentControl: UISegmentedControl = {
        let cont = UISegmentedControl(items: ["female", "male"])
        cont.translatesAutoresizingMaskIntoConstraints = false
        cont.addTarget(self, action: #selector(segmentControlTapped(_:)), for: .valueChanged)
        return cont
    }()
    @objc func segmentControlTapped(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            genderTextField.text = "female"
        default:
            genderTextField.text = "male"
        }
    }
    // MARK: - ImageView
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - TextFields
    var firstNameTextField = UITextField()
    var genderTextField = UITextField()
    var dateTextField = UITextField()
    func createNewTextField(placeholderText: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholderText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func addTextFields() {
        firstNameTextField = createNewTextField(placeholderText: "First Name")
        genderTextField = createNewTextField(placeholderText: "Choise gender")
        dateTextField = createNewTextField(placeholderText: "dd-MM-yyyy")
    }
    
    // MARK: - DatePicker
    let datePicker = UIDatePicker()
    func setupDataPicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = #colorLiteral(red: 0.8810099265, green: 0.8810099265, blue: 0.8810099265, alpha: 1)
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    @objc func datePickerValueChanged () {
        print(datePicker.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let str = dateFormatter.string(from: datePicker.date)
        dateTextField.text = str
    }
    // MARK: - Buttons
    let changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.setTitle("ChangePhoto", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func changePhotoTapped() {
        self.present(picker, animated: true, completion: nil)
    }
    let saveChangesButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.setTitle("SaveChanges", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveChangesTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func saveChangesTapped() {
        let name = firstNameTextField.text ?? " No Name"
        let gender = genderTextField.text ?? "No gender"
        let dateOfBirth = dateTextField.text ?? "00.00.000"
        let defImage = UIImage(systemName: "trash")?.pngData()
        let imageData = imageView.image?.pngData() ?? defImage!
        CoreDataManager.shared.saveProfileToCoreData(name:name, gender: gender,
                                                     dateOfBirth: dateOfBirth,
                                                     imageData: imageData)
    }
}

// MARK: -  TextField Settings
extension ProfileVC: UITextFieldDelegate {
    func setupDelegate() {
        firstNameTextField.delegate = self
        dateTextField.delegate = self
        picker.delegate = self
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacter = CharacterSet.letters
        let allowedCharacter1 = CharacterSet.whitespaces
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
    }
}
// MARK: - SetupConstraints
extension ProfileVC {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(firstNameTextField)
        view.addSubview(segmentControl)
        view.addSubview(genderTextField)
        view.addSubview(saveChangesButton)
        view.addSubview(imageView)
        view.addSubview(changePhotoButton)
        view.addSubview(dateTextField)
        view.addSubview(datePicker)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            dateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateTextField.heightAnchor.constraint(equalToConstant: 40),
            dateTextField.trailingAnchor.constraint(equalTo: genderTextField.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 10),
            segmentControl.widthAnchor.constraint(equalToConstant: 150),
            segmentControl.heightAnchor.constraint(equalToConstant: 40),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            genderTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 10),
            genderTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderTextField.heightAnchor.constraint(equalToConstant: 40),
            genderTextField.trailingAnchor.constraint(equalTo: segmentControl.leadingAnchor, constant: -5)
        ])
        NSLayoutConstraint.activate([
            changePhotoButton.bottomAnchor.constraint(equalTo: saveChangesButton.topAnchor, constant: -10),
            changePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePhotoButton.heightAnchor.constraint(equalToConstant: 40),
            changePhotoButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            saveChangesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveChangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveChangesButton.heightAnchor.constraint(equalToConstant: 40),
            saveChangesButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalToConstant: 150),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - Image Picker To get Image from Photo Library
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC: ProfileViewProtocol {
}
