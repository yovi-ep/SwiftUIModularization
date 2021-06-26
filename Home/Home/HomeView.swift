//
//  HomeView.swift
//  Home
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import SwiftUI
import Core

public struct HomeView: View  {
    @ObservedObject private var viewModel = HomeViewModel(
        repository: UserListRepositoryImpl(service: UserServicesImpl())
    )
    
    public init() {}
//    init(viewModel: HomeViewModel) {
//        self.viewModel = viewModel
//    }
    
    public var body: some View {
        List(viewModel.users) { data in
            HStack(alignment: .center, spacing: nil, content: {
                Text(data.login)
            })
        }
    }
}
