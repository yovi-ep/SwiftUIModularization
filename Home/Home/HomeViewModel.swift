//
//  HomeViewModel.swift
//  Home
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Combine
import Core

class HomeViewModel: ObservableObject {
    @Published var users: [UserListModel] = []
    fileprivate var cancellable = Set<AnyCancellable>()
    fileprivate var repository: UserListRepository
    
    init(repository: UserListRepository) {
        self.repository = repository
        self.getUsers()
    }
}

extension HomeViewModel {
    private func getUsers() {
        self.repository.get(path: "")
            .mapError { error -> Error in
                print(error)
                return error
            }
            .map { $0.items }
            .sink { _ in } receiveValue: { [weak self] data in
                self?.users.append(contentsOf: data)
            }.store(in: &cancellable)
    }
}
