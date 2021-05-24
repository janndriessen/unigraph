//
//  ContentView.swift
//  unigraph
//
//  Created by Jann Driessen on 18.05.21.
//

import SwiftUI

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

struct FilterView: View {
    var arrowUp: Bool
    var selected: Bool
    var selectedColor: Color
    var title: String

    var body: some View {
        let highlightColor = selected ? selectedColor : .gray
        
        return (
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(selected ? .gray.opacity(0.1) : Color.white)
                HStack {
                    Text(title)
                        .bold()
                        .foregroundColor(highlightColor)
                        .font(.caption)
                    if selected {
                        Image(systemName: arrowUp ? "arrow.up" : "arrow.down")
                            .font(Font.system(.caption).bold())
                            .foregroundColor(selectedColor)
                            .padding(.leading, -4)
                    }
                }
                .padding(8)
            }
        )
    }
}


struct UnigraphToken {
    let name: String
}

struct UnigraphPair {
    let token0: UnigraphToken
    let token1: UnigraphToken
    let volumeUSD: Double
}

struct UnigraphPairs {
    let pairs: [UnigraphPair]
}

struct UnigraphReponse {
    let data: UnigraphPairs
}

struct ListItem {
    let id = UUID()
    let title: String
    let subtitle: String
    let detail: String
}

struct Token: Decodable {
    let chainId: Int
    let address: String
    let name: String
    let symbol: String
    let decimals: Int
    let logoURI: String
}

struct TokenList: Decodable {
    let name: String
    let tokens: [Token]
}

struct ContentView: View {
    @ObservedObject private var dataStore = DataStore()
    @State private var ascending: Bool = false
    @State private var selectedListId: UUID?

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Uniswap Pools")
                        .bold()
                        .padding()
                    Spacer()
                }
                .background(Color.purple)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer()
                        ForEach(dataStore.lists, id: \.id) { list in
                            FilterView(arrowUp: ascending, selected: selectedListId == list.id, selectedColor: list.selectedColor, title: list.title)
                                .animation(.spring())
                                .onTapGesture {
                                    let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                                    feedbackGenerator.impactOccurred()
                                    if selectedListId == list.id {
                                        self.ascending.toggle()
                                        return
                                    }
                                    self.ascending = false
                                    self.selectedListId = list.id
                                }
                        }
                    }
                }
                .frame(height: 32)
                VStack {
                    ForEach(dataStore.listItems, id: \.id) { item in
                        ListItemView(title: item.title, subtitle: item.subtitle, highlightColor: dataStore.getTokenPairList(for: selectedListId ?? UUID())?.selectedColor ?? .blue)
                    }
                }
            }
        }
        .onAppear {
            dataStore.parseTokenlist()
            dataStore.fetch()
            selectedListId = dataStore.lists.first?.id ?? nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
