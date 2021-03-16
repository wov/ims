//
//  GoodRow.swift
//  IMS
//
//  Created by wov on 2021/2/12.
//
import SwiftUI

struct GoodRow:View {
    var good:Good
    
    let url = URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!
    
    var body: some View{
        HStack {
//            AsyncImage(url: URL(string: good.src)!,
//                       placeholder: { Text("Loading ...") },
//                       image: { Image(uiImage: $0).resizable() })
//                .frame(width: 60, height: 60)
            
            VStack{
                HStack {
                    Text(good.name)
                        .font(.title2)
                        .foregroundColor(.primary)
                    Spacer()
                }
                HStack {
                    Text("库存：\(String(format: "%.2f", good.stock!))\(good.unit)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            
            Spacer()
            
            if good.ots{
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
            }
        }
        
        
        
        
        
    }
}

struct GoodRow_Previews : PreviewProvider{
    static var goods = ModelData().goods
    
    static var previews: some View{
        Group {
            GoodRow(good: goods[0])
            GoodRow(good: goods[1])
        }.previewLayout(.fixed(width: 300, height: 70))
    }
}
