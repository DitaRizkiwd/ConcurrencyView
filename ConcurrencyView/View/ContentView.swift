//
//  ContentView.swift
//  ConcurrencyView
//
//  Created by MACBOOK PRO on 22/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var symbolvm = SymbolViewModel()
    let columns: [GridItem] = [
        //adaptiv terhadap jumlah data, minimum adalah width terhadap isi, baiknya samakan saja dengan frame
        GridItem(.adaptive(minimum: 100), spacing: 12)
    ]
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(symbolvm.symbols){
                        item in Image(systemName: item.name)
                            .padding()
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .frame(width: 100, height: 100)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding()
            }
            .navigationTitle("Symbols")
            .toolbar{Button{
                Task{
                    await symbolvm.downloadImageWithoutBlockUI()
                }
            } label:{
                Image(systemName: "square.and.arrow.down")
            }}
            .tint(.black)
        }
    }
}

#Preview {
    ContentView()
}
