//
//  FavoritosView.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 21/08/23.
//

import SwiftUI

struct FavoritosView: View {
    
    @StateObject var persistence : PersistenceController = PersistenceController()
    
    var body: some View {
        VStack{
            
            NavigationStack {
                List(){
                    ForEach(persistence.savedQuotes){ banco in
                        NavigationLink{
                            FavoritosDetailedView(autor: banco.autor ?? "Desconhecido", frase: banco.frase ?? "Deconhecido")
                        }label: {
                            VStack{
                                HStack {
                                    Text("\(banco.autor ?? "Desconhecido")")
                                        .font(.headline)
                              
                                    Spacer()
                                }
                                Text("\(banco.frase ?? "Desconhecida")")
                            }
                        }
                    }
                    .onDelete{ offsets in
                        persistence.removeBanco(at: offsets)
                    }

                }
            }
        }
        .task {
            persistence.fetchQuotes()
        }
        .navigationTitle("Favoritos")
    }
}

struct FavoritosComponent_Previews: PreviewProvider {
    static var previews: some View {
        FavoritosView()
    }
}
