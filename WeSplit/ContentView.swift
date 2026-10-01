//
//  ContentView.swift
//  WeSplit
//
//  Created by Mohammed Alhashim on 20/09/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: Double = 0
    @State private var numberOfPeople: Int = 2
    @State private var tipPrecintage: Int = 20
    @FocusState private var focusedTextField: Bool
    
    var totalPlusTip: Double {
        let startingPrice = Double(amount)
        let tip = startingPrice * Double(tipPrecintage) / 100
        let total = startingPrice + tip

        return total
    }
    
    var totalPerPerson: Double {
        totalPlusTip / Double(numberOfPeople)
    }
    
    
    var body: some View {
        
        
        NavigationStack {
            Form{
                
                Section{
                    TextField("Enter the amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($focusedTextField)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1...100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip", selection: $tipPrecintage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person"){
                    
                    SARText(amount: totalPerPerson)
                }
                
                Section("Total + Tip"){
                    SARText(amount: totalPlusTip)
                    
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if focusedTextField {
                    Button("Done") {
                        focusedTextField = false
                    }
                }
            }
        }
    }
}

struct SARText: View {
    let amount: Double

    var body: some View {
        Text("\u{20C1} \(amount, specifier: "%.2f")")
    }
}

#Preview {
    ContentView()
}
