//: Playground - noun: a place where people can play
//Current tolerance is 1 x 10^-14

import Foundation

enum NumState{
    case positive, negative, zero, none
}

func functionAsString (inputFunction: String, xValue: Double) -> Double{
    
    var input = inputFunction
    input = String(input.characters.dropFirst())
    input = String(input.characters.dropLast())
    
    var nomialsAsDoubles: [Double] = []
    var operators: [String] = []
    
    var counter = 0
    var currentNomial = ""
    var operatorsCounter = 0
    
    for char in input.characters{
        switch char {
        case "(":
            counter += 1
        case ")":
            counter -= 1
            if counter == 0{
                nomialsAsDoubles.append(functionAsString(inputFunction: currentNomial + ")", xValue: xValue))
            }
        case "x":
            if currentNomial.characters.count > 0{
                nomialsAsDoubles.append(Double(currentNomial)!)
                currentNomial = ""
                operators.append("*")
            }
            nomialsAsDoubles.append(xValue)
        case "s":
            operators.append("sin")
            operatorsCounter += 1
        case "c":
            operators.append("cos")
            operatorsCounter += 1
        case "t":
            operators.append("tan")
            operatorsCounter += 1
        default:
            if Double(String(char)) == nil{
                operators.append(String(char))
                if currentNomial.characters.count > 0{
                    nomialsAsDoubles.append(Double(currentNomial)!)
                }
                currentNomial = ""
            }
            else{
                currentNomial += String(char)
            }
        }
    }
    
    print(input)
    print(nomialsAsDoubles)
    print(operators)
    print()
    
    for singleOperator in ["^","*", "/", "+", "-"]{
        var currentIndex = 0
        if operators.contains(singleOperator){
            while currentIndex <= operators.count - 1{
                if operators[currentIndex] == singleOperator{
                    switch singleOperator {
                    case "^":
                        nomialsAsDoubles[currentIndex] = pow(nomialsAsDoubles[currentIndex], nomialsAsDoubles[currentIndex + 1])
                    case "*":
                        nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] * nomialsAsDoubles[currentIndex + 1]
                    case "/":
                        nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] / nomialsAsDoubles[currentIndex + 1]
                    case "+":
                        nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] + nomialsAsDoubles[currentIndex + 1]
                    case "-":
                        nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] - nomialsAsDoubles[currentIndex + 1]
                    default:
                        print("Error ocurred. Unknown operand located. Unexpected answer will result.")
                        continue
                    }
                    nomialsAsDoubles.remove(at: currentIndex + 1)
                    operators.remove(at: currentIndex)
                }
                else{
                    currentIndex += 1
                }
            }
        }
    }
    //return Double(nomials[0])!
    print(nomialsAsDoubles)
    print(operators)
    print("Function finished")
    return 0.0
}

func derivativeOf(testFunction: String, xValue: Double, tolerance: Double) -> Double {
    return (functionAsString(inputFunction: testFunction, xValue: xValue + tolerance) - functionAsString(inputFunction: testFunction, xValue: xValue)) / tolerance
}

func assignNumState (input: Double) -> NumState{
    if input == 0{
        return NumState.zero
    }
    else if input > 0{
        return NumState.positive
    }
    else if input < 0{
        return NumState.negative
    }
    else{
        return NumState.none
    }
}

func zeroBinarySearch(beginInterval: Double, endInterval: Double, testFunction: String, tolerance: Double) -> (Double, Bool){
    
    let beginIntervalState = assignNumState(input: functionAsString(inputFunction: testFunction, xValue: beginInterval))
    let endIntervalState = assignNumState(input: functionAsString(inputFunction: testFunction, xValue: endInterval))
    
    
    if beginIntervalState == .none || endIntervalState == .none{
        return (0, false)
    }
    
    if beginIntervalState == .zero{
        return (beginInterval, true)
    }
    else if endIntervalState == .zero{
        return (endInterval, true)
    }
    
    if beginIntervalState == endIntervalState{
        return (0, false)
    }
    
    let mid = (beginInterval + endInterval) / 2
    if abs(functionAsString(inputFunction: testFunction, xValue: mid)) < tolerance{
        return (mid, true)
    }
    
    let midIntervalState = assignNumState(input: functionAsString(inputFunction: testFunction, xValue: mid))
    if midIntervalState != beginIntervalState{
        return zeroBinarySearch(beginInterval: beginInterval, endInterval: mid, testFunction: testFunction, tolerance: tolerance)
    }
    else if midIntervalState != endIntervalState{
        return zeroBinarySearch(beginInterval: mid, endInterval: endInterval, testFunction: testFunction, tolerance: tolerance)
    }
    
    
    return (0, false)
}

func zeroNewtonianSearch(beginInterval: Double, testFunction: String, tolerance: Double) -> (Double, Bool){
    let functionValue = functionAsString(inputFunction: testFunction, xValue: beginInterval)
    let derivativeValue = derivativeOf(testFunction: testFunction, xValue: beginInterval, tolerance: tolerance)
    let newX = beginInterval - (functionValue / derivativeValue)
    print(newX)
    if abs(functionAsString(inputFunction: testFunction, xValue: newX)) < tolerance{
        return(newX, true)
    }
    else if newX.isNaN{
        return (0, false)
    }
    
    return zeroNewtonianSearch(beginInterval: newX, testFunction: testFunction, tolerance: tolerance)
}

print(functionAsString(inputFunction: "((1/2*x+3)^4)", xValue: 2))
print(functionAsString(inputFunction: "(x^3-3x-5*x)", xValue: 2))
print(functionAsString(inputFunction: "(x)", xValue: 2))
print(functionAsString(inputFunction: "(sx)", xValue: 2))

//print(zeroBinarySearch(beginInterval: 2, endInterval: 3, testFunction: "(x^3-3x-5)", tolerance: 0.000000000001))
//
//print()
//print()
//print()
//
//let a = derivativeOf(testFunction: "(x^2+2)", xValue: 2, tolerance: 0.000001)
//print(a)
//print(zeroNewtonianSearch(beginInterval: 2, testFunction: "(x^2+2)", tolerance: 0.00000000000001))
//print(zeroNewtonianSearch(beginInterval: 2, testFunction: "(x^2)", tolerance: 0.00000000000001))

//print(zeroNewtonianSearch(beginInterval: -3, testFunction: "(x^3-3x)", tolerance: 0.0000001))
