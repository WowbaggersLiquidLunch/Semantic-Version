import XCTest
@testable import SemanticVersion

final class ErrorTests: XCTestCase {
	func testEmptyIdentifiers() {
		//	MARK: major version number
		
		assertThrowingEmptyIdentifierError(atPosition: .major, whenEvaluating: try SemanticVersion(versionString: ".2.3"))
		assertThrowingEmptyIdentifierError(atPosition: .major, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".5.6""#.utf8)))
		
		//	MARK: minor version number
		
		assertThrowingEmptyIdentifierError(atPosition: .minor, whenEvaluating: try SemanticVersion(versionString: "2..5"))
		assertThrowingEmptyIdentifierError(atPosition: .minor, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7..13""#.utf8)))
		
		//	MARK: patch version number
		
		assertThrowingEmptyIdentifierError(atPosition: .patch, whenEvaluating: try SemanticVersion(versionString: "1.1."))
		assertThrowingEmptyIdentifierError(atPosition: .patch, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3.5.""#.utf8)))
		
		//	MARK: pre-release
		
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(0, 1, 2, prereleaseIdentifiers: [""]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(1, 2, 3, prereleaseIdentifiers: ["", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(2, 3, 4, prereleaseIdentifiers: ["alpha", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(3, 4, 5, prereleaseIdentifiers: ["", "beta"]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(4, 5, 6, prereleaseIdentifiers: ["123", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(5, 6, 7, prereleaseIdentifiers: ["", "456"]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(6, 7, 8, prereleaseIdentifiers: ["y2k", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(7, 8, 9, prereleaseIdentifiers: ["", "mp3"]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "0.2.4-"))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "1.3.5-."))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "2.4.6-pre."))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "3.5.7-.release"))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "4.6.8-42."))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "5.7.9-.1337"))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "6.8.0-disco2000."))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "7.9.1-.mp4"))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.7.5-""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8.6.4-.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.5.3-gold.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.4.2-.master""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.3.1-0.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4.2.0-.1""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3.1.9-2001odyssey.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.0.8-.av1""#.utf8)))
		
