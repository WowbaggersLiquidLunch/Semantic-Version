import XCTest
@testable import SemanticVersion

final class PrecedenceTests: XCTestCase {
	func assert(_ version1: SemanticVersion, precedes version2: SemanticVersion) {
		XCTAssertLessThan(version1, version2)
		XCTAssertLessThanOrEqual(version1, version2)
		XCTAssertGreaterThan(version2, version1)
		XCTAssertGreaterThanOrEqual(version2, version1)
		XCTAssertNotEqual(version1, version2)
		XCTAssertNotEqual(version2, version1)
		XCTAssertFalse(version1 > version2)
		XCTAssertFalse(version1 >= version2)
		XCTAssertFalse(version2 < version1)
		XCTAssertFalse(version2 <= version1)
	}
	
	func assert(_ version1: SemanticVersion, equals version2: SemanticVersion) {
		XCTAssertEqual(version1, version2)
		XCTAssertEqual(version2, version1)
		XCTAssertLessThanOrEqual(version1, version2)
		XCTAssertLessThanOrEqual(version1, version2)
		XCTAssertGreaterThanOrEqual(version1, version2)
		XCTAssertGreaterThanOrEqual(version2, version1)
		XCTAssertFalse(version1 != version2)
		XCTAssertFalse(version2 != version1)
		XCTAssertFalse(version1 < version2)
		XCTAssertFalse(version2 < version1)
		XCTAssertFalse(version1 > version2)
		XCTAssertFalse(version2 > version1)
	}
	
	func testVersionCorePrecedence() throws {
		assert("0.0.0", precedes: "0.0.1")
		assert("0.0.0", precedes: "0.1.0")
		assert("0.0.0", precedes: "1.0.0")
		assert("1.2.3", precedes: "1.2.4")
		assert("1.2.3", precedes: "1.3.3")
		assert("1.2.3", precedes: "2.2.3")
		
		assert("0.0.0", equals: "0.0.0")
		assert("1.2.3", equals: "1.2.3")
		assert("3.2.1", equals: "3.2.1")
	}
	
