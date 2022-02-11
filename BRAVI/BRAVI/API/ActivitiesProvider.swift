//
//  ActivitiesProvider.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 08/02/22.
//

import Foundation
import Alamofire

struct ActivitiesProvider {
    
    func getActivities(completion: @escaping(Activity?, Bool, Bool) -> Void) {
        
        let url = AddUrlParams.sharedInstance.url
        
        AF.request(url, method: .get, encoding: JSONEncoding.default){$0.timeoutInterval = 5}.responseJSON { res in
            switch res.result {
            case .failure(_):
                completion(nil, true, false)
                
            case .success(_):
                guard let data = res.data else { return }
                
                do {
                    let response = try JSONDecoder().decode(Activity.self, from: data)
                    completion(response, false, true)
                } catch  {
                    completion(nil, false, false)
                }
            }
        }
    }
}
