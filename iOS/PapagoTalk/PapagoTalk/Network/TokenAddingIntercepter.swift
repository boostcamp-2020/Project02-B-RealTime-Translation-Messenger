//
//  TokenAddingIntercepter.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/09.
//

import Foundation
import Apollo

final class TokenAddingIntercepter: ApolloInterceptor {
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        let token = UserDataProvider().token
        
        self.addTokenAndProceed(token,
                                to: request,
                                chain: chain,
                                response: response,
                                completion: completion)
    }
    
    private func addTokenAndProceed<Operation: GraphQLOperation>(
        _ token: String,
        to request: HTTPRequest<Operation>,
        chain: RequestChain,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        request.addHeader(name: "Authorization", value: "Bearer \(token)")
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
