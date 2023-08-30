import UIKit
import JavaScriptCore
import WWJavaScriptContext

// MARK: - WWJavaScriptContext.CSV
extension WWJavaScriptContext {
    
    open class CSV: NSObject {
        
        public static let shared = CSV(path: "PapaParse-5.4.1.js")
        
        var context: WWJavaScriptContext?
        
        private override init() {}
        
        convenience init(path: String) {
            self.init()
            self.context = self.build()
        }
    }
}

// MARK: - 公開函數
public extension WWJavaScriptContext.CSV {
    
    /// [轉換Markdown => Array](https://www.papaparse.com/)
    /// - Parameters:
    ///   - context: WWJavaScriptContext
    ///   - source: String
    /// - Returns: [AnyHashable: Any]?
    func convertArray(source: String) -> [Any]? {
        
        guard let jsValue = convertJSValue(source: source),
              let array = jsValue.toArray()
        else {
            return nil
        }
        
        return array
    }
    
    /// [轉換Markdown => JSValue](https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.4.1/papaparse.min.js)
    /// - Parameters:
    ///   - context: WWJavaScriptContext
    ///   - source: String
    /// - Returns: JSValue?
    func convertJSValue(source: String) -> JSValue? {
        
        guard let context = context,
              let script = readScript(with: "jsSource.js")
        else {
            return nil
        }
        
        _ = context.evaluateScript(script)
        return context.callFunctionName("convertCSV", arguments: [source])
    }
}

// MARK: - 小工具
private extension WWJavaScriptContext.CSV {
    
    /// 建立初始物件
    /// - Returns: WWJavaScriptContext?
    func build() -> WWJavaScriptContext? {
        
        guard let script = readScript(with: "PapaParse-5.4.1.js") else { return nil }
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
