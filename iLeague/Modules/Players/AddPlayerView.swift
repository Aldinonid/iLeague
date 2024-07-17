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
    @State var isEdit: Bool = false
    @State var player: Player? = nil
    @State private var showAlert: Bool = false
    @FocusState private var focusField: Field?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Player name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .submitLabel(.next)
                    .focused($focusField, equals: .name)
                    .onSubmit { focusField = .level }
                
                TextField("Level", text: $level)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .submitLabel(.done)
                    .focused($focusField, equals: .level)
                    .onSubmit { savePlayer() }
                
                Spacer()
            }
            .navigationTitle(isEdit ? "Edit Player" : "Add Player")
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
                        isEdit ? updatePlayer() : savePlayer()
                    } label: {
                        Text("Done")
                    }
                    .disabled(name.isEmpty || level.isEmpty)
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("There was an error!"))
            })
            .onAppear {
                guard let player = self.player else { return }
                if isEdit {
                    setupExistPlayer(player)
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
    
    func setupExistPlayer(_ player: Player) {
        self.name = player.name
        self.level = player.level
    }
    
    func updatePlayer() {
        player?.name = self.name
        player?.level = self.level
        do {
            try modelContext.save()
        } catch {
            showAlert = true
            print(error.localizedDescription)
        }
        dismiss()
    }
    
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
