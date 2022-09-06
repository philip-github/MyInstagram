//
//  PostViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import UIKit

enum PostActions {
    case like
    case unlike
    case comment
    case share
}

enum PostRenderType{
    case header(user: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: PostActions?) // like, comment, share
    case comments(comments: [PostComment])
}

/// Render Post Model
struct PostRenderViewModel {
    var renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(IGHomeFeedTableViewCell.self,
                       forCellReuseIdentifier: IGHomeFeedTableViewCell.identifier)
        table.register(IGHomeFeedHeaderTableViewCell.self,
                       forCellReuseIdentifier: IGHomeFeedHeaderTableViewCell.identifier)
        table.register(IGHomeFeedActionTableViewCell.self,
                       forCellReuseIdentifier: IGHomeFeedActionTableViewCell.identifier)
        table.register(IGHomeFeedGeneralTableViewCell.self,
                       forCellReuseIdentifier: IGHomeFeedGeneralTableViewCell.identifier)
        return table
    }()
    
    private let model: UserPost?
    
    private var renderPost = [PostRenderViewModel]()
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("PostViewController Fatal Error Init!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        mockData() 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func mockData() {
        renderPost = [PostRenderViewModel(renderType: .header(user: model!.user)),
                      PostRenderViewModel(renderType: .primaryContent(provider: model!)),
                      PostRenderViewModel(renderType: .actions(provider: nil)),
                      PostRenderViewModel(renderType: .comments(comments: model!.comments))]
    }
}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderPost.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderPost[section].renderType{
        case .header(_):
            return 1
        case.primaryContent(_):
            return 1
        case.actions(_):
            return 1
        case .comments(let comments):
            return comments.count > 4 ? 4 : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let renderModel = renderPost[indexPath.section]
        switch renderModel.renderType{
        case .header(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedHeaderTableViewCell.identifier, for: indexPath) as! IGHomeFeedHeaderTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedTableViewCell.identifier, for: indexPath) as! IGHomeFeedTableViewCell
            print(post.postURL)
            return cell
            
        case .actions(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedActionTableViewCell.identifier, for: indexPath) as! IGHomeFeedActionTableViewCell
            cell.delegate = self
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedGeneralTableViewCell.identifier, for: indexPath) as! IGHomeFeedGeneralTableViewCell
            print(comments[indexPath.row].username)
            print(comments[indexPath.row].text)
            print(comments[indexPath.row].identifier)
            print(comments[indexPath.row].createdDate)
            debugPrint()
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let renderModel = renderPost[indexPath.section]
        switch renderModel.renderType{
        case .header(_):
            return 72
        case .primaryContent(_):
            return tableView.width
        case .actions(_):
            return 62
        case .comments(_):
            return 72
        }
    }
}


extension PostViewController: IGHomeFeedActionTableViewCellDelegate {
    func didTapLikeButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapLikeButton")
    }
    
    func didTapCommentButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapCommentButton")
    }
    
    func didTapShareButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapShareButton")
    }
}
