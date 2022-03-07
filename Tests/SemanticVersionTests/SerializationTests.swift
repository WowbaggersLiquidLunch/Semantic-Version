import XCTest
@testable import SemanticVersion

final class SerializationTests:XCTestCase {
	func testEncodingToJSON() throws {
		func assertEncoding(_ version: SemanticVersion, to expectedJSONObject: String) throws {
			let jsonEncoder = JSONEncoder()
			jsonEncoder.outputFormatting = [.withoutEscapingSlashes, .sortedKeys]
			let encodedVersion = try jsonEncoder.encode(version)
			XCTAssertEqual(
				String(data: encodedVersion, encoding: .utf8),
				//	Because Semantic Versioning 2.0.0 does not allow whitespace in identifiers, we can remove whitespace from the expected JSON object string.
				expectedJSONObject.filter { !$0.isWhitespace }
			)
		}
		
		let testCases: KeyValuePairs = [
			try SemanticVersion(0, 0, 0): #""0.0.0""#,
			try SemanticVersion(6, 9, 42): #""6.9.42""#,
			try SemanticVersion(1, 2, 3, prereleaseIdentifiers: ["beta-004", "5"]): #""1.2.3-beta-004.5""#,
			try SemanticVersion(6, 7, 8, buildMetadataIdentifiers: ["2020-02-02", "sha256-C951120B9D2E83CCCF8F51477FF53943447D56899185E0E0DC7C3EDFBA19CD60"]): #""6.7.8+2020-02-02.sha256-C951120B9D2E83CCCF8F51477FF53943447D56899185E0E0DC7C3EDFBA19CD60""#,
			try SemanticVersion(9, 10, 11, prereleaseIdentifiers: ["alpha42", "release-candidate-1"], buildMetadataIdentifiers: ["md5-8981EDE66EBF3F83819F709A73B22BBA"]): #""9.10.11-alpha42.release-candidate-1+md5-8981EDE66EBF3F83819F709A73B22BBA""#
		]
		
		try testCases.forEach { try assertEncoding($0, to: $1) }
	}
	
	func testDecodingFromJSON() throws {
		func assertDecoding(_ jsonObject: String, to expectedVersion: SemanticVersion) throws {
			let jsonDecoder = JSONDecoder()
			let jsonObjectData = Data(jsonObject.utf8)
			let decodedVersion = try jsonDecoder.decode(SemanticVersion.self, from: jsonObjectData)
			XCTAssertEqual(decodedVersion, expectedVersion)
		}
		
		let validCases: KeyValuePairs = [
			#""0.0.0""#: try SemanticVersion(0, 0, 0),
			#""6.7.42""#: try SemanticVersion(6, 7, 42),
			#""1.2.3--41ph4-1337.7.0""#: try SemanticVersion(1, 2, 3, prereleaseIdentifiers: ["-41ph4-1337", "7", "0"]),
			#""8.9.10+LTS.sha256-076F19B8ECCD0B911C407C4881DE9D0C1D8128B631CF52DBB7BB96C11EA5D5EA""#: try SemanticVersion(8, 9, 10, buildMetadataIdentifiers: ["LTS", "sha256-076F19B8ECCD0B911C407C4881DE9D0C1D8128B631CF52DBB7BB96C11EA5D5EA"]),
			#""11.12.13-beta.golden-master.42+md5-5FDD8FAC22BF07D9010F7F482745F6D5""#: try SemanticVersion(11, 12, 13, prereleaseIdentifiers: ["beta", "golden-master", "42"], buildMetadataIdentifiers: ["md5-5FDD8FAC22BF07D9010F7F482745F6D5"])
		]
		
		func assertSemanticVersionErrorThrownFromDecoding(_ jsonObject: String) {
			let jsonDecoder = JSONDecoder()
			let jsonObjectData = Data(jsonObject.utf8)
			XCTAssertThrowsError(try jsonDecoder.decode(SemanticVersion.self, from: jsonObjectData)) { error in 
				XCTAssertTrue(error is SemanticVersionError)
			}
		}
		
		try validCases.forEach { try assertDecoding($0, to: $1) }
		
		let invalidCases = [
			#""""#,
			#"" ""#,
			#"".""#,
			#""-""#,
			#""+""#,
			#""..-+""#,
			
			#""1""#,
			#""1.2""#,
			#""1.2.""#,
			#"".2.3""#,
			#""1.2.3.4""#,
			
			#""a.b.c""#,
			
			#""-0.0.0""#,
			#""0.-0.0""#,
			#""0.0.-0""#,
			#""-1.2.3""#,
			#""1.-2.3""#,
			#""1.2.-3""#,
			
			#""00.0.0""#,
			#""0.00.0""#,
			#""0.0.00""#,
			#""01.2.3""#,
			#""1.02.3""#,
			#""1.2.03""#,
			
			#""4.5.6-""#,
			#""7.8.9- ""#,
			#""0.1.2-.""#,
			#""3.4.5-..""#,
			#""6.7.8-.a""#,
			#""9.0.1-b.""#,
			#""2.3.4-00""#,
			#""5.6.7-01""#,
			#""8.9.0- 0""#,
			#""9.8.7-@#""#,
			#""6.5.4-œ∑""#,
			#""3.2.1-+""#,
			
			#""0.9.8+""#,
			#""7.6.5+ ""#,
			#""4.3.2++""#,
			#""1.0.9+.""#,
			#""8.7.6+..""#,
			#""5.4.3+.a""#,
			#""2.1.0+b.""#,
			#""0.1.1+ 0""#,
			#""2.3.5+@#""#,
			#""8.1.3+¥ø""#,
		]
		
		invalidCases.forEach { assertSemanticVersionErrorThrownFromDecoding($0) }
	}
}
