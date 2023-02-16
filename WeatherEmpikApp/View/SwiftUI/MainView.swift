//
//  ContentView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 09/02/2023.
//

import SwiftUI

struct MainView: View, KeyboardReadable {
    
    @StateObject private var viewModel = MainViewModel()
    @State var currentIndex = 0
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    VStack(spacing: 1) {
                        HStack {
                            ImageBundle.glass()
                                .padding()
                            ClearableTextField("Search for a city", text: $viewModel.searchText)
                                .onReceive(keyboardPublisher) { value in
                                    viewModel.isKeyBoardOpen = value
                                }
                        }
                        ErrorView(error: $viewModel.error)
                        
                    }
                    
                    Button {
                        viewModel.requestLocation()
                    } label: {
                        ImageBundle.sendButton()
                            .frame(width: 20, height: 20)
                            .padding()
                            .roundCorners()
                    }
                    .myButtonStyle()
                    .padding()
                }
                
                
                LazyVStack(alignment: .leading, spacing: 3) {
                    ForEach(viewModel.searchResults, id: \.self) { item in
                        NavigationLink(destination: CityViewUIKit(city: item)) {
                            ListItemView(item: item)
                        }
                        .listRowBackground(Color.gray)
                    }
                }
                Spacer()
                
                if viewModel.showCarousel {
                    VStack(alignment: .center, spacing: 2) {
                        CarouselView(tabs: $viewModel.tabs, current: $currentIndex)
                        
                        HStack(spacing: 4) {
                            ForEach(viewModel.tabs.indices, id: \.self) { index in
                                Capsule()
                                    .fill(Color.white.opacity(currentIndex == index ? 1 : 0.5))
                                    .frame(width: currentIndex == index ? 18 : 4, height: 4)
                                    .animation(.easeInOut, value: currentIndex)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationViewStyle(.stack)
            .navigationTitle("Weather App")
            .background(
                LinearGradient(colors: [Colors.lightBlue, Colors.violet], startPoint: .top, endPoint: .bottom)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