	func testPrereleasePrecedence() throws {
		//	Test cases include different combinations of numeric and alpha-numeric identifiers, with different precedences, and try to capture edge cases.
		
		assert("1.2.3-beta", precedes: "1.2.3")
		assert("1.2.3-beta", precedes: "1.2.4")
		assert("1.2.2", precedes: "1.2.3-beta")
		assert("1.2.3", precedes: "1.2.4-beta")
		assert("1.2.3", precedes: "1.3.3-beta")
		assert("1.2.3", precedes: "2.2.3-beta")
		
		assert("1.2.3-beta", precedes: "1.2.4-beta")
		assert("1.2.3-alpha", precedes: "1.2.4-beta")
		assert("1.2.3-beta", precedes: "1.2.4-alpha")
		
		assert("1.2.3-beta", precedes: "1.2.3-betax")
		assert("1.2.3-beta", precedes: "1.2.3-beta-x")
		assert("1.2.3-beta", precedes: "1.2.3-beta1")
		assert("1.2.3-beta", precedes: "1.2.3-beta-1")
		assert("1.2.3-beta", precedes: "1.2.3-beta1x")
		assert("1.2.3-beta", precedes: "1.2.3-beta-1x")
		assert("1.2.3-beta", precedes: "1.2.3-betax1")
		assert("1.2.3-beta", precedes: "1.2.3-beta-x1")
		
		assert("1.2.3-beta", precedes: "1.2.3-beta.x")
		assert("1.2.3-beta", precedes: "1.2.3-beta.1")
		assert("1.2.3-beta", precedes: "1.2.3-beta.1x")
		assert("1.2.3-beta", precedes: "1.2.3-beta.x1")
		
		assert("1.2.3-a", precedes: "1.2.3-beta")
		assert("1.2.3-alpha", precedes: "1.2.3-beta")
		assert("1.2.3-alpha42", precedes: "1.2.3-beta")
		assert("1.2.3-alpha-42", precedes: "1.2.3-beta")
		assert("1.2.3-alpha.42", precedes: "1.2.3-beta")
		
		assert("4.5.6-1bcd", precedes: "4.5.6-abcd")
		assert("4.5.6-abcd", precedes: "4.5.7-1bcd")
		
		assert("1.2.3-456", precedes: "1.2.3-alpha")
		assert("1.2.3-456.alpha", precedes: "1.2.3-alpha")
		
		assert("4.5.6-123", precedes: "4.5.6-987")
		assert("4.5.6-123", precedes: "4.5.6-124")
		assert("4.5.6-123.456.789", precedes: "4.5.6-123.456.987")
		assert("4.5.6-123.456.789", precedes: "4.5.6-321.111.111")
		assert("4.5.6-9.9.9.9.9.9", precedes: "4.5.6-10")
		assert("4.5.6-9.9.9.9.9.9", precedes: "4.5.6-10.0.0.0.0")
		
		assert("4.5.6-abc.def.123", precedes: "4.5.6-abc.def.789")
		assert("4.5.6-abc.def.789", precedes: "4.5.6-abc.ghi.123")
		assert("4.5.6-123.def-ghi", precedes: "4.5.6-789.abc.def")
		
		assert("4.5.6-987", precedes: "4.5.6-123a")
		assert("4.5.6-987654321", precedes: "4.5.6-0a")
		assert("4.5.6-999999999", precedes: "4.5.6-0a")
		assert("4.5.6-999999999.zzzzz.zzzzz", precedes: "4.5.6-0a")
		assert("4.5.6-abc.def.123", precedes: "4.5.6-abc.def.ghi")
		assert("4.5.6-abc.987.ghi", precedes: "4.5.6-abc.123def.123")
		
		assert("4.5.6-abc-123def-123", precedes: "4.5.6-abc-987-ghi")
		
		assert("4.5.6-0a", precedes: "4.5.7-987")
		assert("4.5.6-0a", precedes: "4.6.6-987")
		assert("4.5.6-0a", precedes: "5.5.6-987")
		
		assert("1.2.3-beta", equals: "1.2.3-beta")
		assert("4.5.6-123abc", equals: "4.5.6-123abc")
		assert("4.5.6-123-abc", equals: "4.5.6-123-abc")
		assert("4.5.6-123.abc", equals: "4.5.6-123.abc")
		assert("4.5.6-abc123", equals: "4.5.6-abc123")
		assert("4.5.6-abc-123", equals: "4.5.6-abc-123")
		assert("4.5.6-abc.123", equals: "4.5.6-abc.123")
		assert("4.5.6-abc123.123abc.123-abc.abc-123", equals: "4.5.6-abc123.123abc.123-abc.abc-123")
	}
	
