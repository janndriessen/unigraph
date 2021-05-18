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

struct ContentView: View {
    private var lists = TokenPairList.lists
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
                        ForEach(lists, id: \.id) { list in
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
