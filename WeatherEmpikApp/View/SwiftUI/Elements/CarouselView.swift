//
//  CarouselView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 13/02/2023.
//

import SwiftUI

struct CarouselView: View {
    @Binding var tabs: [Tab]
    @State var newTabs: [Tab] = []
    @Binding var current: Int
    @State var fakeIndex: Int = 1
    @State var offset: CGFloat = 0
    
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    private func getIndex(tab: Tab) -> Int {
        newTabs.firstIndex { currentTab in
            return currentTab.id == tab.id
        } ?? 0
    }
    
    var body: some View {
        TabView(selection: $fakeIndex) {
            
            ForEach(newTabs) { tab in
                CardView(model: tab.item)
                    .overlay(
                        GeometryReader { proxy in
                            Color.clear
                                .preference(key: OffsetKey.self, value: proxy.frame(in: .global).minX)
                                .onPreferenceChange(OffsetKey.self, perform: { offset in
                                    self.offset = (offset.remainder(dividingBy: proxy.size.width))
                                })
                        }
                    )
                    .tag(getIndex(tab: tab))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: offset) { newValue in
            
            if fakeIndex == 0 && offset == 0 {
                fakeIndex = newTabs.count - 2
            }
            
            if fakeIndex == newTabs.count - 1 && offset == 0 {
                fakeIndex = 1
            }
        }
        .onAppear {
            newTabs = tabs
            
            guard
                var first = newTabs.first
            else { return }
            
            guard var last = newTabs.last else { return }
            
            first.id = UUID().uuidString
            last.id = UUID().uuidString
            
            newTabs.append(first)
            newTabs.insert(last, at: 0)
            
            fakeIndex = 1
        }
        .onChange(of: tabs, perform: { newValue in
            newTabs = tabs
            
            guard
                var first = newTabs.first
            else { return }
            
            guard var last = newTabs.last else { return }
            
            first.id = UUID().uuidString
            last.id = UUID().uuidString
            
            newTabs.append(first)
            newTabs.insert(last, at: 0)
            
        })
        .onChange(of: fakeIndex) { newValue in
            current = fakeIndex - 1
        }
        .onReceive(timer) { _ in
            withAnimation {
                fakeIndex = fakeIndex < newTabs.count - 2 ? fakeIndex + 1 : 1
            }
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
