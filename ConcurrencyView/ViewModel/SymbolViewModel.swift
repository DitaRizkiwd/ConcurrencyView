//
//  SymbolViewModel.swift
//  ConcurrencyView
//
//  Created by MACBOOK PRO on 22/04/24.
//

import Foundation

class SymbolViewModel : ObservableObject{
    @Published var symbols : [Symbol] = Symbol.dummyData
    
    
    //Mark: - SYNCHRONOUS

    func downloadImageandBlockUI(){
        let urlString = "https://res.cloudinary.com/diflradsh/image/upload/v1713407536/Screenshot_2024-04-18_at_09.30.35_wkijfu.png?uuid=\(UUID().uuidString)"
        
        guard let url = URL(string: urlString) else {return}
        //DispatchQueue.global().sync akan menjalankan aktivitas secara serial sehingga ketika aktivitas background berjalan main thread akan terblok ( freeze)
        //DispatchQueue.main() paralel background dan foreground
        DispatchQueue.global().sync {
            Thread.sleep(forTimeInterval: 2)
            let output = try? Data(contentsOf: url)
            print(output!)
            print(url)
        }
    }
    
    //Mark: - ASYNCHRONOUS

    func downloadImageWithoutBlockUI() async {
        let urlString = "https://res.cloudinary.com/diflradsh/image/upload/v1713407536/Screenshot_2024-04-18_at_09.30.35_wkijfu.png?uuid=\(UUID().uuidString)"
        
        guard let url = URL(string: urlString) else {return}
        
        do{
            let(data,_) = try await URLSession.shared.data(from: url)
            
            print(data)
            print(url)
        }
        catch{
            print("Error downloading image: \(error)")
        }
    }
}
