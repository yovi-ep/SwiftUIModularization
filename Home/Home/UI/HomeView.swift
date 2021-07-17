//
//  HomeView.swift
//  Home
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import SwiftUI
import UserSearch
import Favorites

public struct HomeView: View  {
    @State private var selected: Tab = Tab.userSearch
    
    public init() {}
    
    private enum Tab {
        case userSearch
        case favorite
    }
    
    public var body: some View {
        TabView(selection: $selected) {
            UserSearchView()
                .tag(Tab.userSearch)
                .tabItem {
                    Label("User", systemImage: "person")
                }
            
            FavoriteView()
                .tag(Tab.favorite)
                .tabItem {
                    Label("Favorite", systemImage: "star")
                }
        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
