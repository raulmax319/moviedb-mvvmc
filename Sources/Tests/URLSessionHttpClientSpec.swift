//
// URLSessionHttpClientSpec.swift
//
// Created by Raul Max on 25/06/23.
// Copyright © 2023 Raul Max. All rights reserved.
//

import Foundation
import XCTest
@testable import MoviedbMVVMC

final class URLSessionHttpClientSpec: XCTestCase {
  var url: URL!
  var sut: URLSessionHttpClient!
  var urlSession: URLSession!

  override func setUp() {
    super.setUp()

    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [URLProtocolMock.self]
    let urlSession = URLSession(configuration: configuration)
    url = URL(string: "http://localmock:3333")
    sut = URLSessionHttpClient(with: url, session: urlSession)
  }

  override func tearDown() {
    sut = nil
    url = nil
    URLProtocolMock.requestHandler = nil

    super.tearDown()
  }

  func testSuccessfulResponse() {
    let expectation = expectation(description: "Did call http request")
    let movieName = "TestMovie"
    let movieJson = "{ \"data\": [ { \"title\": \"\(movieName)\" } ] }".data(using: .utf8)
    URLProtocolMock.requestHandler = { request in
      guard let url = request.url else {
        throw URLError(.badURL)
      }

      let response = HTTPURLResponse(
        url: url,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
      )!

      return (response, movieJson)
    }

    sut.request { (result: Result<Data, Error>) in
      guard case let .success(success) = result else {
        XCTFail("Should have been a success")
        return
      }

      XCTAssertTrue(success.count > 0)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1.0)
  }

  func testParsingFailure() {
    let expectation = expectation(description: "Did call http request")

    URLProtocolMock.requestHandler = { request in
      let response = HTTPURLResponse(
        url: request.url!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
      )!
      return (response, Data())
    }

    sut.request { (result: Result<Data, Error>) in
      guard case let .failure(error) = result else {
        XCTFail("Should have been a failure")
        return
      }

      XCTAssertTrue(error is DecodingError)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1.0)
  }

  func testRawDataFailure() {
    let err = URLError(.cannotDecodeRawData)
    let expectation = expectation(description: "Did call http request")
    URLProtocolMock.requestHandler = { _ in
      throw err
    }

    sut.request { (result: Result<Data, Error>) in
      guard case let .failure(error) = result else {
        XCTFail("Should have been a failure")
        return
      }

      XCTAssertTrue(
        error is URLError,
        "\(type(of: error)) is not equal to URLError"
      )

      XCTAssertTrue(
        error.localizedDescription == err.localizedDescription
      )

      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1.0)
  }
}
