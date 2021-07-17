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
    @Published var inLoadMore: UserListModel?
    
    fileprivate var cancellable = Set<AnyCancellable>()
    fileprivate var repository: UserListRepository
    fileprivate var currentPage: Int = 1
    fileprivate var isLastPage: Bool = false
    
    init(repository: UserListRepository) {
        self.repository = repository
        self.binding()
    }
}

extension UserSearchViewModel {
    private func binding() {
        $inKeyword
            .filter { $0.isEmpty == false }
            .debounce(for: .milliseconds(750), scheduler: DispatchQueue.main)
            .sink { [weak self] keyword in
                self?.searching(keyword)
            }.store(in: &cancellable)
        
        $inLoadMore
            .filter({ [weak self] _ in self?.isLastPage == false }) //last page checking
            .compactMap({ $0 })
            .filter { [weak self] user in //last offset scrollable
                guard let `self` = self else { return false }
                let thresholdIndex = self.users.index(self.users.endIndex, offsetBy: -3)
                return self.users.lastIndex(where: { $0.id == user.id }) == thresholdIndex
            }
            .map { [weak self] _ in (self?.currentPage ?? 0) + 1 } //next page
            .sink { [weak self] nextPage in
                self?.searching(self?.inKeyword ?? "", page: nextPage)
            }.store(in: &cancellable)
    }
    
    private func searching(_ query: String, page: Int = 1) {
        repository.get(keyword: query, page: page, perPage: 10)
            .sink { completion  in
                switch completion {
                case let .failure(error):
                    print("searching error: ", error)
                case .finished:
                    print("searching finish")
                }
            } receiveValue: { [weak self] response in
                print("searching receive value")
                let items = response.items ?? []
                let lastPage = response.incomplete_results ?? false
                
                if (page == 1) { self?.users.removeAll() }
                
                self?.users.append(contentsOf: items)
                self?.currentPage = page
                self?.isLastPage = lastPage
            }.store(in: &cancellable)
    }
}
