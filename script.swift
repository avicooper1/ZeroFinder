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
    	if char == "("{
    		counter += 1
    	}
    	else if char == ")"{
    		counter -= 1
    		if counter == 0{
                nomialsAsDoubles.append(functionAsString(inputFunction: currentNomial + ")", xValue: xValue))
                currentNomial = ""
                continue
            }
    	}
    	if counter == 0{
    		switch char {
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
	    else{
	    	print(char)
	    	currentNomial += String(char)
	    }
    }

    if let lastNomial = Double(currentNomial){
    	nomialsAsDoubles.append(lastNomial)
    }

    let allOperators = [["^"],["*", "/"], ["sin", "cos", "tan"], ["+", "-"]]

    for operatorSet in allOperators{
        var currentIndex = 0
        while currentIndex <= operators.count - 1{
            if operatorSet.contains(operators[currentIndex]){
                switch operators[currentIndex] {
                case "^":
                    nomialsAsDoubles[currentIndex] = pow(nomialsAsDoubles[currentIndex], nomialsAsDoubles[currentIndex + 1])
                    nomialsAsDoubles.remove(at: currentIndex + 1)
                case "*":
                    nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] * nomialsAsDoubles[currentIndex + 1]
                    nomialsAsDoubles.remove(at: currentIndex + 1)
                case "/":
                    nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] / nomialsAsDoubles[currentIndex + 1]
                    nomialsAsDoubles.remove(at: currentIndex + 1)
                case "+":
                    nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] + nomialsAsDoubles[currentIndex + 1]
                    nomialsAsDoubles.remove(at: currentIndex + 1)
                case "-":
                    nomialsAsDoubles[currentIndex] = nomialsAsDoubles[currentIndex] - nomialsAsDoubles[currentIndex + 1]
                    nomialsAsDoubles.remove(at: currentIndex + 1)
                case "sin":
					nomialsAsDoubles[currentIndex] = sin(nomialsAsDoubles[currentIndex])
				case "cos":
					nomialsAsDoubles[currentIndex] = cos(nomialsAsDoubles[currentIndex])
				case "tan":
					nomialsAsDoubles[currentIndex] = tan(nomialsAsDoubles[currentIndex])
                default:
                    print("Error ocurred. Unknown operand located. Unexpected answer will result.")
                    continue
                }
                operators.remove(at: currentIndex)
            }
            else{
                currentIndex += 1
            }
        }
    }
    return nomialsAsDoubles[0]
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

func zeroBinarySearch(beginInterval: Double, endInterval: Double, testFunction: String, tolerance: Double, iteration: Int) -> (Double, Bool, Int){
    
    let beginIntervalState = assignNumState(input: functionAsString(inputFunction: testFunction, xValue: beginInterval))
    let endIntervalState = assignNumState(input: functionAsString(inputFunction: testFunction, xValue: endInterval))
    
    
    if beginIntervalState == .none || endIntervalState == .none{
        return (0, false, iteration + 1)
    }
    
    if beginIntervalState == .zero{
        return (beginInterval, true, iteration + 1)
    }
    else if endIntervalState == .zero{
        return (endInterval, true, iteration + 1)
    }
    
    if beginIntervalState == endIntervalState{
        return (0, false, iteration + 1)
    }
    
    let mid = (beginInterval + endInterval) / 2
    if abs(functionAsString(inputFunction: testFunction, xValue: mid)) < tolerance{
        return (mid, true, iteration + 1)
    }
    
    let midIntervalState = assignNumState(input: functionAsString(inputFunction: testFunction, xValue: mid))
    if midIntervalState != beginIntervalState{
        return zeroBinarySearch(beginInterval: beginInterval, endInterval: mid, testFunction: testFunction, tolerance: tolerance, iteration: iteration + 1)
    }
    else if midIntervalState != endIntervalState{
        return zeroBinarySearch(beginInterval: mid, endInterval: endInterval, testFunction: testFunction, tolerance: tolerance, iteration: iteration + 1)
    }
    
    
    return (0, false, iteration + 1)
}

func zeroNewtonianSearch(beginInterval: Double, testFunction: String, tolerance: Double, iteration: Int) -> (Double, Bool, Int){
    let functionValue = functionAsString(inputFunction: testFunction, xValue: beginInterval)
    let derivativeValue = derivativeOf(testFunction: testFunction, xValue: beginInterval, tolerance: tolerance)
    let newX = beginInterval - (functionValue / derivativeValue)
    if abs(functionAsString(inputFunction: testFunction, xValue: newX)) < tolerance{
        return(newX, true, iteration + 1)
    }
    else if newX.isNaN{
    	print("Current newX resolved in NaN")
        return (0, false, iteration + 1)
    }
    
    return zeroNewtonianSearch(beginInterval: newX, testFunction: testFunction, tolerance: tolerance, iteration: iteration + 1)
}

for x in 2...100{
	let currentComputable = "x^\(x)-1"
	print(currentComputable)
	print("zeroBinarySearch: ", terminator:"")
	print(zeroBinarySearch(beginInterval: -10, endInterval: 0, testFunction: currentComputable, tolerance: 0.000000001, iteration: 0))
	print("zeroNewtonianSearch: ", terminator: "")
	print(zeroNewtonianSearch(beginInterval: -10, testFunction: currentComputable, tolerance: 0.00000000001, iteration: 0))
	print()
}