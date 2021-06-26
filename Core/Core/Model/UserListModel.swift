//
//  UserListModel.swift
//  Core
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Foundation

public struct UserListResponse: Decodable {
    public private(set) var items: [UserListModel]
}

public struct UserListModel: Decodable, Identifiable {
    private(set) public var id: Int?
    private(set) public var login: String
}
