//
//  Comment.swift
//  swiftProject
//
//  Created by mbds on 03/02/2021.
//

import Foundation

struct Comment: Decodable {
    let postId, id: Int
    let name, email, body: String
}
