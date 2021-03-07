//
//  ContentView.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .list
    
    enum Tab{
        case list
        case new
    }
    
    
    var body: some View {
        
        TabView(selection: $selection){
            GoodList()
                .tabItem {
                    Label("我的商品",systemImage:"list.dash")
                }
                .tag(Tab.list)
            
            AddGood()
                .tabItem {
                    Label("新增商品",systemImage:"plus.square.fill")
                }
                .tag(Tab.new)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
