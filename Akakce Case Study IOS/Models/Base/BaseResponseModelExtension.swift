typealias BaseResponseModelExtension = BaseResponseModel

extension BaseResponseModelExtension {
    static func failure(message: String) -> BaseResponseModel<T> {
        return BaseResponseModel(data: nil, isSuccess: false, message: message, statusCode: 400)
    }

    static func success(data: T) -> BaseResponseModel<T> {
        return BaseResponseModel(data: data, isSuccess: true, message: "Success", statusCode: 200)
    }
}
