//
//  ContentView.swift
//  unigraph
//
//  Created by Jann Driessen on 18.05.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var dataStore = DataStore()
    @State private var ascending: Bool = false
    @State private var selectedListId: UUID?

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("🦄 Uniswap Pools")
                        .bold()
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    Spacer()
                }
                .background(Color.white)
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
                .padding(.bottom, 4)
                VStack {
                    ForEach(dataStore.listItems, id: \.id) { item in
                        ListItemView(title: item.title, subtitle: item.subtitle, highlightColor: dataStore.getTokenPairList(for: selectedListId ?? UUID())?.selectedColor ?? .blue, detail: item.detail)
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
