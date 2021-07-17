//
//  UserSearchViewModel.swift
//  Home
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import Combine
import Core

class UserSearchViewModel: ObservableObject {
    @Published var users: [UserListModel] = []
    @Published var inKeyword: String = ""
    fileprivate var cancellable = Set<AnyCancellable>()
    fileprivate var repository: UserListRepository
    
    init(repository: UserListRepository) {
        self.repository = repository
        self.binding()
    }
}

extension UserSearchViewModel {
    private func binding() {
        $inKeyword
            .filter { $0.isEmpty == false }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] keyword in
                self?.searching(keyword)
            }.store(in: &cancellable)
    }
    
    private func searching(_ query: String) {
        repository.get(path: query)
            .map { $0.items }
            .sink { completion  in
                switch completion {
                case let .failure(error):
                    print("searching", error)
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] users in
                self?.users.removeAll()
                self?.users.append(contentsOf: users)
            }.store(in: &cancellable)
    }
}
