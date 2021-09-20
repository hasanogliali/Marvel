import Foundation
import Extensions

public enum API {
    static func getURL(with trail: String) -> URL {
        let baseURL = Bundle.main.infoForKey("BASE_URL") ?? ""
        return URL(forceString: "\(baseURL)\(trail)")
    }
    
    static func queryItems(dict: [String: String]) -> [String: String] {
        var resultDict = dict
        resultDict["ts"] = "1"
        resultDict["apikey"] = Bundle.main.infoForKey("PUBLIC_KEY") ?? ""
        resultDict["hash"] = Bundle.main.infoForKey("HASH") ?? ""
        return resultDict
    }
}
