//
//  HomeView.swift
//  Fungi Incognita
//
//  Created by Natalia Andryushina on 2022-04-30.
//

import SwiftUI

struct FungiesList: View {
    @EnvironmentObject var fungiRepository: FungiRepository
    @SceneStorage("searchText") private var searchText = ""
    var onlyFavorities: Bool
    var bottomPadding: CGFloat = 40
    var body: some View {
        NavigationView {
            List {
                ForEach(fungiRepository.searchResults(searchText: searchText,
                                                      onlyFavorites: onlyFavorities), id: \.self) { fungi in
                    FungiShortInfo(fungi: fungi)
                        .environmentObject(fungiRepository)
                        .listRowSeparator(.hidden)
                }.listRowBackground(colorForListRowBackground)
            }
            .navigationTitle("Fungies")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)) {
            ForEach(fungiRepository.searchResults(searchText: searchText,
                                                  onlyFavorites: onlyFavorities), id: \.self) { result in
                Text("Are you looking for \(result.name)?").searchCompletion(result.name)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}
