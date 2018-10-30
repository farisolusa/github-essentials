import Foundation

/*
{
    "id": 1,
    "user": {
        "user_name": "Tester",
        "real_info": {
            "full_name":"Jon Doe"
        }
    },
    "reviews_count": [
        {
        "count": 4
        }
    ]
}
*/

fileprivate struct RawServerResponse: Decodable {
    struct User: Decodable {
        var user_name: String
        var real_info: RealInfo
    }
    
    struct RealInfo: Decodable {
        var full_name: String
    }
    
    struct Review: Decodable {
        var count: Int
    }
    
    var id: Int
    var user: User
    var reviews_count: [Review]
}

struct ServerResponse: Decodable {
    var id: String
    var userName: String
    var fullName: String
    var reviewCount: Int
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        id = String(rawResponse.id)
        userName = rawResponse.user.user_name
        fullName = rawResponse.user.real_info.full_name
        reviewCount = rawResponse.reviews_count.first!.count
    }
}
