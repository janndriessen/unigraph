//
//  ContentView.swift
//  unigraph
//
//  Created by Jann Driessen on 18.05.21.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .bold()
                .padding(.horizontal, 16)
                .padding(.top, 16)
            Spacer()
        }
    }
}

struct ContentView: View {
    @ObservedObject private var dataStore = DataStore()
    @State private var ascending: Bool = false
    @State private var selectedListId: UUID?
    @State private var selectedListListId: UUID?

    private func listItems() -> [ListItem] {
        let listItems = selectedListId == dataStore.lists.first?.id ?? nil ? dataStore.listItems : dataStore.listItems2
        if ascending {
            return listItems.reversed()
        }
        return listItems
    }

    var body: some View {
        ScrollView {
            VStack {
                HeaderView(title: "Lists")
                ListFilterView(lists: dataStore.lists2, selectedListId: $selectedListListId)
                VStack {
                    ForEach(dataStore.trendingItems, id: \.id) { item in
                        ListCell(title: item.title, subtitle: item.subtitle)
                    }
                }
                .padding(.bottom, 16)
                HeaderView(title: "🦄 Uniswap Pools")
                UniswapFilterListView(lists: dataStore.lists, ascending: $ascending, selectedListId: $selectedListId)
                VStack {
                    ForEach(listItems(), id: \.id) { item in
                        ListItemView(title: item.title, subtitle: item.subtitle, highlightColor: dataStore.getTokenPairList(for: selectedListId ?? UUID())?.selectedColor ?? .blue, detail: item.detail)
                    }
                }
            }
        }
        .onAppear {
            dataStore.parseTokenlist()
            dataStore.fetch()
            dataStore.fetch2()
            selectedListId = dataStore.lists.first?.id ?? nil
            selectedListListId = dataStore.lists2.first?.id ?? nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