	func testBuildMetadataPrecedence() throws {
		
		//	In addition to hardcoded different combinations of numeric and alpha-numeric identifiers, with different precedences, some build metadata is randomly generated at each run of the test.
		
		var randomBuildMetadata: String {
			let lexicon = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-."
			let length = UInt8.random(in: 1...(.max))	//	don't be too long
			var characters: [Character] = []
			characters.reserveCapacity(Int(length))
			for position in 1...length {
				if let lastCharacter = characters.last, lastCharacter != ".", position != length {
					characters.append(lexicon.randomElement()!)
				} else {
					characters.append(lexicon.dropLast().randomElement()!)
				}
			}
			return String(characters)
		}
		
		assert("0.0.0+abc", precedes: "0.0.1+abc")
		assert("0.0.0+abc", precedes: "0.0.1+bcd")
		assert("0.0.0+bcd", precedes: "0.0.1+abc")
		assert("0.0.0+123", precedes: "0.1.0+123")
		assert("0.0.0+123", precedes: "0.1.0+234")
		assert("0.0.0+234", precedes: "0.1.0+123")
		assert("0.0.0+1a2b3c", precedes: "1.0.0+1a2b3c")
		assert("0.0.0+1a2b3c", precedes: "1.0.0+3c2b1a")
		assert("0.0.0+3c2b1a", precedes: "1.0.0+1a2b3c")
		assert("1.2.3+a1b2c3", precedes: "1.2.4+a1b2c3")
		assert("1.2.3+a1b2c3", precedes: "1.2.4+c3b2a1")
		assert("1.2.3+c3b2a1", precedes: "1.2.4+a1b2c3")
		assert("1.2.3+1-2-3", precedes: "1.3.3+1-2-3")
		assert("1.2.3+1-2-3", precedes: "1.3.3+3-2-1")
		assert("1.2.3+3-2-1", precedes: "1.3.3+1-2-3")
		assert("1.2.3+1.2.3", precedes: "2.2.3+1.2.3")
		assert("1.2.3+1.2.3", precedes: "2.2.3+2.3.4")
		assert("1.2.3+2.3.4", precedes: "2.2.3+1.2.3")
		
		assert("0.0.0+a-b-c", equals: "0.0.0+a-b-c")
		assert("0.0.0+a-b-c", equals: "0.0.0+c-b-a")
		assert("0.0.0+c-b-a", equals: "0.0.0+a-b-c")
		assert("1.2.3+a.b.c", equals: "1.2.3+a.b.c")
		assert("1.2.3+a.b.c", equals: "1.2.3+c.b.a")
		assert("1.2.3+c.b.a", equals: "1.2.3+a.b.c")
		assert("3.2.1+a-1.b-2.c-3", equals: "3.2.1+a-1.b-2.c-3")
		assert("3.2.1+a-1.b-2.c-3", equals: "3.2.1+3.c-2.b-1.a")
		assert("3.2.1+3.c-2.b-1.a", equals: "3.2.1+a-1.b-2.c-3")
		
		assert("1.2.3-beta+---", precedes: "1.2.3+---")
		assert("1.2.3-beta+-", precedes: "1.2.3+---")
		assert("1.2.3-beta+---", precedes: "1.2.3+-")
		assert("1.2.3-beta+-.-", precedes: "1.2.4+-.-")
		assert("1.2.3-beta+-.-.-", precedes: "1.2.4+-.-")
		assert("1.2.3-beta+-.-", precedes: "1.2.4+-.-.-")
		assert("1.2.2+000", precedes: "1.2.3-beta+000")
		assert("1.2.2+000", precedes: "1.2.3-beta+0")
		assert("1.2.2+0", precedes: "1.2.3-beta+000")
		assert("1.2.3+\(randomBuildMetadata)", precedes: "1.2.4-beta+\(randomBuildMetadata)")
		assert("1.2.3+\(randomBuildMetadata)", precedes: "1.3.3-beta+\(randomBuildMetadata)")
		assert("1.2.3+\(randomBuildMetadata)", precedes: "2.2.3-beta+\(randomBuildMetadata)")
		
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.4-beta+\(randomBuildMetadata)")
		assert("1.2.3-alpha+\(randomBuildMetadata)", precedes: "1.2.4-beta+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.4-alpha+\(randomBuildMetadata)")
		
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-betax+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta-x+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta1+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta-1+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta1x+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta-1x+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-betax1+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta-x1+\(randomBuildMetadata)")
		
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta.x+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta.1+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta.1x+\(randomBuildMetadata)")
		assert("1.2.3-beta+\(randomBuildMetadata)", precedes: "1.2.3-beta.x1+\(randomBuildMetadata)")
		
		assert("1.2.3-a+\(randomBuildMetadata)", precedes: "1.2.3-beta+\(randomBuildMetadata)")
		assert("1.2.3-alpha+\(randomBuildMetadata)", precedes: "1.2.3-beta+\(randomBuildMetadata)")
		assert("1.2.3-alpha42+\(randomBuildMetadata)", precedes: "1.2.3-beta+\(randomBuildMetadata)")
		assert("1.2.3-alpha-42+\(randomBuildMetadata)", precedes: "1.2.3-beta+\(randomBuildMetadata)")
		assert("1.2.3-alpha.42+\(randomBuildMetadata)", precedes: "1.2.3-beta+\(randomBuildMetadata)")
		
		assert("4.5.6-1bcd+\(randomBuildMetadata)", precedes: "4.5.6-abcd+\(randomBuildMetadata)")
		assert("4.5.6-abcd+\(randomBuildMetadata)", precedes: "4.5.7-1bcd+\(randomBuildMetadata)")
		
		assert("1.2.3-456+\(randomBuildMetadata)", precedes: "1.2.3-alpha+\(randomBuildMetadata)")
		assert("1.2.3-456.alpha+\(randomBuildMetadata)", precedes: "1.2.3-alpha+\(randomBuildMetadata)")
		
		assert("4.5.6-123+\(randomBuildMetadata)", precedes: "4.5.6-987+\(randomBuildMetadata)")
		assert("4.5.6-123+\(randomBuildMetadata)", precedes: "4.5.6-124+\(randomBuildMetadata)")
		assert("4.5.6-123.456.789+\(randomBuildMetadata)", precedes: "4.5.6-123.456.987+\(randomBuildMetadata)")
		assert("4.5.6-123.456.789+\(randomBuildMetadata)", precedes: "4.5.6-321.111.111+\(randomBuildMetadata)")
		assert("4.5.6-9.9.9.9.9.9+\(randomBuildMetadata)", precedes: "4.5.6-10+\(randomBuildMetadata)")
		assert("4.5.6-9.9.9.9.9.9+\(randomBuildMetadata)", precedes: "4.5.6-10.0.0.0.0+\(randomBuildMetadata)")
		
		assert("4.5.6-abc.def.123+\(randomBuildMetadata)", precedes: "4.5.6-abc.def.789+\(randomBuildMetadata)")
		assert("4.5.6-abc.def.789+\(randomBuildMetadata)", precedes: "4.5.6-abc.ghi.123+\(randomBuildMetadata)")
		assert("4.5.6-123.def-ghi+\(randomBuildMetadata)", precedes: "4.5.6-789.abc.def+\(randomBuildMetadata)")
		
		assert("4.5.6-987+\(randomBuildMetadata)", precedes: "4.5.6-123a+\(randomBuildMetadata)")
		assert("4.5.6-987654321+\(randomBuildMetadata)", precedes: "4.5.6-0a+\(randomBuildMetadata)")
		assert("4.5.6-999999999+\(randomBuildMetadata)", precedes: "4.5.6-0a+\(randomBuildMetadata)")
		assert("4.5.6-999999999.zzzzz.zzzzz+\(randomBuildMetadata)", precedes: "4.5.6-0a+\(randomBuildMetadata)")
		assert("4.5.6-abc.def.123+\(randomBuildMetadata)", precedes: "4.5.6-abc.def.ghi+\(randomBuildMetadata)")
		assert("4.5.6-abc.987.ghi+\(randomBuildMetadata)", precedes: "4.5.6-abc.123def.123+\(randomBuildMetadata)")
		
		assert("4.5.6-abc-123def-123+\(randomBuildMetadata)", precedes: "4.5.6-abc-987-ghi+\(randomBuildMetadata)")
		
		assert("4.5.6-0a+\(randomBuildMetadata)", precedes: "4.5.7-987+\(randomBuildMetadata)")
		assert("4.5.6-0a+\(randomBuildMetadata)", precedes: "4.6.6-987+\(randomBuildMetadata)")
		assert("4.5.6-0a+\(randomBuildMetadata)", precedes: "5.5.6-987+\(randomBuildMetadata)")
		
		assert("1.2.3-beta+\(randomBuildMetadata)", equals: "1.2.3-beta+\(randomBuildMetadata)")
		assert("4.5.6-123abc+\(randomBuildMetadata)", equals: "4.5.6-123abc+\(randomBuildMetadata)")
		assert("4.5.6-123-abc+\(randomBuildMetadata)", equals: "4.5.6-123-abc+\(randomBuildMetadata)")
		assert("4.5.6-123.abc+\(randomBuildMetadata)", equals: "4.5.6-123.abc+\(randomBuildMetadata)")
		assert("4.5.6-abc123+\(randomBuildMetadata)", equals: "4.5.6-abc123+\(randomBuildMetadata)")
		assert("4.5.6-abc-123+\(randomBuildMetadata)", equals: "4.5.6-abc-123+\(randomBuildMetadata)")
		assert("4.5.6-abc.123+\(randomBuildMetadata)", equals: "4.5.6-abc.123+\(randomBuildMetadata)")
		assert("4.5.6-abc123.123abc.123-abc.abc-123+\(randomBuildMetadata)", equals: "4.5.6-abc123.123abc.123-abc.abc-123+\(randomBuildMetadata)")
	}
}
