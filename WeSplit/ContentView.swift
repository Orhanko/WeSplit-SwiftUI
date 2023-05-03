//
//  ContentView.swift
//  WeSplit
//
//  Created by Orhan Pojskic on 30.04.2023..
//  Modified by Orhan Pojskic on 03.05.2023..

import SwiftUI

struct ContentView: View {
    @State var amount = 0.0
    @State var numberOfPeople = 2
    @State private var tip = 0
    @FocusState var isFocused: Bool
    
    let tipPercentages = [0, 5, 10 ,15 , 20, 25, 30]
    
    var totalCostPerPerson: Double {
        let peopleNumber = Double(numberOfPeople + 1)
        let iznosBaksisa = Double(amount / 100 * Double(tip))
        let AmountAndTip = Double(amount + iznosBaksisa)
        let TotalPerPerson = AmountAndTip / peopleNumber
        return TotalPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                
                Section{
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(1..<21){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("How much tip do you want to leave?", selection: $tip) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("How much tip do you want to leave?")
                }
                
                
                Section{
                    
                    Text(totalCostPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        
                        
                } header: {
                    Text("Total per person")
                        .padding(.top, 100)
                }
            
        }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
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
