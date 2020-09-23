//
//  OutOfStockView.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 23/09/20.
//

import SwiftUI

struct OutOfStockView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Text("Oops!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding()
                Text("We sold everything!")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)
                Text("Please, wait while we restock.")
                    .padding(.bottom)
            }
            Spacer()
        }
    }
}

struct OutOfStockView_Previews: PreviewProvider {
    static var previews: some View {
        OutOfStockView()
    }
}
