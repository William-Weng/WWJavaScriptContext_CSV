import UIKit
import JavaScriptCore
import WWJavaScriptContext

// MARK: - WWJavaScriptContext.CSV
extension WWJavaScriptContext {
    
    open class CSV: NSObject {
        
        public static let shared = CSV(filename: "PapaParse-5.4.1.js")
        
        var context: WWJavaScriptContext?
        
        private override init() {}
        
        convenience init(filename: String) {
            self.init()
            self.context = self.build(with: filename)
        }
    }
}

// MARK: - 公開函數
public extension WWJavaScriptContext.CSV {
    
    /// [解析CSV => JSValue](https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.4.1/papaparse.min.js)
    /// - Parameters:
    ///   - csv: [String](https://www.papaparse.com/)
    /// - Returns: JSValue?
    func convert(csv: String) -> JSValue? {
        
        guard let context = context,
              let script = readScript(with: "jsSource.js")
        else {
            return nil
        }
        
        _ = context.evaluateScript(script)
        return context.callFunctionName("convertCSV", arguments: [csv])
    }
}

// MARK: - 小工具
private extension WWJavaScriptContext.CSV {
    
    /// 建立初始物件
    /// - Returns: WWJavaScriptContext?
    func build(with filename: String) -> WWJavaScriptContext? {
        
        guard let script = readScript(with: filename) else { return nil }
        return WWJavaScriptContext.build(script: script)
    }
    
    /// 讀取Script
    /// - Parameter filename: String
    /// - Returns: String?
    func readScript(with filename: String) -> String? {
        
        guard let sourcePath: String = Bundle.module.path(forResource: filename, ofType: nil),
              let script = try? String(contentsOfFile: sourcePath)
        else {
            return nil
        }
        
        return script
    }
}
