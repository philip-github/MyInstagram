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
    
    private let model: UserPost
    private var renderPost = [HomeRenderViewModel]()
    
    init(model: UserPost) {
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
        renderPost.append(HomeRenderViewModel(
            header: PostRenderViewModel(renderType: .header(user: model.user)),
            post: PostRenderViewModel(renderType: .primaryContent(provider: model)),
            action: PostRenderViewModel(renderType: .actions(provider: nil)),
            comments: PostRenderViewModel(renderType: .comments(comments: model.comments))))
    }
}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderPost.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let position = x % 4 == 0 ? x/4 : (x - (x % 4))/4
        let renderModel = renderPost[position]
        
        if x % 4 == 0 {
            return 1
        }else if x % 4 == 1{
            return 1
        }else if x % 4 == 2{
            return 1
        }else if x % 4 == 3{
            switch renderModel.comments.renderType{
            case .comments(let comments):
                return comments.count > 4 ? 4 : comments.count
            case .actions, .primaryContent, .header:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let position = x % 4 == 0 ? x/4 : (x - (x % 4))/4
        let renderModel = renderPost[position]
        
        if x % 4 == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IGHomeFeedHeaderTableViewCell.identifier,
                for: indexPath) as? IGHomeFeedHeaderTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: model)
            return cell
        }else if x % 4 == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IGHomeFeedTableViewCell.identifier,
                for: indexPath) as? IGHomeFeedTableViewCell else { return UITableViewCell() }
            cell.configure(with: model)
            return cell
        }else if x % 4 == 2 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IGHomeFeedActionTableViewCell.identifier,
                for: indexPath) as? IGHomeFeedActionTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: renderModel, position: position)
            return cell
        }else if x % 4 == 3 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IGHomeFeedGeneralTableViewCell.identifier,
                for: indexPath) as? IGHomeFeedGeneralTableViewCell else { return UITableViewCell() }
            return cell
        }
        
        //should not trigger
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let x = indexPath.section
        if x % 4 == 0 {
            return 72
        }else if x % 4 == 1{
            return tableView.width
        }else if x % 4 == 2{
            return 62
        }else if x % 4 == 3{
            return 72
        }
        return 0
    }
}


extension PostViewController: IGHomeFeedHeaderTableViewCellDelegate ,IGHomeFeedActionTableViewCellDelegate {
    
    
    func didTapLikeButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapLikeButton")
    }
    
    func didTapCommentButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapCommentButton")
    }
    
    func didTapShareButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapShareButton")
    }
    
    func didTapMoreButton(with model: UserPost) {
        print("didTapMoreButton")
    }
}
