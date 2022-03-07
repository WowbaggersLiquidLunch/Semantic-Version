import XCTest
@testable import SemanticVersion

final class DirectInitializationTests: XCTestCase {
	func testInitializationFromComponents() throws {
		
		//	MARK: primary public properties
		
		let version1 = try SemanticVersion(0, 0, 0, prereleaseIdentifiers: [], buildMetadataIdentifiers: [])
		XCTAssertEqual(version1.major, 0)
		XCTAssertEqual(version1.minor, 0)
		XCTAssertEqual(version1.patch, 0)
		XCTAssertEqual(version1.prereleaseIdentifiers, [])
		XCTAssertEqual(version1.buildMetadataIdentifiers, [])
		
		let version2 = try SemanticVersion(1, 2, 3, prereleaseIdentifiers: [], buildMetadataIdentifiers: [])
		XCTAssertEqual(version2.major, 1)
		XCTAssertEqual(version2.minor, 2)
		XCTAssertEqual(version2.patch, 3)
		XCTAssertEqual(version2.prereleaseIdentifiers, [])
		XCTAssertEqual(version2.buildMetadataIdentifiers, [])
		
		let version3 = try SemanticVersion(42, 41, 40, prereleaseIdentifiers: ["beta", "1337", "0"], buildMetadataIdentifiers: [])
		XCTAssertEqual(version3.major, 42)
		XCTAssertEqual(version3.minor, 41)
		XCTAssertEqual(version3.patch, 40)
		XCTAssertEqual(version3.prereleaseIdentifiers, ["beta", "1337", "0"])
		XCTAssertEqual(version3.buildMetadataIdentifiers, [])
		
		let version4 = try SemanticVersion(2, 3, 5, prereleaseIdentifiers: [], buildMetadataIdentifiers: ["2022-02-22"])
		XCTAssertEqual(version4.major, 2)
		XCTAssertEqual(version4.minor, 3)
		XCTAssertEqual(version4.patch, 5)
		XCTAssertEqual(version4.prereleaseIdentifiers, [])
		XCTAssertEqual(version4.buildMetadataIdentifiers, ["2022-02-22"])
		
		let version5 = try SemanticVersion(7, 11, 13, prereleaseIdentifiers: ["alpha-1", "-42"], buildMetadataIdentifiers: ["010203", "md5-d41d8cd98f00b204e9800998ecf8427e"])
		XCTAssertEqual(version5.major, 7)
		XCTAssertEqual(version5.minor, 11)
		XCTAssertEqual(version5.patch, 13)
		XCTAssertEqual(version5.prereleaseIdentifiers, ["alpha-1", "-42"])
		XCTAssertEqual(version5.buildMetadataIdentifiers, ["010203", "md5-d41d8cd98f00b204e9800998ecf8427e"])
		
		//	MARK: default parameters
		
		let version6 = try SemanticVersion(0, 0, 0)
		XCTAssertEqual(version6.major, version1.major)
		XCTAssertEqual(version6.minor, version1.minor)
		XCTAssertEqual(version6.patch, version1.patch)
		XCTAssertEqual(version6.prereleaseIdentifiers, version1.prereleaseIdentifiers)
		XCTAssertEqual(version6.buildMetadataIdentifiers, version1.buildMetadataIdentifiers)
		
		let version7 = try SemanticVersion(1, 2, 3)
		XCTAssertEqual(version7.major, version2.major)
		XCTAssertEqual(version7.minor, version2.minor)
		XCTAssertEqual(version7.patch, version2.patch)
		XCTAssertEqual(version7.prereleaseIdentifiers, version2.prereleaseIdentifiers)
		XCTAssertEqual(version7.buildMetadataIdentifiers, version2.buildMetadataIdentifiers)
		
		let version8 = try SemanticVersion(42, 41, 40, prereleaseIdentifiers: ["beta", "1337", "0"])
		XCTAssertEqual(version8.major, version3.major)
		XCTAssertEqual(version8.minor, version3.minor)
		XCTAssertEqual(version8.patch, version3.patch)
		XCTAssertEqual(version8.prereleaseIdentifiers, version3.prereleaseIdentifiers)
		XCTAssertEqual(version8.buildMetadataIdentifiers, version3.buildMetadataIdentifiers)
		
		let version9 = try SemanticVersion(2, 3, 5, buildMetadataIdentifiers: ["2022-02-22"])
		XCTAssertEqual(version9.major, version4.major)
		XCTAssertEqual(version9.minor, version4.minor)
		XCTAssertEqual(version9.patch, version4.patch)
		XCTAssertEqual(version9.prereleaseIdentifiers, version4.prereleaseIdentifiers)
		XCTAssertEqual(version9.buildMetadataIdentifiers, version4.buildMetadataIdentifiers)
		
		//	MARK: invalid components
		
		XCTAssertThrowsError(try SemanticVersion(9, 8, 7, prereleaseIdentifiers: [""]))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(6, 5, 4, prereleaseIdentifiers: [" "]))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(3, 2, 1, prereleaseIdentifiers: ["+"]))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(0, 9, 8, prereleaseIdentifiers: ["..."]))  { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(7, 6, 5, prereleaseIdentifiers: ["a.b"]))  { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(4, 3, 2, prereleaseIdentifiers: [".c."]))  { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(1, 0, 9, prereleaseIdentifiers: ["测试版"])) { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(8, 7, 6, prereleaseIdentifiers: ["00"]))   { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(5, 4, 3, prereleaseIdentifiers: ["0123"])) { XCTAssertTrue($0 is SemanticVersionError) }
		
		XCTAssertThrowsError(try SemanticVersion(0, 1, 2, buildMetadataIdentifiers: [""]))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(3, 4, 5, buildMetadataIdentifiers: [" "]))   { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(6, 7, 8, buildMetadataIdentifiers: ["+"]))   { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(9, 0, 1, buildMetadataIdentifiers: ["..."])) { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(2, 3, 4, buildMetadataIdentifiers: ["a.b"])) { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(5, 6, 7, buildMetadataIdentifiers: [".c."])) { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(8, 9, 0, buildMetadataIdentifiers: ["🙃"])) { XCTAssertTrue($0 is SemanticVersionError) }
	}
	
	func testInitializationFromString() throws {
		
		//	MARK: equivalence with initialization from components
		
		let version0 = try SemanticVersion(versionString: "0.0.0")
		let version1 = try SemanticVersion(0, 0, 0)
		XCTAssertEqual(version0.major, version1.major)
		XCTAssertEqual(version0.minor, version1.minor)
		XCTAssertEqual(version0.patch, version1.patch)
		XCTAssertEqual(version0.prereleaseIdentifiers, version1.prereleaseIdentifiers)
		XCTAssertEqual(version0.buildMetadataIdentifiers, version1.buildMetadataIdentifiers)
		
		let version2 = try SemanticVersion(versionString: "3.2.1")
		let version3 = try SemanticVersion(3, 2, 1)
		XCTAssertEqual(version2.major, version3.major)
		XCTAssertEqual(version2.minor, version3.minor)
		XCTAssertEqual(version2.patch, version3.patch)
		XCTAssertEqual(version2.prereleaseIdentifiers, version3.prereleaseIdentifiers)
		XCTAssertEqual(version2.buildMetadataIdentifiers, version3.buildMetadataIdentifiers)
		
		let version4 = try SemanticVersion(versionString: "1.0.0-alpha-9.0.87")
		let version5 = try SemanticVersion(1, 0, 0, prereleaseIdentifiers: ["alpha-9", "0", "87"])
		XCTAssertEqual(version4.major, version5.major)
		XCTAssertEqual(version4.minor, version5.minor)
		XCTAssertEqual(version4.patch, version5.patch)
		XCTAssertEqual(version4.prereleaseIdentifiers, version5.prereleaseIdentifiers)
		XCTAssertEqual(version4.buildMetadataIdentifiers, version5.buildMetadataIdentifiers)
		
		let version6 = try SemanticVersion(versionString: "123.456.789+001.02.00")
		let version7 = try SemanticVersion(123, 456, 789, buildMetadataIdentifiers: ["001", "02", "00"])
		XCTAssertEqual(version6.major, version7.major)
		XCTAssertEqual(version6.minor, version7.minor)
		XCTAssertEqual(version6.patch, version7.patch)
		XCTAssertEqual(version6.prereleaseIdentifiers, version7.prereleaseIdentifiers)
		XCTAssertEqual(version6.buildMetadataIdentifiers, version7.buildMetadataIdentifiers)
		
		let version8 = try SemanticVersion(versionString: "987.654.321-01beta.-0+1a-2b-3c-4d")
		let version9 = try SemanticVersion(987, 654, 321, prereleaseIdentifiers: ["01beta", "-0"], buildMetadataIdentifiers: ["1a-2b-3c-4d"])
		XCTAssertEqual(version8.major, version9.major)
		XCTAssertEqual(version8.minor, version9.minor)
		XCTAssertEqual(version8.patch, version9.patch)
		XCTAssertEqual(version8.prereleaseIdentifiers, version9.prereleaseIdentifiers)
		XCTAssertEqual(version8.buildMetadataIdentifiers, version9.buildMetadataIdentifiers)
		
		//	MARK: invalid version strings
		
		XCTAssertThrowsError(try SemanticVersion(versionString: ""))           { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: " "))          { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "."))          { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "-"))          { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "+"))          { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "..-+"))       { XCTAssertTrue($0 is SemanticVersionError) }
		
		XCTAssertThrowsError(try SemanticVersion(versionString: "1"))          { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.2"))        { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.2."))       { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: ".2.3"))       { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.2.3.4"))    { XCTAssertTrue($0 is SemanticVersionError) }
		
		XCTAssertThrowsError(try SemanticVersion(versionString: "a.b.c"))      { XCTAssertTrue($0 is SemanticVersionError) }
		
		XCTAssertThrowsError(try SemanticVersion(versionString: "00.0.0"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "0.00.0"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "0.0.00"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "01.2.3"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.02.3"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.2.03"))     { XCTAssertTrue($0 is SemanticVersionError) }
		
		XCTAssertThrowsError(try SemanticVersion(versionString: "-0.0.0"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "0.-0.0"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "0.0.-0"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "-1.2.3"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.-2.3"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.2.-3"))     { XCTAssertTrue($0 is SemanticVersionError) }
		
		XCTAssertThrowsError(try SemanticVersion(versionString: "1.2.3-"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "2.3.4- "))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "3.4.5-+"))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "4.5.6-."))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "5.6.7-.a."))  { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "6.7.8-æ"))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "7.8.9-00"))   { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "8.9.0-0321")) { XCTAssertTrue($0 is SemanticVersionError) }
		
		XCTAssertThrowsError(try SemanticVersion(versionString: "3.2.1+"))     { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "4.3.2+ "))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "5.4.3++"))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "6.5.4+."))    { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "7.6.5+.b."))  { XCTAssertTrue($0 is SemanticVersionError) }
		XCTAssertThrowsError(try SemanticVersion(versionString: "8.7.6+æ"))    { XCTAssertTrue($0 is SemanticVersionError) }
	}
}
