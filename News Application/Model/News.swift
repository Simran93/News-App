///
//  NewsCollectionViewController.swift
//  News Application
//
//  Created by Simranjeet  Singh on 2019-11-07.
//  Copyright © 2019 Simranjeet  Singh. All rights reserved.
//


import Foundation

// MARK: - News
class News: Codable {
    let status: String
    let source: String
    let sortBy: String
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case source = "source"
        case sortBy = "sortBy"
        case articles = "articles"
    }

    init(status: String, source: String, sortBy: String, articles: [Article]) {
        self.status = status
        self.source = source
        self.sortBy = sortBy
        self.articles = articles
    }
}

// MARK: News convenience initializers and mutators

extension News {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(News.self, from: data)
        self.init(status: me.status, source: me.source, sortBy: me.sortBy, articles: me.articles)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        status: String? = nil,
        source: String? = nil,
        sortBy: String? = nil,
        articles: [Article]? = nil
    ) -> News {
        return News(
            status: status ?? self.status,
            source: source ?? self.source,
            sortBy: sortBy ?? self.sortBy,
            articles: articles ?? self.articles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Article
class Article: Codable {
    let author: String?
    let title: String
    let articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: Date?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
    }

    init(author: String?, title: String, articleDescription: String, url: String, urlToImage: String, publishedAt: Date?) {
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}

// MARK: Article convenience initializers and mutators

extension Article {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Article.self, from: data)
        self.init(author: me.author, title: me.title, articleDescription: me.articleDescription, url: me.url, urlToImage: me.urlToImage, publishedAt: me.publishedAt)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        author: String?? = nil,
        title: String? = nil,
        articleDescription: String? = nil,
        url: String? = nil,
        urlToImage: String? = nil,
        publishedAt: Date?? = nil
    ) -> Article {
        return Article(
            author: author ?? self.author,
            title: title ?? self.title,
            articleDescription: articleDescription ?? self.articleDescription,
            url: url ?? self.url,
            urlToImage: urlToImage ?? self.urlToImage,
            publishedAt: publishedAt ?? self.publishedAt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func newsTask(with url: URL, completionHandler: @escaping (News?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
