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
        case setting
    }
    
    
    var body: some View {
        
        TabView(selection: $selection){
            GoodList()
                .tabItem {
                    Label("我的商品",systemImage:"list.dash")
                }
                .tag(Tab.list)
            
            Setting()
                .tabItem {
                    Label("设置",systemImage:"gearshape.fill")
                }
                .tag(Tab.setting)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
