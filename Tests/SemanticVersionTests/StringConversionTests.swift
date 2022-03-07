import XCTest
@testable import SemanticVersion

final class StringConversionTests: XCTestCase {
	func testCustomConversionToString() throws {
		
		//	MARK: .description
		
		XCTAssertEqual(try SemanticVersion(0, 0, 0).description, "0.0.0")
		XCTAssertEqual(try SemanticVersion(1, 2, 3).description, "1.2.3")
		
		XCTAssertEqual(try SemanticVersion(2, 3, 4, prereleaseIdentifiers: [])            .description, "2.3.4")
		XCTAssertEqual(try SemanticVersion(3, 4, 5, prereleaseIdentifiers: ["alpha-01"])  .description, "3.4.5-alpha-01")
		XCTAssertEqual(try SemanticVersion(4, 5, 6, prereleaseIdentifiers: ["beta", "42"]).description, "4.5.6-beta.42")
		
		XCTAssertEqual(try SemanticVersion(5, 6, 7, buildMetadataIdentifiers: [])            .description, "5.6.7")
		XCTAssertEqual(try SemanticVersion(6, 7, 8, buildMetadataIdentifiers: ["000"])       .description, "6.7.8+000")
		XCTAssertEqual(try SemanticVersion(7, 8, 9, buildMetadataIdentifiers: ["2020-02-02"]).description, "7.8.9+2020-02-02")
		XCTAssertEqual(try SemanticVersion(8, 9, 0, buildMetadataIdentifiers: ["f0o", "bar"]).description, "8.9.0+f0o.bar")
		
		XCTAssertEqual(
			try SemanticVersion(9, 8, 7, prereleaseIdentifiers: [], buildMetadataIdentifiers: []).description,
			"9.8.7"
		)
		XCTAssertEqual(
			try SemanticVersion(6, 5, 4, prereleaseIdentifiers: ["--", "---"], buildMetadataIdentifiers: []).description,
			"6.5.4---.---"
		)
		XCTAssertEqual(
			try SemanticVersion(3, 2, 1, prereleaseIdentifiers: [], buildMetadataIdentifiers: ["--", "---"]).description,
			"3.2.1+--.---"
		)
		XCTAssertEqual(
			try SemanticVersion(0, 9, 8, prereleaseIdentifiers: ["pre", "release", "42"], buildMetadataIdentifiers: ["build", "metadata"]).description,
			"0.9.8-pre.release.42+build.metadata"
		)
		
		//	MARK: string interpolation
		
		XCTAssertEqual("\(try SemanticVersion(0, 0, 0))", "0.0.0")
		XCTAssertEqual("\(try SemanticVersion(1, 2, 3))", "1.2.3")
		
		XCTAssertEqual("\(try SemanticVersion(2, 3, 4, prereleaseIdentifiers: []))"            , "2.3.4")
		XCTAssertEqual("\(try SemanticVersion(3, 4, 5, prereleaseIdentifiers: ["alpha-01"]))"  , "3.4.5-alpha-01")
		XCTAssertEqual("\(try SemanticVersion(4, 5, 6, prereleaseIdentifiers: ["beta", "42"]))", "4.5.6-beta.42")
		
		XCTAssertEqual("\(try SemanticVersion(5, 6, 7, buildMetadataIdentifiers: []))"            , "5.6.7")
		XCTAssertEqual("\(try SemanticVersion(6, 7, 8, buildMetadataIdentifiers: ["000"]))"       , "6.7.8+000")
		XCTAssertEqual("\(try SemanticVersion(7, 8, 9, buildMetadataIdentifiers: ["2020-02-02"]))", "7.8.9+2020-02-02")
		XCTAssertEqual("\(try SemanticVersion(8, 9, 0, buildMetadataIdentifiers: ["f0o", "bar"]))", "8.9.0+f0o.bar")
		
		XCTAssertEqual(
			"\(try SemanticVersion(9, 8, 7, prereleaseIdentifiers: [], buildMetadataIdentifiers: []))",
			"9.8.7"
		)
		XCTAssertEqual(
			"\(try SemanticVersion(6, 5, 4, prereleaseIdentifiers: ["--", "---"], buildMetadataIdentifiers: []))",
			"6.5.4---.---"
		)
		XCTAssertEqual(
			"\(try SemanticVersion(3, 2, 1, prereleaseIdentifiers: [], buildMetadataIdentifiers: ["--", "---"]))",
			"3.2.1+--.---"
		)
		XCTAssertEqual(
			"\(try SemanticVersion(0, 9, 8, prereleaseIdentifiers: ["pre", "release", "42"], buildMetadataIdentifiers: ["build", "metadata"]))",
			"0.9.8-pre.release.42+build.metadata"
		)
	}
	
