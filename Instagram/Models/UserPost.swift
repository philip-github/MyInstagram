//
//  UserPost.swift
//  Instagram
//
//  Created by Philip Twal on 8/23/22.
//

import Foundation

struct User {
    let username: String
    let bio: String
    let counts: UserCount
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let profilePhoto: URL
    let joinedDate: Date
    let posts: [UserPost]
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

enum Gender {
    case male, female, other
}


enum UserPostType: String{
    case photo = "Photo"
    case video = "Video"
}

struct UserPost{
    let identifier: String
    var postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let user: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

