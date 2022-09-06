//
//  ViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import UIKit
import FirebaseAuth
import SwiftUI

struct HomeRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    var action: PostRenderViewModel
    let comments: PostRenderViewModel
}

final class HomeViewController: UIViewController {
    
    private var renderPost = [HomeRenderViewModel]()
    private var postModel = [UserPost]()
    
    private let tableView: UITableView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Home"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        mockData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handleUserLogin()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func handleUserLogin(){
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
    func mockData(){
        for _ in 0..<10 {
            let mockPost = UserPost(identifier: "000",
                                    postType: .photo,
                                    thumbnailImage: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!,
                                    postURL: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!,
                                    caption: "",
                                    likeCount: [],
                                    comments: [PostComment(identifier: "000",
                                                           username: "@Joe",
                                                           text: "Nice Picture",
                                                           createdDate: Date(),
                                                           likes: []),
                                               PostComment(identifier: "111",
                                                           username: "@Jennie",
                                                           text: "Cool Picture",
                                                           createdDate: Date(),
                                                           likes: []),
                                               PostComment(identifier: "222",
                                                           username: "@Dave",
                                                           text: "Awesom",
                                                           createdDate: Date(),
                                                           likes: []),
                                               PostComment(identifier: "333",
                                                           username: "@Michael",
                                                           text: "Perfect Picture",
                                                           createdDate: Date(),
                                                           likes: [])],
                                    createdDate: Date(),
                                    taggedUsers: [],
                                    user: User(username: "@Kayne_west",
                                               bio: "",
                                               counts: UserCount(followers: 0,
                                                                 following: 0,
                                                                 posts: 0),
                                               name: (first: "John", last: "Blue"),
                                               birthDate: Date(),
                                               gender: .male,
                                               profilePhoto: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!,
                                               joinedDate: Date(),
                                               posts: []))
            
            let mockPost2 = UserPost(identifier: "000",
                                    postType: .video,
                                    thumbnailImage: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!,
                                    postURL: URL(string: "https://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!,
                                    caption: "",
                                    likeCount: [],
                                    comments: [PostComment(identifier: "000",
                                                           username: "@Joe",
                                                           text: "Nice Picture",
                                                           createdDate: Date(),
                                                           likes: []),
                                               PostComment(identifier: "111",
                                                           username: "@Jennie",
                                                           text: "Cool Picture",
                                                           createdDate: Date(),
                                                           likes: [])],
                                    createdDate: Date(),
                                    taggedUsers: [],
                                    user: User(username: "@Joe",
                                               bio: "",
                                               counts: UserCount(followers: 0,
                                                                 following: 0,
                                                                 posts: 0),
                                               name: (first: "John", last: "Blue"),
                                               birthDate: Date(),
                                               gender: .male,
                                               profilePhoto: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!,
                                               joinedDate: Date(),
                                               posts: []))
            
            let render = HomeRenderViewModel(
                header: PostRenderViewModel(renderType: .header(user: mockPost.user)),
                post: PostRenderViewModel(renderType: .primaryContent(provider: mockPost)),
                action: PostRenderViewModel(renderType: .actions(provider: nil)),
                comments: PostRenderViewModel(renderType: .comments(comments: mockPost.comments)))
            
            let render2 = HomeRenderViewModel(
                header: PostRenderViewModel(renderType: .header(user: mockPost2.user)),
                post: PostRenderViewModel(renderType: .primaryContent(provider: mockPost2)),
                action: PostRenderViewModel(renderType: .actions(provider: .like)),
                comments: PostRenderViewModel(renderType: .comments(comments: mockPost2.comments)))
            
            renderPost.append(render)
            renderPost.append(render2)
            postModel.append(mockPost)
            postModel.append(mockPost2)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderPost.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let position = x % 4 == 0 ? x/4 : (x - (x % 4))/4
        if x % 4 == 0{
            return 1
        }else if x % 4 == 1{
            return 1
        }else if x % 4 == 2{
            return 1
        }else if x % 4 == 3{
            return postModel[position].comments.count > 4 ? 4 : postModel[position].comments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let position = x % 4 == 0 ? x/4 : (x - (x % 4))/4
        let model = renderPost[position]
        let postModel = postModel[position]
        if x % 4 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedHeaderTableViewCell.identifier, for: indexPath) as! IGHomeFeedHeaderTableViewCell
            cell.delegate = self
            cell.configure(with: postModel, position: position)
            return cell
        }else if x % 4 == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedTableViewCell.identifier, for: indexPath) as! IGHomeFeedTableViewCell
            cell.configure(with: postModel)
            return cell
        }else if x % 4 == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedActionTableViewCell.identifier, for: indexPath) as! IGHomeFeedActionTableViewCell
            cell.delegate = self
            cell.configure(with: model, position: position)
            return cell
        }else if x % 4 == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: IGHomeFeedGeneralTableViewCell.identifier, for: indexPath) as! IGHomeFeedGeneralTableViewCell
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let x = indexPath.section
        if x % 4 == 0{
            return 72
        }else if x % 4 == 1{
            return tableView.width
        }else if x % 4 == 2{
            return 60
        }else if x % 4 == 3{
            return 72
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return section % 4 == 0 ? view : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        let subSection = section % 4
        return subSection % 4 == 0 ? 70 : 0
    }
}


extension HomeViewController: IGHomeFeedHeaderTableViewCellDelegate, IGHomeFeedActionTableViewCellDelegate {
    func didTapLikeButton(with model: HomeRenderViewModel, position: Int) {
        renderPost[position] = model
        //update table view cell at its position
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didTapCommentButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapCommentButton")
    }
    
    func didTapShareButton(with model: HomeRenderViewModel, position: Int) {
        print("didTapShareButton")
    }
    
    func didTapMoreButton(with model: UserPost, position: Int) {
        let actionSheet = UIAlertController(title: "Post Options",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post",
                                            style: .destructive,
                                            handler: { [weak self] _ in
            self?.reportPost()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func reportPost(){
        
    }
}
