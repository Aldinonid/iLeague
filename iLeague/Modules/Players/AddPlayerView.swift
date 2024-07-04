//
//  AddPlayerView.swift
//  iLeague
//
//  Created by Aldino Efendi on 2024-06-03.
//

import SwiftUI
import SwiftData

struct AddPlayerView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var level = ""
    @State private var isEdit: Bool = false
    @FocusState private var focusField: Field?
    
    init(isEdit: Bool = false) {
        self.isEdit = isEdit
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Player name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .submitLabel(.next)
                    .focused($focusField, equals: .name)
                    .onSubmit {
                        focusField = .level
                    }
                
                TextField("Level", text: $level)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .submitLabel(.done)
                    .focused($focusField, equals: .level)
                    .onSubmit {
                        savePlayer()
                    }
                
                Spacer()
            }
            .toolbar {
                if !isEdit {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        savePlayer()
                    } label: {
                        Text("Done")
                    }
                    .disabled(name.isEmpty || level.isEmpty)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddPlayerView()
}


extension AddPlayerView {
    
    func savePlayer() {
        guard !name.isEmpty, !level.isEmpty else {
            print("No name or level found")
            return
        }
        let player = Player(name: name, level: level)
        modelContext.insert(player)
        dismiss()
    }
    
}
