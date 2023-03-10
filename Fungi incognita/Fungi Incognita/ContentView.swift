//
//  ContentView.swift
//  Fungi incognita
//
//  Created by Natalia Andryushina on 2022-04-30.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTabBar = TabImems.home
    @State public var xOffSet: Double = 0
    @EnvironmentObject var fungiRepository: FungiRepository
    @Environment(\.colorScheme) var colorScheme

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {

        VStack(alignment: .center) {
            TabView(selection: $selectedTabBar) {
                switch selectedTabBar {
                case .home:
                    FungiesList(onlyFavorities: false).environmentObject(fungiRepository)
                case .favList:
                    FungiesList(onlyFavorities: true).environmentObject(fungiRepository)
                case .identificationFungi:
                    IdentificationView(classifier: ImageClassifier())
                case .person:
                    ProfileView()
                case .settings:
                    InfoView()
                }
            }
            HStack {
                TabBarItem(imageName: "house",
                           tag: .home,
                           selectedTabBar: $selectedTabBar,
                           isSystemImage: true,
                           isFirst: true,
                           xOffSet: $xOffSet)
                Spacer(minLength: 0)
                TabBarItem(imageName: "bookmark",
                           tag: .favList,
                           selectedTabBar: $selectedTabBar,
                           isSystemImage: true,
                           isFirst: false,
                           xOffSet: $xOffSet)

                Spacer(minLength: 0)
                TabBarItem(imageName: "fungi",
                           tag: .identificationFungi,
                           selectedTabBar: $selectedTabBar,
                           isSystemImage: false,
                           isFirst: false,
                           xOffSet: $xOffSet)
                Spacer(minLength: 0)
                TabBarItem(imageName: "person",
                           tag: .person,
                           selectedTabBar: $selectedTabBar,
                           isSystemImage: true,
                           isFirst: false,
                           xOffSet: $xOffSet)
                Spacer(minLength: 0)
                TabBarItem(imageName: "info.circle",
                           tag: .settings,
                           selectedTabBar: $selectedTabBar,
                           isSystemImage: true,
                           isFirst: false,
                           xOffSet: $xOffSet)
            }
            .padding(.horizontal, 25).padding(.vertical)
            .background(mainColors.clipShape(CustomShape(xOffSet: xOffSet)).cornerRadius(10))
            .padding(.horizontal)
        }
        .background((colorScheme == .light || selectedTabBar == .identificationFungi) ? colorBackground : .clear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
