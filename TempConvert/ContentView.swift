//
//  ContentView.swift
//  TempConvert
//
//  Created by Aleksey Nosik on 26.09.2022.
//

import SwiftUI


struct ContentView: View {
    
    @State private var myValue = 10.0
    @State private var fromUnit = "Celsium"
    @State private var toUnit = "Fahrenheit"
    @FocusState private var amountFocus: Bool
    
    let arrayTypes = ["Celsium", "Fahrenheit", "Kelvin"]
    
    var result: Double {
        switch (fromUnit, toUnit) {
        case ("Celsium", "Fahrenheit"): return (myValue * 1.8) + 32
        case ("Celsium", "Kelvin"):     return myValue + 273.15
        case ("Fahrenheit", "Celsium"): return (myValue - 32) / 1.8
        case ("Fahrenheit", "Kelvin"):  return (myValue - 32) / 1.8 + 273.15
        case ("Kelvin", "Celsium"):     return myValue - 273.15
        case ("Kelvin", "Fahrenheit"):  return (myValue - 273.15) * 1.8 + 32
        default: return myValue
        }
    }
    

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value", value: $myValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountFocus)
                
                    Picker("From", selection: $fromUnit) {
                        ForEach(arrayTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                        .bold()
                        .padding(.top, -5)
                        .foregroundColor(.red)
                }
                
                Section {
                    Picker("To", selection: $toUnit) {
                        ForEach(arrayTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                
                    Text(result, format: .number)
                    
                } header: {
                    Text("To")
                        .bold()
                        .foregroundColor(.green)
                }
            }
            .navigationTitle("TempConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
