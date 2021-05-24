//
//  data.swift
//  unigraph
//
//  Created by Jann Driessen on 23.05.21.
//

import Apollo
import Foundation

class DataStore: ObservableObject {
    @Published var listItems: [ListItem] = []
    private (set) var lists = TokenPairList.lists
    private lazy var client = ApolloClient(url: URL(string: "https://api.thegraph.com/subgraphs/name/uniswap/uniswap-v2")!)

    func getTokenPairList(for id: UUID) -> TokenPairList? {
        return lists.filter { $0.id == id }.first
    }

    func fetch() {
        client.fetch(query: AllTokensQueryQuery()) { result in
            switch result {
            case .success(let response):
                //                print(response.data?.pairs)
                guard let pairs = response.data?.pairs else { return }
                let listItems = pairs.map { pair in
                    ListItem(title: "\(pair.token0.symbol)-\(pair.token1.symbol)", subtitle: "UNI-V2", detail: pair.volumeUsd)
                }
                self.listItems = listItems
            case .failure(let error):
                print(error)
            }
        }
    }

    func parseTokenlist() {
        guard let url = Bundle.main.url(forResource: "tokenlist", withExtension: "json") else {
            fatalError("Failed to locate file in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load data from bundle.")
        }
        
        guard let tokenlist = try? JSONDecoder().decode(TokenList.self, from: data) else {
            return
        }
        
        tokenlist.tokens.forEach { token in
            print(token.name)
        }
    }
}
