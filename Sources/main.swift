import Progress
import Foundation

//func writeToFile(toWrite: String) {
//    let path = "/Users/avicooper/Desktop/Efficiency Results.csv" //This must be set before experiment is run
//    
//    do {
//        try toWrite.write(toFile: path, atomically:true, encoding:String.Encoding.utf8)
//    } catch {
//        //Handle Error here
//    }
//    
//}

func writeToFile(toWrite: String){
    
    let file: FileHandle? = FileHandle(forUpdatingAtPath: "/Users/avicooper/Desktop/Efficiency Results.csv")
    
    if let fileNonNil = file{
        let fileData = ("\n" + toWrite).data(using: .utf8)
        fileNonNil.seekToEndOfFile()
        fileNonNil.write(fileData!)
        fileNonNil.closeFile()
    }else{
        print("file could not be opened")
    }
}

var experiment1Results: [Int] = []
var experiment2Results: [Int] = []
var experiment3Results: [Int] = []
var experiment4Results: [Int] = []
var experiment5Results: [Int] = []
var experiment6Results: [Int] = []
var experiment7Results: [Int] = []
var experiment8Results: [Int] = []
var experiment9Results: [Int] = []

//Experiment 1: Binary search x^y as y gets arbitrarily larger, where begin interval is -10
for x in Progress(2...100){
	if x % 2 == 0{
		experiment1Results.append(zeroBinarySearch(beginInterval: -10, endInterval: 0, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0).2)
	}
}

//Experiment 2: Newtonian search x^y as y gets arbitrarily larger where begin interval is -10
for x in Progress(2...100){
	if x % 2 == 0{
		experiment2Results.append(zeroNewtonianSearch(beginInterval: -10, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0).2)
	}
}

//Experiment 3: Combined search x^y as y gets arbitrarily larger where begins interval is -10
for x in Progress(2...100){
	if x % 2 == 0{
		experiment3Results.append(combinedAlgorithms(beginInterval: -10, endInterval: 0, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0).2)
	}
}

for x in 0...experiment1Results.count - 1{
    writeToFile(toWrite: String(experiment1Results[x]) + "\t" + String(experiment2Results[x]) + "\t" + String(experiment3Results[x]))
}
writeToFile(toWrite:"\n\n\n")
print()

//Experiment 4: Binary search as begin interval get arbitrarily smaller than the root where x^10
for x in Progress(2...100){
    experiment4Results.append(zeroBinarySearch(beginInterval: 0 - Double(x), endInterval: 0, testFunction: "(x^10-1)", tolerance: 0.000000001, iteration: 0).2)
}

//Experiment 5: Newtonian search as begin interval get arbitrarily smaller than the root where x^10
for x in Progress(2...100){
    experiment5Results.append(zeroNewtonianSearch(beginInterval: 0 - Double(x), testFunction: "(x^10-1)", tolerance: 0.000000001, iteration: 0).2)
}

//Experiment 6: Combined search as begin interval get arbitrarily smaller than the root where x^10
for x in Progress(2...100){
    experiment6Results.append(combinedAlgorithms(beginInterval: 0 - Double(x), endInterval: 0, testFunction: "(x^10-1)", tolerance: 0.000000001, iteration: 0).2)
}

for x in 0...experiment4Results.count - 1{
    writeToFile(toWrite: String(experiment4Results[x]) + "\t" + String(experiment5Results[x]) + "\t" + String(experiment6Results[x]))
}
writeToFile(toWrite: "\n\n\n")
print()

//Experiment 7: Binary search x^y as y gets arbitrarily larger and as begin interval get arbitrarily smaller than the root
for x in Progress(2...100){
    if x % 2 == 0{
        for y in 1...100{
 			experiment7Results.append(zeroBinarySearch(beginInterval: (-1 - Double(y)), endInterval: 0, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0).2)
        }
 	}
}

//Experiment 8: Newtonian search x^y as y gets arbitrarily larger and as begin interval get arbitrarily smaller than the root
for x in Progress(2...100){
 	if x % 2 == 0{
 		for y in 1...100{
 			experiment8Results.append(zeroNewtonianSearch(beginInterval: (-1 - Double(y)), testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0).2)
 		}
 	}
}

//Experiment 9: Combined search x^y as y gets arbitrarily larger and as begin interval get arbitrarily smaller than the root
for x in Progress(2...100){
    if x % 2 == 0{
        for y in 1...100{
            experiment9Results.append(combinedAlgorithms(beginInterval: -1 - Double(y), endInterval: 0, testFunction: "(x^\(x)-1)", tolerance: 0.000000001, iteration: 0).2)

        }
    }
}

for x in 0...experiment7Results.count - 1{
    writeToFile(toWrite: String(experiment7Results[x]) + "\t" + String(experiment8Results[x]) + "\t" + String(experiment9Results[x]))
}
writeToFile(toWrite: "\n\n\n")
