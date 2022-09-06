//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    var type: UserNotificationType
    var text: String
    var user: User
}

final class NotificationsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NotificationsFollowEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationsFollowEventTableViewCell.identifier)
        table.register(NotificationsLikeEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationsLikeEventTableViewCell.identifier)
        table.isHidden = false
        return table
    }()
    
    private lazy var noNotificationView = NoNotificationView()
    
    private var model = [UserNotification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Notifications"
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        mockData()
        //        view.addSubview(noNotificationView)
    }
    
    //MARK: Mock data
    func mockData(){
        for i in 1...20 {
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
            
            let obj = UserNotification(type: i % 2 == 0 ? .like(post: mockPost) : .follow(state: .following),
                                       text: i % 2 == 0 ? "@Phil Liked your post" : "@Phil requested to follow you",
                                       user: User(username: "@Phil",
                                                  bio: "",
                                                  counts: UserCount(followers: 0,
                                                                    following: 0,
                                                                    posts: 0),
                                                  name: (first: "Philip", last: "Al-Twal"),
                                                  birthDate: Date(),
                                                  gender: .male,
                                                  profilePhoto: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!,
                                                  joinedDate: Date(),
                                                  posts: []))
            model.append(obj)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noNotificationView.frame = CGRect(x: 0,
                                          y: 0,
                                          width: view.width - 10,
                                          height: view.width/3)
        noNotificationView.center = view.center
    }
}


extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = model[indexPath.row]
        switch data.type {
        case .like:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsLikeEventTableViewCell.identifier, for: indexPath) as! NotificationsLikeEventTableViewCell
            cell.delegate = self
            cell.configure(with: data)
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsFollowEventTableViewCell.identifier, for: indexPath) as! NotificationsFollowEventTableViewCell
            cell.delegate = self
            cell.configure(with: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension NotificationsViewController: NotificationsFollowEventTableViewCellDelegate, NotificationsLikeEventTableViewCellDelegate {
    
    func didTapFollowUnFollowButton(with model: UserNotification) {
        print("didTapFollowUnFollowButton")
    }
    
    func didTapPostButton(with model: UserNotification) {
        switch model.type{
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Error [     ] line 146 should not be called")
        }
    }
}