	func testLosslessConversionFromString() throws {
		
		//	MARK: valid version strings
		
		XCTAssertEqual(SemanticVersion("0.0.0" as String),        try SemanticVersion(0, 0, 0))
		XCTAssertEqual(SemanticVersion("1.2.3" as String),        try SemanticVersion(1, 2, 3))
		XCTAssertEqual(SemanticVersion("4.5.6-abc" as String),    try SemanticVersion(4, 5, 6, prereleaseIdentifiers: ["abc"]))
		XCTAssertEqual(SemanticVersion("7.8.9-123" as String),    try SemanticVersion(7, 8, 9, prereleaseIdentifiers: ["123"]))
		XCTAssertEqual(SemanticVersion("0.1.2-1a2b3c" as String), try SemanticVersion(0, 1, 2, prereleaseIdentifiers: ["1a2b3c"]))
		XCTAssertEqual(SemanticVersion("3.4.5-abc-12" as String), try SemanticVersion(3, 4, 5, prereleaseIdentifiers: ["abc-12"]))
		XCTAssertEqual(SemanticVersion("6.7.8---.123" as String), try SemanticVersion(6, 7, 8, prereleaseIdentifiers: ["--", "123"]))
		XCTAssertEqual(SemanticVersion("9.0.1+xyz" as String),    try SemanticVersion(9, 0, 1, buildMetadataIdentifiers: ["xyz"]))
		XCTAssertEqual(SemanticVersion("2.3.4+000" as String),    try SemanticVersion(2, 3, 4, buildMetadataIdentifiers: ["000"]))
		XCTAssertEqual(SemanticVersion("5.6.7+012---" as String), try SemanticVersion(5, 6, 7, buildMetadataIdentifiers: ["012---"]))
		XCTAssertEqual(SemanticVersion("8.9.0-ab+012" as String), try SemanticVersion(8, 9, 0, prereleaseIdentifiers: ["ab"], buildMetadataIdentifiers: ["012"]))
		
		//	MARK: invalid version strings
		
		XCTAssertNil(SemanticVersion("" as String))
		XCTAssertNil(SemanticVersion(" " as String))
		XCTAssertNil(SemanticVersion("." as String))
		XCTAssertNil(SemanticVersion("-" as String))
		XCTAssertNil(SemanticVersion("+" as String))
		XCTAssertNil(SemanticVersion("..-+" as String))
		
		XCTAssertNil(SemanticVersion("1" as String))
		XCTAssertNil(SemanticVersion("1.2" as String))
		XCTAssertNil(SemanticVersion("1.2." as String))
		XCTAssertNil(SemanticVersion(".2.3" as String))
		XCTAssertNil(SemanticVersion("1.2.3.4" as String))
		
		XCTAssertNil(SemanticVersion("a.b.c" as String))
		
		XCTAssertNil(SemanticVersion("00.0.0" as String))
		XCTAssertNil(SemanticVersion("0.00.0" as String))
		XCTAssertNil(SemanticVersion("0.0.00" as String))
		XCTAssertNil(SemanticVersion("01.2.3" as String))
		XCTAssertNil(SemanticVersion("1.02.3" as String))
		XCTAssertNil(SemanticVersion("1.2.03" as String))
		
		XCTAssertNil(SemanticVersion("-0.0.0" as String))
		XCTAssertNil(SemanticVersion("0.-0.0" as String))
		XCTAssertNil(SemanticVersion("0.0.-0" as String))
		XCTAssertNil(SemanticVersion("-1.2.3" as String))
		XCTAssertNil(SemanticVersion("1.-2.3" as String))
		XCTAssertNil(SemanticVersion("1.2.-3" as String))
		XCTAssertNil(SemanticVersion("1.2.3-" as String))
		
		XCTAssertNil(SemanticVersion("2.3.4- " as String))
		XCTAssertNil(SemanticVersion("3.4.5-+" as String))
		XCTAssertNil(SemanticVersion("4.5.6-." as String))
		XCTAssertNil(SemanticVersion("5.6.7-.a." as String))
		XCTAssertNil(SemanticVersion("6.7.8-æ" as String))
		XCTAssertNil(SemanticVersion("7.8.9-00" as String))
		XCTAssertNil(SemanticVersion("8.9.0-0321" as String))
		
		XCTAssertNil(SemanticVersion("3.2.1+" as String))
		XCTAssertNil(SemanticVersion("4.3.2+ " as String))
		XCTAssertNil(SemanticVersion("5.4.3++" as String))
		XCTAssertNil(SemanticVersion("6.5.4+." as String))
		XCTAssertNil(SemanticVersion("7.6.5+.b." as String))
		XCTAssertNil(SemanticVersion("8.7.6+æ" as String))
	}
	
