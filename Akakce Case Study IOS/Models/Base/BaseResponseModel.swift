struct BaseResponseModel<T: Codable>: Codable {
    let data: T?
    let message: String?
    let isSuccess: Bool?
    let statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case data
        case message
        case isSuccess
        case statusCode
    }

    init(data: T? = nil, isSuccess: Bool = false, message: String? = nil, statusCode: Int? = nil) {
        self.data = data
        self.isSuccess = isSuccess
        self.message = message
        self.statusCode = statusCode
    }
}
