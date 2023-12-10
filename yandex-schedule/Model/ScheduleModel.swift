//
//  ScheduleModel.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import Foundation

// MARK: - ScheduleBetweenStations
struct ScheduleBetweenStations: Codable {
    let search: Search?
    let segments: [Segment]?
    let intervalSegments: [JSONAny]?
    let pagination: Pagination?

    enum CodingKeys: String, CodingKey {
        case search, segments
        case intervalSegments = "interval_segments"
        case pagination
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, limit, offset: Int?
}

// MARK: - Search
struct Search: Codable {
    let from, to: SearchFrom?
    let date: String?
}

// MARK: - SearchFrom
struct SearchFrom: Codable {
    let type, title, shortTitle, popularTitle: String?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case type, title
        case shortTitle = "short_title"
        case popularTitle = "popular_title"
        case code
    }
}

// MARK: - Segment
struct Segment: Codable {
    let thread: Thread?
    let stops: String?
    let from, to: SegmentFrom?
    let departurePlatform, arrivalPlatform: String?
    let departureTerminal, arrivalTerminal: String?
    let duration: Int?
    let hasTransfers: Bool?
    let ticketsInfo: TicketsInfo?
    let departure, arrival: String
    let startDate: String?

    enum CodingKeys: String, CodingKey {
        case thread, stops, from, to
        case departurePlatform = "departure_platform"
        case arrivalPlatform = "arrival_platform"
        case departureTerminal = "departure_terminal"
        case arrivalTerminal = "arrival_terminal"
        case duration
        case hasTransfers = "has_transfers"
        case ticketsInfo = "tickets_info"
        case departure, arrival
        case startDate = "start_date"
    }
}

// MARK: - SegmentFrom
struct SegmentFrom: Codable {
    let type: TypeEnum?
    let title: String?
    let shortTitle, popularTitle: String?
    let code: String?
    let stationType: String?
    let stationTypeName: String?
    let transportType: TransportType?

    enum CodingKeys: String, CodingKey {
        case type, title
        case shortTitle = "short_title"
        case popularTitle = "popular_title"
        case code
        case stationType = "station_type"
        case stationTypeName = "station_type_name"
        case transportType = "transport_type"
    }
}

//enum StationType: String, Codable {
//    case airport = "airport"
//    case trainStation = "train_station"
//}

//enum StationTypeName: String, Codable {
//    case аэропорт = "аэропорт"
//    case вокзал = "вокзал"
//}

enum TransportType: String, Codable {
    case plane
    case train
    case suburban
    case bus
    //    case water
    //    case helicopter
}

enum TypeEnum: String, Codable {
    case station = "station"
}

// MARK: - Thread
struct Thread: Codable {
    let number, title, shortTitle: String?
    let expressType: String?
    let transportType: TransportType?
    let carrier: Carrier?
    let uid: String?
    let vehicle: String?
    let transportSubtype: TransportSubtype?
    let threadMethodLink: String?

    enum CodingKeys: String, CodingKey {
        case number, title
        case shortTitle = "short_title"
        case expressType = "express_type"
        case transportType = "transport_type"
        case carrier, uid, vehicle
        case transportSubtype = "transport_subtype"
        case threadMethodLink = "thread_method_link"
    }
}

// MARK: - Carrier
struct Carrier: Codable {
    let code: Int?
    let title: String?
    let codes: Codes?
    let address: String?
    let url: String?
    let email: String?
    let contacts, phone: String?
    let logo: String?
    let logoSVG: String?

    enum CodingKeys: String, CodingKey {
        case code, title, codes, address, url, email, contacts, phone, logo
        case logoSVG = "logo_svg"
    }
}

// MARK: - Codes
struct Codes: Codable {
    let sirena, iata, icao: String?
}

// MARK: - TransportSubtype
struct TransportSubtype: Codable {
    let title, code, color: String?
}

// MARK: - TicketsInfo
struct TicketsInfo: Codable {
    let etMarker: Bool?
    let places: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case etMarker = "et_marker"
        case places
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
