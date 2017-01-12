import Foundation
import Progress

//let inputFunction = "(" + "(((3.4*0.08206*x)^((4500000)/(3.4*0.08206*x))+(3.4*0.08206*x)^((3.4*0.08206*x)/(4500000)))/2)+(0-3.4*0.08206*x)" + ")"
let inputFunction = "(" + "(((3*0.08206*x)^((0.05*10)/(3*0.08206*x))+(3*0.08206*x)^((3*0.08206*x)/(0.05*10)))/2)+(0-3*0.08206*x)" + ")"
let f = "(3x0-3)"
print("hello")

//print(functionAsString(inputFunction: inputFunction, xValue: 2.043))
//print("From Left")
//print(zeroNewtonianSearch(beginInterval: 24372, testFunction: inputFunction, tolerance: 0.0000001, iteration: 0))
//print("From Right")
//print(zeroNewtonianSearch(beginInterval: 24373, testFunction: inputFunction, tolerance: 0.000000001, iteration: 0))
var currentSmallest = (value: 0.0, distance: 1000.0)
for x in Progress(1...1000000){
    let currentValue = 2 + (Double(x)/10000000.0)
    let a = abs(functionAsString(inputFunction: inputFunction, xValue: currentValue))
    if a < currentSmallest.distance{
        currentSmallest = (currentValue, a)
    }
}
print(currentSmallest)
