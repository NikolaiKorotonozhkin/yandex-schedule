//
//  ScheduleModel.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import Foundation

//// MARK: - ScheduleBetweenStations
//struct ScheduleBetweenStations: Decodable, Equatable {
//    let segments: [Segment]
//    let pagination: Pagination
//}
//
//// MARK: - Pagination
//struct Pagination: Decodable, Equatable {
//    let total, limit, offset: Int
//}
//
//// MARK: - SearchFrom
//struct SearchFrom : Decodable, Equatable {
//    let type, title, shortTitle, popularTitle: String
//    let code: String
//}
//
//// MARK: - Segment
//struct Segment: Decodable, Equatable {
//    let thread: Thread
//    let from, to: SegmentFrom
//    let departurePlatform, arrivalPlatform: String
//    let departureTerminal, arrivalTerminal: String?
//    let duration: Int
//    let departure, arrival: Date
//    let startDate: String
//}
//
//// MARK: - SegmentFrom
//struct SegmentFrom: Decodable, Equatable {
//    let type: String
//    let title: String
//    let shortTitle, popularTitle: String?
//    let code: String
//    let stationType: String
//    let stationTypeName: String
//    let transportType: String
//}
//
//
//// MARK: - Thread
//struct Thread: Decodable, Equatable {
//    let number, title, shortTitle: String
//    let transportType: String
//    let carrier: Carrier
//    let uid: String
//    let vehicle: String?
//}
//
//// MARK: - Carrier
//struct Carrier: Decodable, Equatable {
//    let code: Int
//    let title: String
//}



//--------


//// MARK: - ScheduleBetweenStations
//struct ScheduleBetweenStations: Decodable, Equatable {
//    let search: Search
//    let segments: [Segment]
//    let pagination: Pagination
//}
//
//// MARK: - Pagination
//struct Pagination: Decodable, Equatable {
//    let total, limit, offset: Int
//}
//
//// MARK: - Search
//struct Search: Decodable, Equatable {
//    let from, to: SearchFrom
//    let date: String
//}
//
//// MARK: - SearchFrom
//struct SearchFrom: Decodable, Equatable {
//    let type, title, shortTitle, popularTitle: String?
//    let code: String
//}
//
//// MARK: - Segment
//struct Segment: Decodable, Equatable {
//    let thread: Thread
//    let stops: String
//    let from, to: SegmentFrom
//    let departurePlatform, arrivalPlatform: String
//    let departureTerminal, arrivalTerminal: String?
//    let duration: Int
//    let hasTransfers: Bool
//    let departure, arrival: Date
//    let startDate: String
//}
//
//// MARK: - SegmentFrom
//struct SegmentFrom: Decodable, Equatable {
//    let type: TypeEnum
//    let title: String
//    let shortTitle, popularTitle: String?
//    let code: String
//    let stationType: StationType
//    let stationTypeName: StationTypeName
//    let transportType: TransportType
//}
//
//enum StationType: String, Decodable, Equatable {
//    case airport
//    case trainStation
//}
//
//enum StationTypeName: String, Decodable, Equatable {
//    case аэропорт
//    case вокзал
//}
//
//enum TransportType: String, Decodable, Equatable {
//    case plane
//    case train
//}
//
//enum TypeEnum: String, Decodable, Equatable {
//    case station
//}
//
//// MARK: - Thread
//struct Thread: Decodable, Equatable {
//    let number, title, shortTitle: String
//    let expressType: String
//    let transportType: TransportType
//    let carrier: Carrier
//    let uid: String
//    let vehicle: String?
//    let threadMethodLink: String
//}
//
//// MARK: - Carrier
//struct Carrier: Decodable, Equatable {
//    let code: Int
//    let title: String
//    let codes: Codes
//    let address: String
//    let url: String
//    let email: String?
//    let contacts, phone: String
//    let logo: String?
//    let logoSVG: String?
//}
//
//// MARK: - Codes
//struct Codes: Decodable, Equatable {
//    let sirena, iata, icao: String?
//}
//
//



//-------

// MARK: - ScheduleBetweenStations
struct ScheduleBetweenStations: Decodable, Equatable {
    let search: Search?
    let segments: [Segment]
//    let intervalSegments: [Any?]?
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Decodable, Equatable {
    let total, limit, offset: Int?
}

// MARK: - Search
struct Search: Decodable, Equatable {
    let from, to: SearchFrom?
    let date: String?
}

// MARK: - SearchFrom
struct SearchFrom: Decodable, Equatable {
    let type, title, shortTitle, popularTitle: String?
    let code: String?
}

// MARK: - Segment
struct Segment: Decodable, Equatable {
    let thread: Thread?
    let stops: String?
    let from, to: SegmentFrom?
    let departurePlatform, arrivalPlatform: String?
    let departureTerminal, arrivalTerminal: String?
    let duration: Int?
    let hasTransfers: Bool?
    let ticketsInfo: TicketsInfo?
    let departure, arrival: String?
    let startDate: String?
}

// MARK: - SegmentFrom
struct SegmentFrom: Decodable, Equatable {
    let type: TypeEnum?
    let title: String?
    let shortTitle, popularTitle: String?
    let code: String?
    let stationType: StationType?
    let stationTypeName: StationTypeName?
    let transportType: TransportType?
}

enum StationType: String, Decodable, Equatable {
    case airport
    case trainStation
}

enum StationTypeName: String, Decodable, Equatable {
    case аэропорт
    case вокзал
}

enum TransportType: String, Decodable, Equatable {
    case plane
    case train
    case suburban
    case bus
//    case water
//    case helicopter
}

enum TypeEnum: String, Decodable, Equatable {
    case station
}

// MARK: - Thread
struct Thread: Decodable, Equatable {
    let number, title, shortTitle: String?
    let expressType: String?
    let transportType: TransportType?
    let carrier: Carrier?
    let uid: String?
    let vehicle: String?
    let transportSubtype: TransportSubtype?
    let threadMethodLink: String?
}

// MARK: - Carrier
struct Carrier: Decodable, Equatable {
    let code: Int?
    let title: String?
    let codes: Codes?
    let address: String?
    let url: String?
    let email: String?
    let contacts, phone: String?
    let logo: String?
    let logoSVG: String?
}

// MARK: - Codes
struct Codes: Decodable, Equatable {
    let sirena, iata, icao: String?
}

// MARK: - TransportSubtype
struct TransportSubtype: Decodable, Equatable {
    let title, code, color: String?
}

// MARK: - TicketsInfo
struct TicketsInfo: Decodable, Equatable {
    let etMarker: Bool?
//    let places: [Any?]?
}

