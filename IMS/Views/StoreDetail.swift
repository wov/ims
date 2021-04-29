//
//  StoreDetail.swift
//  IMS
//
//  Created by wov on 2021/4/24.
//

import SwiftUI


struct StoreDetail: View {
    var currentStore: Store
    var body: some View{
            return GoodList(currentStore: currentStore)
    }
}
