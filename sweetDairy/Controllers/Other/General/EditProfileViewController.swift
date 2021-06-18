//
//  EditProfileViewController.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/27.
//

/*

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value : String?
}

final class EditProfileViewController: UIViewController,  UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self,
                           forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    var profileImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.tableHeaderView = createTableView()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.tableHeaderView = createTableView()
    }
    
    private func configureModels(){
        let section1Labels = ["Name"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
     //   let section2Labels = ["Email", "Phone", "Gender"]
     //   var section2 = [EditProfileFormModel]()
     //   for label in section2Labels {
     //       let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
     //       section2.append(model)
     //   }
     //   models.append(section2)
    }
        
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func createTableView() -> UIView{
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                        y: (header.height-size)/2,
                                                        width: size,
                                                        height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapChangeProfilePicture),
                                     for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(profileImageView?.image ,for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    @objc private func didTapProfilePhotoButton(){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "Private Information"
    }
    
    @objc private func didTapSave(){
        dismiss(animated: true,
                completion: nil)
        print(models)
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true,
                completion: nil)
        
    }
    
    @objc private func didTapChangeProfilePicture() {
        
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change profile picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            presentPickerController(sourceType: .camera)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            presentPickerController(sourceType: .photoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
    
        present(actionSheet, animated: true)
        
        func presentPickerController(sourceType: UIImagePickerController.SourceType){
            if UIImagePickerController.isSourceTypeAvailable(sourceType){
                let picker = UIImagePickerController()
                picker.sourceType = sourceType
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
            self.dismiss(animated: true, completion: nil)
            profileImageView?.image = info[.originalImage]as? UIImage
            profileImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        }

        tableView.tableHeaderView = createTableView()
    }

}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        //print("Field updated to: \(value ?? "nil")")
        
       // print(updatedModel.value ?? "nil")
    }
}

 

 */
