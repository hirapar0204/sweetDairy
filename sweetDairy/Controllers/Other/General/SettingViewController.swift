//
//  SettingViewController.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/27.
//


import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingViewController: UIViewController {
    

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        data.append([
                SettingCellModel(title: "Edit Profile") { [weak self] in
                    self?.didTapEditProfile()
                },
                SettingCellModel(title: "Save Original Posts") { [weak self] in
                    self?.didTapSaveOriginalPosts()
                }
        ])
    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    
   // private func configureModels() {
   //     let section = [
   //             SettingCellModel(title: "Log Out") { [weak self] in
   //             self?.didTapLogout()
    //            }
   //     ]
   //     data.append(section)
   // }
    
  //  private func didTapLogOut() {
  
  //  }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
