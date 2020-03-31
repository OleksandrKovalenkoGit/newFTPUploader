//
//  APIRequset+Extensions.swift
//  NewFTPUploader
//
//  Created by Golos on 03.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

extension APIRequest {
    static var project: APIRequest<ProjectContainer> {
        return APIRequest<ProjectContainer>(httpMethod: .get,
                                            requestName: "projects",
                                            getParameters: ["show_all": "0"],
                                            isTokenRequired: true)
    }
    
    static func builds(projectId: Int) -> APIRequest<[BuildModel]> {
        return APIRequest<[BuildModel]>(httpMethod: .get,
                                        requestName: "builds",
                                        getParameters: ["project_id": projectId],
                                        isTokenRequired: true)
    }
    
    static func auth(login: String, password: String, deviceToken: String?) -> APIRequest<AuthModel> {
        var postParameters: [String: Any] = ["login": login,
                                             "password": password,
                                             "keep_login": true]
        postParameters["device_token"] = deviceToken ?? ""
        
        return APIRequest<AuthModel>(httpMethod: .post,
                                     requestName: "login",
                                     postParameters: postParameters)
    }
    
    static var logout: APIRequest<LogoutModel> {
        return APIRequest<LogoutModel>(httpMethod: .get,
                                       requestName: "logout")
    }
    
    static func pushDevice(token: String) -> APIRequest<EmptyModel> {
        return APIRequest<EmptyModel>(httpMethod: .get,
                                      requestName: "push_device_token",
                                      getParameters: ["device_token": token],
                                      isTokenRequired: true)
    }
}
