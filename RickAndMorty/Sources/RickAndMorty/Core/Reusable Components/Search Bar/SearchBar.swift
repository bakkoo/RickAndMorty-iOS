//
//  SearchBar.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
            Spacer()
            if !text.isEmpty {
                withAnimation {
                    Button("Cancel") {
                        text = ""
                        UIApplication
                            .shared
                            .sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil)
                    }
                }
            }
        }
    }
}
