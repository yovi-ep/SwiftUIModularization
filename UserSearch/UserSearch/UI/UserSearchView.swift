//
//  UserSearchView.swift
//  UserSearch
//
//  Created by Yovi Eka Putra on 17/07/21.
//

import SwiftUI
import Core
import Detail

public struct UserSearchView: View {
    @ObservedObject private var viewModel = UserSearchViewModel(
        repository: UserListRepositoryImpl(service: UserServicesImpl())
    )
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack {
                    TextField("Keywords", text: $viewModel.inKeyword)
                        .frame(height: 48)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    ForEach(viewModel.users) { user in
                        NavigationLink(destination: DetailView()) {
                            UserListRow(name: user.login ?? "", logoLink: user.avatar_url  ?? "")
                                .onAppear {
                                    viewModel.inLoadMore = user
                                }
                        }
                    }
                }
            })
            .navigationTitle("User Search")
        }
    }
}


struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}
