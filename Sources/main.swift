//print("Experiment 1: Binary search x^y as y gets arbitrarily larger")
for x in 0...100{
	if x % 2 == 0{
		printFormattedResults(currentX: x, input: zeroBinarySearch(beginInterval: -10, endInterval: 0, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0))
	}
}
print()

//print("Experiment 2: Newton search x^y as y gets arbitrarily larger")
for x in 0...100{
	if x % 2 == 0{
		printFormattedResults(currentX: x, input: zeroNewtonianSearch(beginInterval: -10, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0))
	}
}
print()

//print("Experiment 6: Combined search x^y as y gets arbitrarily larger")
for x in 0...100{
	if x % 2 == 0{
		printFormattedResults(currentX: x, input: combinedAlgorithms(beginInterval: -10, endInterval: 0, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0))
	}
}
print()

// print("Experiment 3: Binary search as begin interval get arbitrarily smaller than the root")
// for x in 0...100{
// 	printFormattedResults(currentX: -10 - x, input: zeroBinarySearch(beginInterval: (-10-Double(x)), endInterval: 0, testFunction: "(x^10-1)", tolerance: 0.000000001, iteration: 0))
// }
// print()

// print("Experiment 4: Newton search as begin interval get arbitrarily smaller than the root")
// for x in 0...100{
// 	printFormattedResults(currentX: -10 - x, input: zeroNewtonianSearch(beginInterval: (-10-Double(x)), testFunction: "(x^10-1)", tolerance: 0.000000001, iteration: 0))
// }
// print()

// print("Experiment 5: Binary search x^y as y gets arbitrarily larger and as begin interval get arbitrarily smaller than the root")
// for x in 0...100{
// 	if x % 2 == 0{
// 		for y in 0...100{
// 			printFormattedResults(currentX: x, input: zeroBinarySearch(beginInterval: (-10-Double(x)), endInterval: 0, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0))
// 		}
// 	}
// }
// print()

// print("Experiment 1: Newton search x^y as y gets arbitrarily larger and as begin interval get arbitrarily smaller than the root")
// for x in 0...100{
// 	if x % 2 == 0{
// 		for y in 0...100{
// 			printFormattedResults(currentX: x, input: zeroNewtonianSearch(beginInterval: (-10-Double(x)), testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0))
// 		}
// 	}
// }
// print()