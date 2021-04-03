//
//  EmptyList.swift
//  IMS
//
//  Created by wov on 2021/4/3.
//

import Foundation
import SwiftUI

struct EmptyList: View {

    var body: some View {
        VStack {
            Text("商品列表为空")
            Text("点击右上角「添加商品」")
            Text("添加新的商品")
        }.font(.subheadline)
        .foregroundColor(.secondary)
    }
}




struct EmptyList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyList()
            .environmentObject(ModelData())
    }
}


