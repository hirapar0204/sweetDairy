//
//  PostViewController.swift
//  sweetDairy
//
//  Created by 丸井一輝 on 2021/05/27.
//

import UIKit

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String)
    case comments(comments: [PostComment])
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}


class PostViewController: UIViewController {

    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels() {
        guard let userPostModel = self.model else {
            return
        }
        // header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        //actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        //4comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(
                PostComment(
                    identifier: "123_\(x)",
                    username: "@KM",
                    text: "Great post!",
                    createdDate: Date(),
                    likes: []
                )
            )
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_):return 1
        case .comments(let comments):return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_):return 1
        case .header(_):return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
        case .comments(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
        case .primaryContent(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostTableViewCell
                return cell
        case .header(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60
        case .comments(_): return 50
        case .primaryContent(_): return tableView.width
        case .header(_): return 70
        }
    }
}
