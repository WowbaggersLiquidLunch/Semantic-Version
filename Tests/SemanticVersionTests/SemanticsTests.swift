import XCTest
@testable import SemanticVersion

final class SemanticsTests: XCTestCase {
	func testDenotingStableRelease() {
		let stableVersions: [SemanticVersion] = [
			"1.0.0",
			"1.0.1",
			"1.2.3",
			"987.654.321",
			"3.2.1+abcde"
		]
		
		for stableVersion in stableVersions {
			XCTAssertTrue(stableVersion.denotesStableRelease)
		}
		
		let unstableVersions: [SemanticVersion] = [
			"0.0.0",
			"0.0.1",
			"0.1.2",
			"0.9.8-gm",
			"1.0.0-beta",
			"9.9.9-alpha+xyz"
		]
		
		for unstableVersion in unstableVersions {
			XCTAssertFalse(unstableVersion.denotesStableRelease)
		}
	}
	
	func testDenotingPrerelease() {
		let prereleaseVersions: [SemanticVersion] = [
			"0.0.0-asd",
			"0.0.1-fgh",
			"0.1.0-jkl",
			"0.9.8-qwe+rty",
			"1.0.0-uio",
			"1.2.3-zxc"
		]
		
		for prereleaseVersion in prereleaseVersions {
			XCTAssertTrue(prereleaseVersion.denotesPrerelease)
		}
		
		let releaseVersions: [SemanticVersion] = [
			"0.0.0",
			"0.0.1",
			"0.1.0",
			"0.9.8+rty",
			"1.0.0",
			"1.2.3",
			"0.0.0+-asd",
			"0.0.1+-fgh",
			"0.1.0+-jkl",
			"0.9.8+-qwe-rty",
			"1.0.0+-uio",
			"1.2.3+-zxc"
		]
		
		for releaseVersion in releaseVersions {
			XCTAssertFalse(releaseVersion.denotesPrerelease)
		}
	}
	
	func testDenotingSourceBreakableRelease() {
		let sortedBreakableVersions: [SemanticVersion] = [
			"0.0.0-123",
			"0.0.0-abc",
			"0.0.0",
			"0.0.1-456",
			"0.0.1-def",
			"0.0.1",
			"0.0.2-789",
			"0.0.2-ghi",
			"0.0.2",
			"0.1.0-876",
			"0.1.0-jkl",
			"0.1.0",
			"0.1.2-543",
			"0.1.2-mno",
			"0.1.2",
			"1.0.0-212",
			"1.0.0-pqr",
			"1.0.0",
			"2.0.0-345",
			"2.0.0-stu",
			"2.0.0",
			"3.4.5-678",
			"3.4.5-vwx",
			"3.4.5"
		]
		
		for newVersionIndex in 1..<sortedBreakableVersions.count {
			for oldVersionIndex in 0..<newVersionIndex {
				let newVersion = sortedBreakableVersions[newVersionIndex]
				let oldVersion = sortedBreakableVersions[oldVersionIndex]
				XCTAssertTrue(newVersion.denotesSourceBreakableRelease(fromThatWith: oldVersion))
				XCTAssertFalse(newVersion.denotesSourceBreakableRelease(fromThatWith: newVersion))
				XCTAssertFalse(oldVersion.denotesSourceBreakableRelease(fromThatWith: oldVersion))
				XCTAssertFalse(oldVersion.denotesSourceBreakableRelease(fromThatWith: newVersion))
			}
		}
		
		let sourceStableVersionPairs: [(newVersion: SemanticVersion, oldVersion: SemanticVersion)] = [
			("1.0.1", "1.0.0"),
			
			("1.0.2", "1.0.0"),
			("1.0.2", "1.0.1"),
			
			("1.1.0", "1.0.0"),
			("1.1.0", "1.0.0"),
			("1.1.0", "1.0.1"),
			
			("1.2.3", "1.0.0"),
			("1.2.3", "1.0.0"),
			("1.2.3", "1.0.1"),
			("1.2.3", "1.1.0"),
		]
		
		for sourceStableVersionPair in sourceStableVersionPairs {
			let newVersion = sourceStableVersionPair.newVersion
			let oldVersion = sourceStableVersionPair.oldVersion
			XCTAssertFalse(newVersion.denotesSourceBreakableRelease(fromThatWith: oldVersion))
		}
	}
}
