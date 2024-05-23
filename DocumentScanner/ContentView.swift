//
//  ContentView.swift
//  DocumentScanner
//
//  Created by Yuliia on 23/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isScannerPresented: Bool = false
    @State private var scannedImages: [UIImage] = []
    
    var body: some View {
        VStack {
            if !scannedImages.isEmpty {
                ScrollView {
                    LazyVStack( content: {
                        ForEach(scannedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                        }
                    })
                }
            }
            Button {
                isScannerPresented.toggle()
            } label: {
                Text("Scan text")
                    .font(.title3)
                    .padding()
            }.buttonStyle(.plain)
                .background(.regularMaterial)
                .clipShape(.capsule)
        }
        .sheet(isPresented: $isScannerPresented, content: {
            ScannerView { result in
                switch result {
                case .success(let scannedImages):
                    
                    self.scannedImages = scannedImages
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                isScannerPresented = false
            } didCancel: {
                isScannerPresented = false
            }
        })
    }
}

#Preview {
    ContentView()
}
