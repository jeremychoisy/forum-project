//
//  Post.swift
//  swiftProject
//
//  Created by mbds on 03/02/2021.
//

import Foundation

struct Post: Decodable {
    let userId, id: Int
    let title, body: String
}
