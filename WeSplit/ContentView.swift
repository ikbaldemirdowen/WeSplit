//
//  ContentView.swift
//  WeSplit
//
//  Created by Ikbal Demirdoven on 2022-07-10.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused : Bool
    @State private var currency = Locale.current.currencyCode
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var total : Double
    {
        let bill = Double(billAmount)
        let tip = Double(tipPercentage)
        return bill + (bill / 100 * tip)
    }
    
    var totalPerPerson : Double
    {
        let peopleCount = Double(numberOfPeople + 2)
        let tipCount = Double(tipPercentage)
        let tipAmount = billAmount / 100 * tipCount
        let perPerson = (billAmount + tipAmount) / peopleCount
        return perPerson
    }
    var body: some View {
        NavigationView
        {
            Form
            {
                Section
                {
                    TextField("Amount", value: $billAmount, format : .currency(code: currency ?? "CAD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }   header:
                {
                    Text("bill amount")
                }
                Section
                {
                    Picker("Tip percentage", selection: $tipPercentage)
                    {
                        ForEach(1..<100, id: \.self)
                        {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header:
                {
                    Text("tip percentage")
                }
                Section
                {
                    Picker("Number of people", selection: $numberOfPeople)
                    {
                        ForEach(2..<10)
                        {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("Number of people")
                }
                Section
                {
                    Text(total, format: .currency(code: currency ?? "CAD"))
                } header: {
                    Text("Total")
                }
                Section
                {
                    Text(totalPerPerson, format: .currency(code: currency ?? "CAD"))
                } header: {
                    Text("Per person")
                }
                .navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar
            {
                ToolbarItemGroup(placement: .keyboard)
                {
                    Spacer()
                    Button("Done")
                    {
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
