//
//  ContentView.swift
//  unigraph
//
//  Created by Jann Driessen on 18.05.21.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("🦄 Uniswap Pools")
                .bold()
                .padding(.horizontal, 16)
                .padding(.top, 16)
            Spacer()
        }
    }
}

struct FilterListView: View {
    var lists: [TokenPairList]
    @Binding var ascending: Bool
    @Binding var selectedListId: UUID?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                ForEach(lists, id: \.id) { list in
                    FilterView(arrowUp: ascending, selected: selectedListId == list.id, selectedColor: list.selectedColor, title: list.title)
                        .animation(.spring())
                        .onTapGesture {
                            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                            feedbackGenerator.impactOccurred()
                            if selectedListId == list.id {
                                ascending.toggle()
                                return
                            }
                            ascending = false
                            selectedListId = list.id
                        }
                }
            }
        }
        .frame(height: 32)
        .padding(.bottom, 4)
    }
}

struct ContentView: View {
    @ObservedObject private var dataStore = DataStore()
    @State private var ascending: Bool = false
    @State private var selectedListId: UUID?

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
                HeaderView()
                FilterListView(lists: dataStore.lists, ascending: $ascending, selectedListId: $selectedListId)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
