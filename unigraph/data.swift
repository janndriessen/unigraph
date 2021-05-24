//
//  data.swift
//  unigraph
//
//  Created by Jann Driessen on 23.05.21.
//

import Apollo
import Foundation
import SwiftUI

struct ListItem {
    let id = UUID()
    let title: String
    let subtitle: String
    let detail: String
}

struct TokenPairList {
    let id = UUID()
    let selectedColor: Color
    let title: String
}

extension TokenPairList {
    static var lists: [TokenPairList] {
        return [
            TokenPairList(selectedColor: .blue, title: "Pool size"),
            TokenPairList(selectedColor: .green, title: "Annualized fees"),
            TokenPairList(selectedColor: .green, title: "30d profit"),
            TokenPairList(selectedColor: .purple, title: "24h volume"),
        ]
    }
}

class DataStore: ObservableObject {
    @Published var listItems: [ListItem] = []
    private (set) var lists = TokenPairList.lists
    private lazy var client = ApolloClient(url: URL(string: "https://api.thegraph.com/subgraphs/name/uniswap/uniswap-v2")!)

    func fetch() {
        client.fetch(query: AllTokensQueryQuery()) { result in
            switch result {
            case .success(let response):
                guard let pairs = response.data?.pairs else { return }
                let listItems: [ListItem] = pairs.map { pair in
                    let volumeFormatted = self.numberFormatter(Double(pair.volumeUsd) ?? 0)
                    return ListItem(title: "\(pair.token0.symbol)-\(pair.token1.symbol)", subtitle: "UNI-V2", detail: volumeFormatted)
                }
                self.listItems = listItems
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetch2() {
        client.fetch(query: AllPairsDayQuery()) { result in
            switch result {
            case .success(let response):
                guard let datas = response.data?.pairDayDatas else { return }
                let listItems: [ListItem] = datas.map { pair in
                    let volumeFormatted = self.numberFormatter(Double(pair.dailyVolumeUsd) ?? 0)
                    return ListItem(title: "\(pair.token0.symbol)-\(pair.token1.symbol)", subtitle: "UNI-V2", detail: volumeFormatted)
                }
                self.listItems = listItems
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetch3() {
        client.fetch(query: AllPairsHourlyQuery()) { result in
            switch result {
            case .success(let response):
                guard let datas = response.data?.pairHourDatas else { return }
                let listItems: [ListItem] = datas.map { data in
                    let volumeFormatted = self.numberFormatter(Double(data.hourlyVolumeUsd) ?? 0)
                    print(volumeFormatted, data.hourlyVolumeUsd)
                    return ListItem(title: "\(data.pair.token0)-\(data.pair.token1.symbol)", subtitle: "UNI-V2", detail: volumeFormatted)
                }
                self.listItems = listItems
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DataStore {
    func getTokenPairList(for id: UUID) -> TokenPairList? {
        return lists.filter { $0.id == id }.first
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

extension DataStore {
    private func numberFormatter(_ n: Double) -> String {
        var amount: String = ""
        var result: Double = 0

        if n >= 1e9 {
            amount = "bn"
            result = n / 1e9
        } else if n >= 1e6 {
            amount = "m"
            result = n / 1e6
            
        } else if n >= 1e3 {
            amount = "k"
            result = n / 1e3
        }

        if result == 0 {
            result = n
        }

        let volumeFormatted = String(format: "$%.2f\(amount)", result)
        return volumeFormatted
    }
}

private struct Token: Decodable {
    let chainId: Int
    let address: String
    let name: String
    let symbol: String
    let decimals: Int
    let logoURI: String
}

private struct TokenList: Decodable {
    let name: String
    let tokens: [Token]
}
