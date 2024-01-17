//
//  ContentView.swift
//  Calculator
//
//  Created by Bhavitha Priyadarsini Velaga on 1/16/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var displayText = "0"
    @State private var currentInput = ""
    @State private var storedValue:Double? = 0
    @State private var currentOperator:String?
    var body: some View {
        VStack {
           
            Text(displayText)
                .font(.system(size: 80))
            
            CalculatorButtonRow(buttons: ["7", "8", "9", "/"], action: buttonTap)
            CalculatorButtonRow(buttons: ["4", "5", "6", "*"], action: buttonTap)
            CalculatorButtonRow(buttons: ["1", "2", "3", "-"], action: buttonTap)
            CalculatorButtonRow(buttons: ["0", ".", "=", "+"], action: buttonTap)
            CalculatorButtonRow(buttons: ["Clear"], action: {button in clearButton()})
        }
        
        .padding()
    }
    func buttonTap(_ button:String) {
        switch button {
        case "+", "-", "*", "/":
            currentOperator = button
            storedValue = Double(currentInput)
            currentInput = ""
        case "=":
            if let operatorType = currentOperator,
               let storedValue = storedValue,
               let currentValue = Double(currentInput) {
                
                let result:Double
                
                switch operatorType {
                case "+":
                    result = storedValue + currentValue
                case "-":
                    result = storedValue - currentValue
                case "*":
                    result = storedValue * currentValue
                case "/":
                    result = storedValue / currentValue
                default:
                    fatalError("Unknown Operator")
                }
                currentInput = "\(result)"
                currentOperator = nil
            }
            
        case ".":
            currentInput += button
        default:
            currentInput += button
            
        }
        
        if currentInput.isEmpty
        {
            displayText = "0"
        }else{
            displayText = currentInput
        }
    }
    func clearButton() {
        currentInput = ""
        storedValue = nil
        currentOperator = nil
        displayText = "0"
    }
}


struct CalculatorButtonRow: View {
    
    let buttons:[String]
    let action:(String) -> Void
    let buttonSize = (UIScreen.main.bounds.width - 5 * 12) / 4
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                HStack(spacing: 9) {
                    ForEach(buttons, id: \.self) {buttonLabel in
                        Button {
                            action(buttonLabel)
                        } label: {
                            Text(buttonLabel)
                                .font(.title)
                                .frame(width: buttonSize, height: buttonSize)
                                .background(.orange)
                                .foregroundStyle(.black)
                                .cornerRadius(buttonSize)
                        }
                    }
                }
        }
            
    }
        
}

#Preview {
    ContentView()
}
