//
//  SearchApiClientSpec.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 15/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import AppOfMyLife

class SearchApiClientSpec: QuickSpec {
    
    override func spec() {
        describe("getSearchResult") {
            var returnedSearch: [SearchResult]?
            let urlString = TraktAPI.URLs.baseURL + "search/show?query=tron"
            
            context("success") {
                
                beforeEach {
                    let _ = self.stub(urlString: urlString, jsonFileName: "GetSearchResultSuccess")
                    
                    SearchService.search(withQuery: "tron", callback: { response in
                        returnedSearch = response.data
                    })
                }
                
                it("return stats settings") {
                    expect(returnedSearch).toEventuallyNot(beNil())
                    expect(returnedSearch?.first?.type) == "show"
                    expect(returnedSearch?.first?.show?.title) == "Tron: Uprising"
                    expect(returnedSearch?.first?.show?.year) == 2012
                    expect(returnedSearch?.first?.show?.ids?.trakt) == 34209
                }
            }
            
        }
    }
    
}
