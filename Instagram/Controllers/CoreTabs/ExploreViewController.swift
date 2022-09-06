//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import UIKit

final class ExploreViewController: UIViewController {
    
    private var userPosts = [UserPost]()
    
    private var exploreCollectionView: UICollectionView?
    private var tabbedCollectionView: UICollectionView?
    
    private var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchBar.delegate = self
        view.backgroundColor = .systemBackground
        configureSearchBar()
        configureExploreCollectionView()
        configureTabbedCollectionView()
        mockData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dimmedView.frame = view.bounds
        exploreCollectionView?.frame = view.bounds
        tabbedCollectionView?.frame = CGRect(x: 0,
                                             y: view.safeAreaInsets.top + 10,
                                             width: view.width - 4,
                                             height: 150)
    }
    
    private func configureTabbedCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.width - 10)/3, height: (view.width - 10)/3)
        layout.minimumLineSpacing = 2.5
        layout.minimumInteritemSpacing = 2.5
        layout.scrollDirection = .horizontal
        tabbedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let tabbedCollection = tabbedCollectionView else { return }
        tabbedCollection.isHidden = true
        tabbedCollection.register(UICollectionViewCell.self,
                                  forCellWithReuseIdentifier: "cell")
        tabbedCollection.delegate = self
        tabbedCollection.dataSource = self
        
        tabbedCollection.backgroundColor = .secondarySystemBackground
        
        view.addSubview(tabbedCollection)
    }
    
    private func configureExploreCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width-4)/3.0, height: (view.width-4)/3.0)
        exploreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = exploreCollectionView else { return }
        collectionView.register(PhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func configureSearchBar(){
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        view.addSubview(dimmedView)
        let dimmedGesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        dimmedGesture.numberOfTapsRequired = 1
        dimmedGesture.numberOfTouchesRequired = 1
        dimmedView.addGestureRecognizer(dimmedGesture)
        
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
            userPosts.append(mockPost)
            userPosts.append(mockPost2)
        }
    }
}


extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            // should be configured in a custom collection view cell...
            cell.backgroundColor = .label
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 3.0
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.secondaryLabel.cgColor
            return cell
        }
        let data = userPosts[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: data)
        return cell
    }
    func query(_ string: String) {
        
    }
}


extension ExploreViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        guard let text = searchBar.text, !text.isEmpty else { return }
        query(text)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.dimmedView.alpha = 0
        }) { done in
            if done {
                self.dimmedView.isHidden = true
                self.tabbedCollectionView?.isHidden = false
            }
        }
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didCancelSearch))
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.dimmedView.isHidden = false
            self?.dimmedView.alpha = 0.5
        }) { done in
            if done {
                self.exploreCollectionView?.isHidden = true
                self.tabbedCollectionView?.isHidden = false
                DispatchQueue.main.async {
                    self.tabbedCollectionView?.reloadData()
                }
            }
        }
    }
    
    @objc private func didCancelSearch(){
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.dimmedView.alpha = 0.5
        }) { done in
            if done {
                self.dimmedView.isHidden = true
                self.exploreCollectionView?.isHidden = false
                self.tabbedCollectionView?.isHidden = true
            }
        }
    }
}
