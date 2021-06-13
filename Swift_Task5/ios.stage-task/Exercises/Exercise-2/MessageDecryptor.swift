import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        // Инизицализируем layer когда встречаем [
        
        struct layer {
            var multiplier = 1
            var numbers = [String]()
            var start: Int?
            var end: Int?
            var tmpString = ""
            var resultString = ""
        }
        var stack = [layer]()
        var tmpNumbersArray = [String]()
        var stringLine = ""
        
        
        for (index, char) in message.enumerated() { // 3[secret]2[message]
            
            if let number = Int(String(char)) {
                tmpNumbersArray.append(String(number))
                continue
            }
            
            if char == "[" {
                let newLayer = layer(multiplier: Int(tmpNumbersArray.joined()) ?? 1, numbers: tmpNumbersArray, start: index)
                stack.append(newLayer)
                tmpNumbersArray.removeAll()
            }
            
            if char != "[" && char != "]" {
                if stack.isEmpty {
                    let newLayer = layer(multiplier: Int(tmpNumbersArray.joined()) ?? 1, numbers: tmpNumbersArray, start: index, tmpString: String(char))
                    stack.append(newLayer)
                    tmpNumbersArray.removeAll()
                    continue
                }
                if var currentLayer = stack.popLast() {
                    currentLayer.tmpString += String(char)
                    stack.append(currentLayer)
                }
                continue
            }
            
            if char == "]" && index < message.count - 1 {
                var resultString = ""
                if var currentLayer = stack.popLast() {
                    currentLayer.resultString = String(repeating: currentLayer.tmpString, count: currentLayer.multiplier)
                    resultString = currentLayer.resultString
                    // stack.append(currentLayer)
                }
                if var deepLayer = stack.popLast() {
                    deepLayer.tmpString += resultString
                    stack.append(deepLayer)
                } else {
                    stringLine += resultString
                }
            }
            
        }
        
        if !stringLine.isEmpty {
            if var currentLayer = stack.popLast() {
                currentLayer.tmpString = String(repeating: currentLayer.tmpString, count: currentLayer.multiplier)
                stringLine += currentLayer.tmpString
            }
            return stringLine
        }
        
        var ans = ""
        if var currentLayer = stack.popLast() {
            currentLayer.tmpString = String(repeating: currentLayer.tmpString, count: currentLayer.multiplier)
            ans = currentLayer.tmpString
        }
        return ans
        
//        var stringsStack = [String]()
//        var multipliersStack = [Int]()
//        var layersStack = [layer]()
//        var result = ""
//
//        struct layer {
//            let start: Int?
//            let end: Int?
//        }
//
//        for (index, char) in message.enumerated() {
//
//            if let multiplier = Int(String(char)) {
//                multipliersStack.append(multiplier)
//                continue
//            }
//
//            if char == "[" {
//                var newLayer = layer(start: index, end: nil)
//                layersStack.append(newLayer)
//            }
//
//            if char == "]" { // Встречаем ]
//                if let currentLayer = layersStack.popLast() { // ВЫтаскиваем лейер из стека
//                    if let start = currentLayer.start { // Получаем индекс [ у лейера
//                        let subString = String(message.dropFirst(start + 1).prefix(index - start - 1))
//                        // Получаем подстроку между []
//
//                        if let mult = multipliersStack.popLast() { // достаем множитель из стека
//                            let str = String(repeating: subString, count: mult) // готовим строку умноженную на число
//                        }
//                    }
//                }
//
//            }
//
//            if char != "[" && char != "]" {
////                stringsStack.append(String(char))
//                continue
//            }
//
//            if char == "]" {
////                var msg = stringsStack.popLast()
//
//            }
//
//        }
//
        return ""
    }
}
