//
//  BuyCard.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 22/09/20.
//String(format: "Value: %.1f", value)

import SwiftUI

struct BuyCard: View {
    var product: Product
    var body: some View {
        VStack (alignment: .leading) {
            Text(product.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(String(format: "$ %.2f", product.price))
                .font(.largeTitle)
                .foregroundColor(Color(hue: 0.344, saturation: 1.0, brightness: 0.662))
            Text("\(product.ammount) units left!")
                .font(.headline)
                .fontWeight(.light)
        }.padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct BuyCard_Previews: PreviewProvider {
    static var previews: some View {
        let data = DataManagerViewModel()
        return BuyCard(product: data.productList[0])
    }
}