	func testExpressingByStringLiteral() throws {
		XCTAssertEqual("0.0.0"        as SemanticVersion, try SemanticVersion(0, 0, 0))
		XCTAssertEqual("1.2.3"        as SemanticVersion, try SemanticVersion(1, 2, 3))
		XCTAssertEqual("4.5.6-abc"    as SemanticVersion, try SemanticVersion(4, 5, 6, prereleaseIdentifiers: ["abc"]))
		XCTAssertEqual("7.8.9-123"    as SemanticVersion, try SemanticVersion(7, 8, 9, prereleaseIdentifiers: ["123"]))
		XCTAssertEqual("0.1.2-1a2b3c" as SemanticVersion, try SemanticVersion(0, 1, 2, prereleaseIdentifiers: ["1a2b3c"]))
		XCTAssertEqual("3.4.5-abc-12" as SemanticVersion, try SemanticVersion(3, 4, 5, prereleaseIdentifiers: ["abc-12"]))
		XCTAssertEqual("6.7.8---.123" as SemanticVersion, try SemanticVersion(6, 7, 8, prereleaseIdentifiers: ["--", "123"]))
		XCTAssertEqual("9.0.1+xyz"    as SemanticVersion, try SemanticVersion(9, 0, 1, buildMetadataIdentifiers: ["xyz"]))
		XCTAssertEqual("2.3.4+000"    as SemanticVersion, try SemanticVersion(2, 3, 4, buildMetadataIdentifiers: ["000"]))
		XCTAssertEqual("5.6.7+012---" as SemanticVersion, try SemanticVersion(5, 6, 7, buildMetadataIdentifiers: ["012---"]))
		XCTAssertEqual("8.9.0-ab+012" as SemanticVersion, try SemanticVersion(8, 9, 0, prereleaseIdentifiers: ["ab"], buildMetadataIdentifiers: ["012"]))
	}
	
	func testExpressingByStringInterpolation() throws {
		XCTAssertEqual("\("0.")0.0"                      as SemanticVersion, try SemanticVersion(0, 0, 0))
		XCTAssertEqual("1.\(2).3"                        as SemanticVersion, try SemanticVersion(1, 2, 3))
		XCTAssertEqual("4.5\(".6-a")bc"                  as SemanticVersion, try SemanticVersion(4, 5, 6, prereleaseIdentifiers: ["abc"]))
		XCTAssertEqual("7.8.9-\(123)"                    as SemanticVersion, try SemanticVersion(7, 8, 9, prereleaseIdentifiers: ["123"]))
		XCTAssertEqual("\(0).\("1").2-1a2b3c"            as SemanticVersion, try SemanticVersion(0, 1, 2, prereleaseIdentifiers: ["1a2b3c"]))
		XCTAssertEqual("\("3.")4.\(5)-abc-12"            as SemanticVersion, try SemanticVersion(3, 4, 5, prereleaseIdentifiers: ["abc-12"]))
		XCTAssertEqual("\("6.7").8-\("--").123"          as SemanticVersion, try SemanticVersion(6, 7, 8, prereleaseIdentifiers: ["--", "123"]))
		XCTAssertEqual("9.\(0).\(1)+xyz"                 as SemanticVersion, try SemanticVersion(9, 0, 1, buildMetadataIdentifiers: ["xyz"]))
		XCTAssertEqual("2.\(3).4+\("000")"               as SemanticVersion, try SemanticVersion(2, 3, 4, buildMetadataIdentifiers: ["000"]))
		XCTAssertEqual("\("5.6.\(7)+\("012---")")"       as SemanticVersion, try SemanticVersion(5, 6, 7, buildMetadataIdentifiers: ["012---"]))
		XCTAssertEqual("\(8).\(9).\(0)-\("ab")+\("012")" as SemanticVersion, try SemanticVersion(8, 9, 0, prereleaseIdentifiers: ["ab"], buildMetadataIdentifiers: ["012"]))
	}
}