		//	MARK: build metadata
		
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(0, 1, 2, buildMetadataIdentifiers: [""]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(1, 2, 3, buildMetadataIdentifiers: ["", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(2, 3, 4, buildMetadataIdentifiers: ["alpha", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(3, 4, 5, buildMetadataIdentifiers: ["", "beta"]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(4, 5, 6, buildMetadataIdentifiers: ["123", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(5, 6, 7, buildMetadataIdentifiers: ["", "456"]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(6, 7, 8, buildMetadataIdentifiers: ["y2k", ""]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(7, 8, 9, buildMetadataIdentifiers: ["", "mp3"]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "0.2.4+"))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "1.3.5+."))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "2.4.6+pre."))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "3.5.7+.release"))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "4.6.8+42."))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "5.7.9+.1337"))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "6.8.0+disco2000."))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "7.9.1+.mp4"))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.7.5+""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8.6.4+.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.5.3+gold.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.4.2+.master""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.3.1+0.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4.2.0+.1""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3.1.9+2001odyssey.""#.utf8)))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.0.8+.av1""#.utf8)))
	}
	
	func testEmptyIdentifierDiagnosticPrecedence() {
		assertThrowingEmptyIdentifierError(atPosition: .major, whenEvaluating: try SemanticVersion(versionString: "..-+"))
		assertThrowingEmptyIdentifierError(atPosition: .major, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""..-+""#.utf8)))
		
		assertThrowingEmptyIdentifierError(atPosition: .minor, whenEvaluating: try SemanticVersion(versionString: "1..-+"))
		assertThrowingEmptyIdentifierError(atPosition: .minor, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1..-+""#.utf8)))
		
		assertThrowingEmptyIdentifierError(atPosition: .patch, whenEvaluating: try SemanticVersion(versionString: "1.2.-+"))
		assertThrowingEmptyIdentifierError(atPosition: .patch, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1.2.-+""#.utf8)))
		
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(1, 2, 3, prereleaseIdentifiers: [""], buildMetadataIdentifiers: [""]))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try SemanticVersion(versionString: "1.2.3-+"))
		assertThrowingEmptyIdentifierError(atPosition: .prerelease, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1.2.3-+""#.utf8)))
		
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(1, 2, 3, prereleaseIdentifiers: ["4"], buildMetadataIdentifiers: [""]))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try SemanticVersion(versionString: "1.2.3-4+"))
		assertThrowingEmptyIdentifierError(atPosition: .buildMetadata, whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1.2.3-4+""#.utf8)))
	}
	
	func testNonAlphanumericCharacters() {
		//	MARK: major version number
		
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "😀", whenEvaluating: try SemanticVersion(versionString: "😀.2.3"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "😃1", whenEvaluating: try SemanticVersion(versionString: "😃1.2.3"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "1😄", whenEvaluating: try SemanticVersion(versionString: "1😄.2.3"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "1😁2", whenEvaluating: try SemanticVersion(versionString: "1😁2.3.4"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "😆", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""😆.5.6""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "🥹4", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""🥹4.5.6""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "4😅", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4😅.5.6""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "4😂5", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4😂5.6.7""#.utf8)))

		//	MARK: minor version number
		
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "🤣", whenEvaluating: try SemanticVersion(versionString: "7.🤣.9"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "🥲8", whenEvaluating: try SemanticVersion(versionString: "7.🥲8.9"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "8☺️", whenEvaluating: try SemanticVersion(versionString: "7.8☺️.9"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "8😊9", whenEvaluating: try SemanticVersion(versionString: "7.8😊9.0"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "😇", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.😇.2""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "🙂1", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.🙂1.2""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "1🙃", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.1🙃.2""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "1😉2", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.1😉2.3""#.utf8)))

		//	MARK: patch version number
		
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "😌", whenEvaluating: try SemanticVersion(versionString: "3.4.😌"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "😍5", whenEvaluating: try SemanticVersion(versionString: "3.4.😍5"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "5🥰", whenEvaluating: try SemanticVersion(versionString: "3.4.5🥰"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "5😘6", whenEvaluating: try SemanticVersion(versionString: "3.4.5😘6"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "😗", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.😗""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "😙8", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.😙8""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "8😚", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.8😚""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "8😋9", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.8😋9""#.utf8)))

		//	MARK: pre-release
		
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "😛", whenEvaluating: try SemanticVersion(9, 8, 7, prereleaseIdentifiers: ["😛"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "😝alpha", whenEvaluating: try SemanticVersion(6, 5, 4, prereleaseIdentifiers: ["😝alpha", "beta"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "beta😜", whenEvaluating: try SemanticVersion(3, 2, 1, prereleaseIdentifiers: ["alpha", "beta😜"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "pre🤪release", whenEvaluating: try SemanticVersion(0, 9, 8, prereleaseIdentifiers: ["pre🤪release", "un🤨stable"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "🧐", whenEvaluating: try SemanticVersion(versionString: "7.6.5-🧐"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "🤓gold", whenEvaluating: try SemanticVersion(versionString: "4.3.2-🤓gold.master"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "master😎", whenEvaluating: try SemanticVersion(versionString: "1.0.9-gold.master😎"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "le🥸et", whenEvaluating: try SemanticVersion(versionString: "8.7.6-le🥸et.13🤩37"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "🥳", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.4.3-🥳""#.utf8)))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "😏123", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.1.0-😏123.456""#.utf8)))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "456😒", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1.2.3-123.456😒""#.utf8)))
		assertThrowingNonAlphanumericCharacterError(atPosition: .prerelease, inIdentifier: "13😞37", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4.5.6-13😞37.le😔et""#.utf8)))
		
		//	MARK: build metadata
		
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "😟", whenEvaluating: try SemanticVersion(7, 8, 9, buildMetadataIdentifiers: ["😟"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "😕abcd", whenEvaluating: try SemanticVersion(0, 1, 2, buildMetadataIdentifiers: ["😕abcd", "efgh"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "mnop🙁", whenEvaluating: try SemanticVersion(3, 4, 5, buildMetadataIdentifiers: ["ijkl", "mnop🙁"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "qr☹️st", whenEvaluating: try SemanticVersion(6, 7, 8, buildMetadataIdentifiers: ["qr☹️st", "uv😣wx"]))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "😖", whenEvaluating: try SemanticVersion(versionString: "9.0.1+😖"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "😫1234", whenEvaluating: try SemanticVersion(versionString: "2.3.4+😫1234.5678"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "3456😩", whenEvaluating: try SemanticVersion(versionString: "5.6.7+9012.3456😩"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "78🥺90", whenEvaluating: try SemanticVersion(versionString: "8.9.0+78🥺90.12😢34"))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "😭", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.8.7+😭""#.utf8)))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "😤1a2", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.5.4+😤1a2.b3c""#.utf8)))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "e6f😠", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3.2.1+4d5.e6f😠""#.utf8)))
		assertThrowingNonAlphanumericCharacterError(atPosition: .buildMetadata, inIdentifier: "7g8😡h9i", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.9.8+7g8😡h9i.10j🤬11k""#.utf8)))
	}
	
	func testNonNumericCharacters() {
		//	MARK: major version number
		
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "a", whenEvaluating: try SemanticVersion(versionString: "a.2.3"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "b1", whenEvaluating: try SemanticVersion(versionString: "b1.2.3"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "1c", whenEvaluating: try SemanticVersion(versionString: "1c.2.3"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "1d2", whenEvaluating: try SemanticVersion(versionString: "1d2.3.4"))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "e", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""e.5.6""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "f4", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""f4.5.6""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "4g", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4g.5.6""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .major, inIdentifier: "4h5", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4h5.6.7""#.utf8)))
		
		//	MARK: minor version number
		
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "i", whenEvaluating: try SemanticVersion(versionString: "7.i.9"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "j8", whenEvaluating: try SemanticVersion(versionString: "7.j8.9"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "8k", whenEvaluating: try SemanticVersion(versionString: "7.8k.9"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "8l9", whenEvaluating: try SemanticVersion(versionString: "7.8l9.0"))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "m", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.m.2""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "n1", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.n1.2""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "1o", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.1o.2""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .minor, inIdentifier: "1p2", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.1p2.3""#.utf8)))
		
		//	MARK: patch version number
		
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "q", whenEvaluating: try SemanticVersion(versionString: "3.4.q"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "r5", whenEvaluating: try SemanticVersion(versionString: "3.4.r5"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "5s", whenEvaluating: try SemanticVersion(versionString: "3.4.5s"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "5t6", whenEvaluating: try SemanticVersion(versionString: "3.4.5t6"))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "u", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.u""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "v8", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.v8""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "8w", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.8w""#.utf8)))
		assertThrowingNonNumericCharacterError(atPosition: .patch, inIdentifier: "8x9", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.8x9""#.utf8)))
		
		//	MARK: pre-release
		
		XCTAssertNoThrow(try SemanticVersion(9, 8, 7, prereleaseIdentifiers: ["abc123"]))
		XCTAssertNoThrow(try SemanticVersion(6, 5, 4, prereleaseIdentifiers: ["456def"]))
		XCTAssertNoThrow(try SemanticVersion(3, 2, 1, prereleaseIdentifiers: ["7g8h9i"]))
		XCTAssertNoThrow(try SemanticVersion(versionString: "0.9.8-jkl012"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "7.6.5-345mno"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "4.3.2-p6q7r8"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1.0.9-stu901""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8.7.6-234vwx""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.4.3-5y6z7a""#.utf8)))
		
		//	MARK: build metadata
		
		XCTAssertNoThrow(try SemanticVersion(2, 1, 0, buildMetadataIdentifiers: ["bcd890"]))
		XCTAssertNoThrow(try SemanticVersion(9, 8, 7, buildMetadataIdentifiers: ["123efg"]))
		XCTAssertNoThrow(try SemanticVersion(6, 5, 4, buildMetadataIdentifiers: ["h4i5j6"]))
		XCTAssertNoThrow(try SemanticVersion(versionString: "3.2.1+klm789"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "0.9.8+012nop"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "7.6.5+3q4r5s"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4.3.2+tuv678""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1.0.9+901wxy""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8.7.6+z2a3b4""#.utf8)))
	}
	
	func testLeadingZeros() {
		//	MARK: major version number
		
		assertThrowingLeadingZerosError(atPosition: .major, inIdentifier: "0123", whenEvaluating: try SemanticVersion(versionString: "0123.4.5"))
		assertThrowingLeadingZerosError(atPosition: .major, inIdentifier: "0012", whenEvaluating: try SemanticVersion(versionString: "0012.3.4"))
		assertThrowingLeadingZerosError(atPosition: .major, inIdentifier: "0000", whenEvaluating: try SemanticVersion(versionString: "0000.1.2"))
		assertThrowingLeadingZerosError(atPosition: .major, inIdentifier: "0456", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0456.7.8""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .major, inIdentifier: "0045", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0045.6.7""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .major, inIdentifier: "0000", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0000.4.5""#.utf8)))
		
		XCTAssertNoThrow(try SemanticVersion(versionString: "0.1.2"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.3.4""#.utf8)))
		
		//	MARK: minor version number
		
		assertThrowingLeadingZerosError(atPosition: .minor, inIdentifier: "0876", whenEvaluating: try SemanticVersion(versionString: "9.0876.5"))
		assertThrowingLeadingZerosError(atPosition: .minor, inIdentifier: "0087", whenEvaluating: try SemanticVersion(versionString: "9.0087.6"))
		assertThrowingLeadingZerosError(atPosition: .minor, inIdentifier: "0000", whenEvaluating: try SemanticVersion(versionString: "9.0000.8"))
		assertThrowingLeadingZerosError(atPosition: .minor, inIdentifier: "0432", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.0432.1""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .minor, inIdentifier: "0043", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.0043.2""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .minor, inIdentifier: "0000", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.0000.4""#.utf8)))
		
		XCTAssertNoThrow(try SemanticVersion(versionString: "5.0.6"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.0.8""#.utf8)))
		
		//	MARK: patch version number
		
		assertThrowingLeadingZerosError(atPosition: .patch, inIdentifier: "0345", whenEvaluating: try SemanticVersion(versionString: "1.2.0345"))
		assertThrowingLeadingZerosError(atPosition: .patch, inIdentifier: "0034", whenEvaluating: try SemanticVersion(versionString: "1.2.0034"))
		assertThrowingLeadingZerosError(atPosition: .patch, inIdentifier: "0000", whenEvaluating: try SemanticVersion(versionString: "1.2.0000"))
		assertThrowingLeadingZerosError(atPosition: .patch, inIdentifier: "0789", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.6.0789""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .patch, inIdentifier: "0078", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.6.0078""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .patch, inIdentifier: "0000", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.6.0000""#.utf8)))
		
		XCTAssertNoThrow(try SemanticVersion(versionString: "9.1.0"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.3.0""#.utf8)))
		
		//	MARK: pre-release
		
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0246", whenEvaluating: try SemanticVersion(1, 3, 5, prereleaseIdentifiers: ["0246"]))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0068", whenEvaluating: try SemanticVersion(3, 5, 7, prereleaseIdentifiers: ["0068"]))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0000", whenEvaluating: try SemanticVersion(5, 7, 9, prereleaseIdentifiers: ["0000"]))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0456", whenEvaluating: try SemanticVersion(versionString: "1.2.3-0456"))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0045", whenEvaluating: try SemanticVersion(versionString: "1.2.3-0045"))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0000", whenEvaluating: try SemanticVersion(versionString: "1.2.3-0000"))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0654", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.8.7-0654""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0065", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.8.7-0065""#.utf8)))
		assertThrowingLeadingZerosError(atPosition: .prerelease, inIdentifier: "0000", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.8.7-0000""#.utf8)))
		
		XCTAssertNoThrow(try SemanticVersion(2, 3, 4, prereleaseIdentifiers: ["0"]))
		XCTAssertNoThrow(try SemanticVersion(versionString: "5.6.7-0"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8.9.1-0""#.utf8)))
		
		//	MARK: build metadata
		XCTAssertNoThrow(try SemanticVersion(2, 3, 4, buildMetadataIdentifiers: ["0567"]))
		XCTAssertNoThrow(try SemanticVersion(8, 9, 1, buildMetadataIdentifiers: ["0023"]))
		XCTAssertNoThrow(try SemanticVersion(4, 5, 6, buildMetadataIdentifiers: ["0000"]))
		XCTAssertNoThrow(try SemanticVersion(7, 8, 9, buildMetadataIdentifiers: ["0"]))
		XCTAssertNoThrow(try SemanticVersion(versionString: "1.2.3+0456"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "7.8.9+0012"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "3.4.5+0000"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "6.7.8+0"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.1.2+0345""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.7.8+0091""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.3.4+0000""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.6.7+0""#.utf8)))
	}
	
	func testOversizedNumericValues() {
		func sum(_ summand1: String, _ summand2: String) -> Substring {
			let paddedSummandLength = max(summand1.count, summand2.count) + 1
			let paddedSummand1 = zeroPadded(summand1, toLength: paddedSummandLength)
			let paddedSummand2 = zeroPadded(summand2, toLength: paddedSummandLength)
			
			var result: [Character] = []
			result.reserveCapacity(paddedSummandLength)
			
			var carry: Int8 = 0
			
			for (digit1, digit2) in zip(paddedSummand1.reversed(), paddedSummand2.reversed()) {
				let digit1 = Int8(String(digit1))!
				let digit2 = Int8(String(digit2))!
				let columnSum = digit1 + digit2 + carry
				carry = columnSum > 9 ? 1 : 0
				result.append(String(columnSum).last!)
			}
			
			return Substring(result[...result.lastIndex(where: { $0 != "0" })!].reversed())
			
			func zeroPadded(_ number: String, toLength paddedLength: Int) -> [Character] {
				let paddingLength = paddedLength - number.count
				var paddedNumber = [Character](repeating: "0", count: paddingLength)
				paddedNumber.reserveCapacity(paddedLength)
				paddedNumber.append(contentsOf: number)
				return paddedNumber
			}
		}
		
		//	MARK: infrastructure sanity check
		
		XCTAssertEqual(sum("123", "456"), "579")
		XCTAssertEqual(sum("999", "999"), "1998")
		XCTAssertEqual(sum("4545", "4545"), "9090")
		XCTAssertEqual(sum("123456789", "98765"), "123555554")
		XCTAssertEqual(sum("111111111111111111111111111111", "111111111111111111111111111111"), "222222222222222222222222222222")	//	30 digits in each
		XCTAssertEqual(sum("111111111111111111111111111111", "000000000011111111112222222222"), "111111111122222222223333333333")
		XCTAssertEqual(sum("999999999999999999999999999999", "999999999999999999999999999999"), "1999999999999999999999999999998")	//	30 digits in each
		XCTAssertEqual(sum("\(UInt64.max)", "1"), "18446744073709551616")
		XCTAssertEqual(sum("\(UInt64.max)", "\(Int32.max)"), "18446744075857035262")
		XCTAssertEqual(sum("\(UInt64.max)", "\(UInt64.max)"), "36893488147419103230")
		
		//	MARK: major version number
		
		assertThrowingOversizedValueError(atPosition: .major, inIdentifier: sum("\(UInt.max)", "1"),   whenEvaluating: try SemanticVersion(versionString: "\(sum("\(UInt.max)", "1")).1.2"))
		assertThrowingOversizedValueError(atPosition: .major, inIdentifier: "3\(UInt.max)",            whenEvaluating: try SemanticVersion(versionString: "3\(UInt.max).4.5"))
		assertThrowingOversizedValueError(atPosition: .major, inIdentifier: "\(UInt.max)\(Int8.max)",  whenEvaluating: try SemanticVersion(versionString: "\(UInt.max)\(Int8.max).6.7"))
		assertThrowingOversizedValueError(atPosition: .major, inIdentifier: sum("\(UInt.max)", "1"),   whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""\#(sum("\(UInt.max)", "1")).8.9""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .major, inIdentifier: "1\(UInt.max)",            whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1\#(UInt.max).2.3""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .major, inIdentifier: "\(UInt.max)\(Int16.max)", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""\#(UInt.max)\#(Int16.max).4.5""#.utf8)))
		
		XCTAssertNoThrow(try SemanticVersion(versionString: "\(UInt.max).6.7"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""\#(UInt.max).8.9""#.utf8)))
		
		//	MARK: minor version number
		
		assertThrowingOversizedValueError(atPosition: .minor, inIdentifier: sum("\(UInt.max)", "1"),   whenEvaluating: try SemanticVersion(versionString: "9.\(sum("\(UInt.max)", "1")).8"))
		assertThrowingOversizedValueError(atPosition: .minor, inIdentifier: "6\(UInt.max)",            whenEvaluating: try SemanticVersion(versionString: "7.6\(UInt.max).5"))
		assertThrowingOversizedValueError(atPosition: .minor, inIdentifier: "\(UInt.max)\(Int32.max)", whenEvaluating: try SemanticVersion(versionString: "4.\(UInt.max)\(Int32.max).3"))
		assertThrowingOversizedValueError(atPosition: .minor, inIdentifier: sum("\(UInt.max)", "1"),   whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.\#(sum("\(UInt.max)", "1")).1""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .minor, inIdentifier: "9\(UInt.max)",            whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.9\#(UInt.max).8""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .minor, inIdentifier: "\(UInt.max)\(Int64.max)", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.\#(UInt.max)\#(Int64.max).6""#.utf8)))
		
		XCTAssertNoThrow(try SemanticVersion(versionString: "5.\(UInt.max).4"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3.\#(UInt.max).2""#.utf8)))
		
		//	MARK: patch version number
		
		assertThrowingOversizedValueError(atPosition: .patch, inIdentifier: sum("\(UInt.max)", "1"),    whenEvaluating: try SemanticVersion(versionString: "3.2.\(sum("\(UInt.max)", "1"))"))
		assertThrowingOversizedValueError(atPosition: .patch, inIdentifier: "4\(UInt.max)",             whenEvaluating: try SemanticVersion(versionString: "6.5.4\(UInt.max)"))
		assertThrowingOversizedValueError(atPosition: .patch, inIdentifier: "\(UInt.max)\(UInt8.max)",  whenEvaluating: try SemanticVersion(versionString: "8.7.\(UInt.max)\(UInt8.max)"))
		assertThrowingOversizedValueError(atPosition: .patch, inIdentifier: sum("\(UInt.max)", "1"),    whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8.9.\#(sum("\(UInt.max)", "1"))""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .patch, inIdentifier: "7\(UInt.max)",             whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.6.7\#(UInt.max)""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .patch, inIdentifier: "\(UInt.max)\(UInt16.max)", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3.4.\#(UInt.max)\#(UInt16.max)""#.utf8)))

		XCTAssertNoThrow(try SemanticVersion(versionString: "1.2.\(UInt.max)"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.0.\#(UInt.max)""#.utf8)))
		
		//	MARK: pre-release
		
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: sum("\(UInt.max)", "1"),    whenEvaluating: try SemanticVersion(1, 3, 5, prereleaseIdentifiers: [String(sum("\(UInt.max)", "1"))]))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: "8\(UInt.max)",             whenEvaluating: try SemanticVersion(2, 4, 6, prereleaseIdentifiers: ["8\(UInt.max)"]))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: "\(UInt.max)\(UInt.max)",   whenEvaluating: try SemanticVersion(3, 5, 7, prereleaseIdentifiers: ["\(UInt.max)\(UInt.max)"]))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: sum("\(UInt.max)", "1"),    whenEvaluating: try SemanticVersion(versionString: "1.2.3-\(sum("\(UInt.max)", "1"))"))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: "7\(UInt.max)",             whenEvaluating: try SemanticVersion(versionString: "4.5.6-7\(UInt.max)"))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: "\(UInt.max)\(UInt32.max)", whenEvaluating: try SemanticVersion(versionString: "8.9.0-\(UInt.max)\(UInt32.max)"))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: sum("\(UInt.max)", "1"),    whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.8.7-\#(sum("\(UInt.max)", "1"))""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: "3\(UInt.max)",             whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""6.5.4-3\#(UInt.max)""#.utf8)))
		assertThrowingOversizedValueError(atPosition: .prerelease, inIdentifier: "\(UInt.max)\(UInt64.max)", whenEvaluating: try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.1.0-\#(UInt.max)\#(UInt64.max)""#.utf8)))
		
		XCTAssertNoThrow(try SemanticVersion(1, 2, 3, prereleaseIdentifiers: ["\(UInt.max)"]))
		XCTAssertNoThrow(try SemanticVersion(versionString: "4.5.6-\(UInt.max)"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.8.9-\#(UInt.max)""#.utf8)))
		
		//	MARK: build metadata
		
		XCTAssertNoThrow(try SemanticVersion(1, 2, 3, buildMetadataIdentifiers: ["\(UInt.max)"]))
		XCTAssertNoThrow(try SemanticVersion(4, 5, 6, buildMetadataIdentifiers: [String(sum("\(UInt.max)", "1"))]))
		XCTAssertNoThrow(try SemanticVersion(7, 8, 9, buildMetadataIdentifiers: ["\(UInt.max)0"]))
		XCTAssertNoThrow(try SemanticVersion(1, 2, 3, buildMetadataIdentifiers: ["\(UInt.max)\(Int.max)"]))
		XCTAssertNoThrow(try SemanticVersion(versionString: "4.5.6+\(UInt.max)"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "7.8.9+\(sum("\(UInt.max)", "1"))"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "0.1.2+\(UInt.max)3"))
		XCTAssertNoThrow(try SemanticVersion(versionString: "4.5.6+\(Int.max)\(UInt.max)"))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.8.9+\#(UInt.max)""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.1.2+\#(sum("\(UInt.max)", "1"))""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3.4.5+\#(UInt.max)6""#.utf8)))
		XCTAssertNoThrow(try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.8.9+\#(UInt.max)\#(UInt.max)""#.utf8)))
	}
	
	func testIncorrectVersionCoreIdentifierCount() {
		let invalidCases: [
			(
				errorThrowingExpression: () throws -> SemanticVersion,
				versionCoreIdentifiers: [String],
				versionCoreIdentifierCount: Int,
				versionCoreDiagnosticDescription: String?
			)
		] = [
			//	MARK: 0 identifier
			
			({ try SemanticVersion(versionString: "-alpha") },                                  [], 0, nil),
			({ try SemanticVersion(versionString: "-beta1") },                                  [], 0, nil),
			({ try SemanticVersion(versionString: "-2.3.4") },                                  [], 0, nil),
			({ try SemanticVersion(versionString: "+aleph") },                                  [], 0, nil),
			({ try SemanticVersion(versionString: "+beth5") },                                  [], 0, nil),
			({ try SemanticVersion(versionString: "+6.7.8") },                                  [], 0, nil),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""-alpha""#.utf8)) }, [], 0, nil),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""-beta9""#.utf8)) }, [], 0, nil),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""-8.7.6""#.utf8)) }, [], 0, nil),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""+aleph""#.utf8)) }, [], 0, nil),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""+beth5""#.utf8)) }, [], 0, nil),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""+4.3.2""#.utf8)) }, [], 0, nil),
			
			//	MARK: 1 identifier
			
			({ try SemanticVersion(versionString: "0-iota") },                                 ["0"], 1, "'0'"),
			({ try SemanticVersion(versionString: "1-2345") },                                 ["1"], 1, "'1'"),
			({ try SemanticVersion(versionString: "6-78.9") },                                 ["6"], 1, "'6'"),
			({ try SemanticVersion(versionString: "9+yodh") },                                 ["9"], 1, "'9'"),
			({ try SemanticVersion(versionString: "8+7654") },                                 ["8"], 1, "'8'"),
			({ try SemanticVersion(versionString: "3+2.10") },                                 ["3"], 1, "'3'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9-rho""#.utf8)) }, ["9"], 1, "'9'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8-7.6""#.utf8)) }, ["8"], 1, "'8'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5-432""#.utf8)) }, ["5"], 1, "'5'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1+reh""#.utf8)) }, ["1"], 1, "'1'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0+1.2""#.utf8)) }, ["0"], 1, "'0'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""3+456""#.utf8)) }, ["3"], 1, "'3'"),
			
			//	MARK: 2 identifiers
			
			({ try SemanticVersion(versionString: "0.0-gamma") },                                  ["0", "0"], 2, "'0', '0'"),
			({ try SemanticVersion(versionString: "0.0-1.2.3") },                                  ["0", "0"], 2, "'0', '0'"),
			({ try SemanticVersion(versionString: "4.5-678.9") },                                  ["4", "5"], 2, "'4', '5'"),
			({ try SemanticVersion(versionString: "9.8+gimel") },                                  ["9", "8"], 2, "'9', '8'"),
			({ try SemanticVersion(versionString: "7.6+5.4.3") },                                  ["7", "6"], 2, "'7', '6'"),
			({ try SemanticVersion(versionString: "2.1+0.000") },                                  ["2", "1"], 2, "'2', '1'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.0-gamma""#.utf8)) }, ["0", "0"], 2, "'0', '0'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.0-1.2.3""#.utf8)) }, ["0", "0"], 2, "'0', '0'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""4.5-678.9""#.utf8)) }, ["4", "5"], 2, "'4', '5'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.8+gimel""#.utf8)) }, ["9", "8"], 2, "'9', '8'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""7.6+5.4.3""#.utf8)) }, ["7", "6"], 2, "'7', '6'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.1+0.000""#.utf8)) }, ["2", "1"], 2, "'2', '1'"),
			
			({ try SemanticVersion(versionString: ".0-lambda") },                                  ["",  "0"], 2, "'', '0'"),
			({ try SemanticVersion(versionString: ".0-12.345") },                                  ["",  "0"], 2, "'', '0'"),
			({ try SemanticVersion(versionString: ".6-7.8.9x") },                                  ["",  "6"], 2, "'', '6'"),
			({ try SemanticVersion(versionString: ".9+lamedh") },                                  ["",  "9"], 2, "'', '9'"),
			({ try SemanticVersion(versionString: ".8+76.5.4") },                                  ["",  "8"], 2, "'', '8'"),
			({ try SemanticVersion(versionString: ".3+2.1.00") },                                  ["",  "3"], 2, "'', '3'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".0-lambda""#.utf8)) }, ["",  "0"], 2, "'', '0'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".0-12.345""#.utf8)) }, ["",  "0"], 2, "'', '0'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".6-7.8.9x""#.utf8)) }, ["",  "6"], 2, "'', '6'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".9+lamedh""#.utf8)) }, ["",  "9"], 2, "'', '9'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".8+76.5.4""#.utf8)) }, ["",  "8"], 2, "'', '8'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".3+2.1.00""#.utf8)) }, ["",  "3"], 2, "'', '3'"),
			
			({ try SemanticVersion(versionString: "9.-adbmal") },                                  ["9", ""],  2, "'9', ''"),
			({ try SemanticVersion(versionString: "8.-76.543") },                                  ["8", ""],  2, "'8', ''"),
			({ try SemanticVersion(versionString: "2.-10qB7b") },                                  ["2", ""],  2, "'2', ''"),
			({ try SemanticVersion(versionString: "0.+hdemal") },                                  ["0", ""],  2, "'0', ''"),
			({ try SemanticVersion(versionString: "0.+1.2.34") },                                  ["0", ""],  2, "'0', ''"),
			({ try SemanticVersion(versionString: "5.+b.7.Bq") },                                  ["5", ""],  2, "'5', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""9.-adbmal""#.utf8)) }, ["9", ""],  2, "'9', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""8.-76.543""#.utf8)) }, ["8", ""],  2, "'8', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.-10qB7b""#.utf8)) }, ["2", ""],  2, "'2', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.+hdemal""#.utf8)) }, ["0", ""],  2, "'0', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""0.+1.2.34""#.utf8)) }, ["0", ""],  2, "'0', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""5.+b.7.Bq""#.utf8)) }, ["5", ""],  2, "'5', ''"),
			
			({ try SemanticVersion(versionString: ".-theta") },                                  ["", ""], 2, "'', ''"),
			({ try SemanticVersion(versionString: ".-1.2.3") },                                  ["", ""], 2, "'', ''"),
			({ try SemanticVersion(versionString: ".+delta") },                                  ["", ""], 2, "'', ''"),
			({ try SemanticVersion(versionString: ".+9.8.7") },                                  ["", ""], 2, "'', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".-kappa""#.utf8)) }, ["", ""], 2, "'', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".-1.2.3""#.utf8)) }, ["", ""], 2, "'', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".+koppa""#.utf8)) }, ["", ""], 2, "'', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#"".+9.8.7""#.utf8)) }, ["", ""], 2, "'', ''"),
			
			//	MARK: 4 identifiers
			
			({ try SemanticVersion(versionString: "1.2.3.4-abc") },                                  ["1", "2", "3", "4"], 4, "'1', '2', '3', '4'"),
			({ try SemanticVersion(versionString: "0.9.8.7+123") },                                  ["0", "9", "8", "7"], 4, "'0', '9', '8', '7'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""1.3.5.7-4.2""#.utf8)) }, ["1", "3", "5", "7"], 4, "'1', '3', '5', '7'"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""2.4.6.8+xyz""#.utf8)) }, ["2", "4", "6", "8"], 4, "'2', '4', '6', '8'"),
			
			//	TODO: Add more test cases with varying combination of empty and numeric identifiers.
			
			({ try SemanticVersion(versionString: "...-x.y.z") },                                  ["", "", "", ""], 4, "'', '', '', ''"),
			({ try SemanticVersion(versionString: "...+3.2.1") },                                  ["", "", "", ""], 4, "'', '', '', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""...-1.1.2""#.utf8)) }, ["", "", "", ""], 4, "'', '', '', ''"),
			({ try JSONDecoder().decode(SemanticVersion.self, from: Data(#""...+a.b.c""#.utf8)) }, ["", "", "", ""], 4, "'', '', '', ''"),
		]
		
		invalidCases.forEach {
			assertThrowingIncorrectVersionCoreIdentifierCountError(
				inVersionCore: $0.versionCoreIdentifiers,
				versionCoreDiagnosticDescription: $0.versionCoreDiagnosticDescription,
				parsedVersionCoreIdentifierCount: $0.versionCoreIdentifierCount,
				whenEvaluating: $0.errorThrowingExpression
			)
		}
	}
	
	//	TODO: Add tests for the precedence of error-throwing.
	
	func assertThrowingEmptyIdentifierError(
		atPosition position: SemanticVersionError.IdentifierPosition,
		whenEvaluating expression: @autoclosure () throws -> SemanticVersion
	) {
		let positionString = {
			switch position {
			case .major: return "major"
			case .minor: return "minor"
			case .patch: return "patch"
			case .prerelease: return "prerelease"
			case .buildMetadata: return "buildMetadata"
			}
		}()
		XCTAssertThrowsError(
			try expression(),
			"'SemanticVersionError.emptyIdentifier(position: .\(positionString))' should've been thrown, but no error is thrown"
		) { error in
			guard let error = error as? SemanticVersionError, case .emptyIdentifier(position: position) = error else {
				XCTFail(#"'SemanticVersionError.emptyIdentifier(position: .\#(positionString))' should've been thrown, but a different error is thrown instead; error description: "\#(error)""#)
				return
			}
			let positionDescription = {
				switch position {
				case .major: return "major version number"
				case .minor: return "minor version number"
				case .patch: return "patch version number"
				case .prerelease: return "pre-release"
				case .buildMetadata: return "build metadata"
				}
			}()
			XCTAssertEqual(
				error.description,
				"semantic version \(positionDescription) identifier cannot be empty"
			)
		}
	}
	
	func assertThrowingNonAlphanumericCharacterError(
		atPosition position: SemanticVersionError.AlphanumericIdentifierPosition,
		inIdentifier identifier: Substring,
		whenEvaluating expression: @autoclosure () throws -> SemanticVersion
	) {
		let positionString = {
			switch position {
			case .prerelease: return "prerelease"
			case .buildMetadata: return "buildMetadata"
			}
		}()
		XCTAssertThrowsError(
			try expression(),
			"'SemanticVersionError.invalidCharacterInIdentifier(\(identifier), position: .\(positionString))' should've been thrown, but no error is thrown"
		) { error in
			guard let error = error as? SemanticVersionError, case .invalidCharacterInIdentifier(identifier, position: position) = error else {
				XCTFail((#"'SemanticVersionError.invalidCharacterInIdentifier(\#(identifier), position: .\#(positionString))' should've been thrown, but a different error is thrown instead; error description: "\#(error)""#))
				return
			}
			let positionDescription = {
				switch position {
				case .prerelease: return "pre-release"
				case .buildMetadata: return "build metadata"
				}
			}()
			XCTAssertEqual(
				error.description,
				"semantic version \(positionDescription) identifier '\(identifier)' cannot contain characters other than ASCII alphanumerics and hyphen-minus ([0-9A-Za-z-])"
			)
		}
	}
	
	func assertThrowingNonNumericCharacterError(
		atPosition position: SemanticVersionError.NumericIdentifierPosition,
		inIdentifier identifier: Substring,
		whenEvaluating expression: @autoclosure () throws -> SemanticVersion
	) {
		let positionString = {
			switch position {
			case .major: return "major"
			case .minor: return "minor"
			case .patch: return "patch"
			case .prerelease: XCTFail("pre-release identifier with non-numeric characters should be regarded as alpha-numeric identifier"); return "prerelease"
			}
		}()
		XCTAssertThrowsError(
			try expression(),
			"'SemanticVersionError.invalidCharacterInIdentifier(\(identifier), position: .\(positionString))' should've been thrown, but no error is thrown"
		) { error in
			guard let error = error as? SemanticVersionError, case .invalidNumericIdentifier(identifier, position: position, errorKind: .nonNumericCharacter) = error else {
				XCTFail((#"'SemanticVersionError.invalidNumericIdentifier(\#(identifier), position: \#(positionString), errorKind: .nonNumericCharacter)' should've been thrown, but a different error is thrown instead; error description: "\#(error)""#))
				return
			}
			let positionDescription = {
				switch position {
				case .major: return "major version number"
				case .minor: return "minor version number"
				case .patch: return "patch version number"
				case .prerelease: XCTFail("pre-release identifier with non-numeric characters should be regarded as alpha-numeric identifier"); return "pre-release numeric"
				}
			}()
			XCTAssertEqual(
				error.description,
				"semantic version \(positionDescription) identifier '\(identifier)' cannot contain non-numeric characters"
			)
		}
	}
	
	func assertThrowingLeadingZerosError(
		atPosition position: SemanticVersionError.NumericIdentifierPosition,
		inIdentifier identifier: Substring,
		whenEvaluating expression: @autoclosure () throws -> SemanticVersion
	) {
		let positionString = {
			switch position {
			case .major: return "major"
			case .minor: return "minor"
			case .patch: return "patch"
			case .prerelease: return "prerelease"
			}
		}()
		XCTAssertThrowsError(
			try expression(),
			"'SemanticVersionError.invalidCharacterInIdentifier(\(identifier), position: .\(positionString))' should've been thrown, but no error is thrown"
		) { error in
			guard let error = error as? SemanticVersionError, case .invalidNumericIdentifier(identifier, position: position, errorKind: .leadingZeros) = error else {
				XCTFail((#"'SemanticVersionError.invalidNumericIdentifier(\#(identifier), position: \#(positionString), errorKind: .leadingZeros)' should've been thrown, but a different error is thrown instead; error description: "\#(error)""#))
				return
			}
			let positionDescription = {
				switch position {
				case .major: return "major version number"
				case .minor: return "minor version number"
				case .patch: return "patch version number"
				case .prerelease: return "pre-release numeric"
				}
			}()
			XCTAssertEqual(
				error.description,
				"semantic version \(positionDescription) identifier '\(identifier)' cannot contain leading '0'"
			)
		}
	}
	
	func assertThrowingOversizedValueError(
		atPosition position: SemanticVersionError.NumericIdentifierPosition,
		inIdentifier identifier: Substring,
		whenEvaluating expression: @autoclosure () throws -> SemanticVersion
	) {
		let positionString = {
			switch position {
			case .major: return "major"
			case .minor: return "minor"
			case .patch: return "patch"
			case .prerelease: return "prerelease"
			}
		}()
		XCTAssertThrowsError(
			try expression(),
			"'SemanticVersionError.invalidCharacterInIdentifier(\(identifier), position: .\(positionString))' should've been thrown, but no error is thrown"
		) { error in
			guard let error = error as? SemanticVersionError, case .invalidNumericIdentifier(identifier, position: position, errorKind: .oversizedValue) = error else {
				XCTFail((#"'SemanticVersionError.invalidNumericIdentifier(\#(identifier), position: \#(positionString), errorKind: .oversizedValue)' should've been thrown, but a different error is thrown instead; error description: "\#(error)""#))
				return
			}
			let positionDescription = {
				switch position {
				case .major: return "major version number"
				case .minor: return "minor version number"
				case .patch: return "patch version number"
				case .prerelease: return "pre-release numeric"
				}
			}()
			XCTAssertEqual(
				error.description,
				"semantic version \(positionDescription) identifier '\(identifier)' cannot be larger than 'UInt.max'"
			)
		}
	}
	
	func assertThrowingIncorrectVersionCoreIdentifierCountError(
		inVersionCore versionCoreIdentifiers: [String],
		versionCoreDiagnosticDescription: String?,
		parsedVersionCoreIdentifierCount versionCoreIdentifierCount: Int,
		whenEvaluating expression: () throws -> SemanticVersion
	) {
		XCTAssertThrowsError(
			try expression(),
			"'SemanticVersionError.invalidVersionCoreIdentifierCount(identifiers: \(versionCoreIdentifiers))' should've been thrown, but no error is thrown"
		) { error in
			guard let error = error as? SemanticVersionError, case .invalidVersionCoreIdentifierCount(identifiers: versionCoreIdentifiers) = error else {
				XCTFail((#"'SemanticVersionError.invalidVersionCoreIdentifierCount(identifiers: \#(versionCoreIdentifiers))' should've been thrown, but a different error is thrown instead; error description: "\#(error)""#))
				return
			}
			XCTAssertEqual(
				error.description,
				"semantic version must contain exactly 3 version core identifiers; \(versionCoreIdentifierCount) given\(versionCoreDiagnosticDescription == nil ? "" : " : \(versionCoreDiagnosticDescription!)")"
			)
		}
	}
}
