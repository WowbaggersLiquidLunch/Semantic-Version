extension SemanticVersion {
	///	Instantiates a semantic version from the provided version string.
	///	- Parameter versionString: A version string to instantiate a semantic version from.
	///	- Throws: A `SemanticVersionError` instance, if `versionString` is malformed or contains numeric components that are too large to be represented in `SemanticVersion`.
	public init<S: StringProtocol>(versionString: S) throws where S.SubSequence == Substring {
		let metadataDelimiterIndex = versionString.firstIndex(of: "+")
		//	SemVer 2.0.0 requires that pre-release identifiers come before build metadata identifiers
		let prereleaseDelimiterIndex = versionString[..<(metadataDelimiterIndex ?? versionString.endIndex)].firstIndex(of: "-")
		
		let versionCore = versionString[..<(prereleaseDelimiterIndex ?? metadataDelimiterIndex ?? versionString.endIndex)]
		let versionCoreIdentifiers = versionCore.split(separator: ".", omittingEmptySubsequences: false)
		
		guard versionCoreIdentifiers.count == 3 else {
			throw SemanticVersionError.invalidVersionCoreIdentifierCount(identifiers: versionCore.isEmpty ? [] : versionCoreIdentifiers)
		}
		
		self.major = try validNumericIdentifier(versionCoreIdentifiers[0], identifierPosition: .major)
		self.minor = try validNumericIdentifier(versionCoreIdentifiers[1], identifierPosition: .minor)
		self.patch = try validNumericIdentifier(versionCoreIdentifiers[2], identifierPosition: .patch)
		
		if let prereleaseDelimiterIndex = prereleaseDelimiterIndex {
			let prereleaseStartIndex = versionString.index(after: prereleaseDelimiterIndex)
			let prereleaseIdentifiers = versionString[prereleaseStartIndex..<(metadataDelimiterIndex ?? versionString.endIndex)].split(separator: ".", omittingEmptySubsequences: false)
			self.prerelease = try Prerelease(prereleaseIdentifiers)
		} else {
			self.prerelease = Prerelease(identifiers: [])	//	This is the member-wise initializer taking `[Identifier]` not `[S: StringProtocol]`.
		}
		
		if let metadataDelimiterIndex = metadataDelimiterIndex {
			let metadataStartIndex = versionString.index(after: metadataDelimiterIndex)
			let buildMetadataIdentifiers = versionString[metadataStartIndex...].split(separator: ".", omittingEmptySubsequences: false)
			self.buildMetadataIdentifiers = try buildMetadataIdentifiers.map {
				guard !$0.isEmpty else {
					throw SemanticVersionError.emptyIdentifier(position: .buildMetadata)
				}
				guard $0.allSatisfy(\.isAllowedInSemanticVersionIdentifier) else {
					throw SemanticVersionError.invalidCharacterInIdentifier($0, position: .buildMetadata)
				}
				return String($0)
			}
		} else {
			self.buildMetadataIdentifiers = []
		}
		
		///	Creates an integer-represented numeric identifier from the given identifier.
		///
		///	Semantic Versioning 2.0.0 requires valid numeric identifiers to be "0" or ASCII digit sequence without leading "0"s.
		///
		///	- Parameter identifierString: The given identifier.
		///	- Returns: The integer representation of the identifier, if the identifier is a valid Semantic Versioning 2.0.0 numeric identifier, and if it is representable by `Int`.
		///	- Throws: A `SemanticVersionError.invalidNumericIdentifier` instance, if the `identifierString` does not represent a valid numeric identifier.
		func validNumericIdentifier(_ identifierString: Substring, identifierPosition: SemanticVersionError.NumericIdentifierPosition) throws -> UInt {
			//	Converting the identifier from a substring to an unsigned integer doubles as asserting that the identifier is non-empty and that it has no non-ASCII-numeric characters other than an optional leading "+" or "-".
			guard let numericIdentifier = UInt(identifierString) else {
				//	When multiple errors are present simultaneously in an identifier string, the most "serious" error is diagnosed first.
				//	For example, "0000099999999999999999999" both is too large and contains leading zeros. Of the 2 errors, the number being too large is more serious than it containing leading zeros, because the former is an error in its content while the latter in its format.
				if identifierString.isEmpty {
					throw SemanticVersionError.emptyIdentifier(
						position: {
							switch identifierPosition {
							case .major: return .major
							case .minor: return .minor
							case .patch: return .patch
							case .prerelease: return .prerelease
							}
						}()
					)
				} else if (identifierString.first == "+" && identifierString.dropFirst().allSatisfy(\.isAllowedInSemanticVersionNumericIdentifier))
							|| identifierString.allSatisfy(\.isAllowedInSemanticVersionNumericIdentifier) {
					//	If the identifier string represents a positive number, but cannot be converted to `UInt`, then it must be too large.
					throw SemanticVersionError.invalidNumericIdentifier(
						identifierString,
						position: identifierPosition,
						errorKind: .oversizedValue
					)
				} else {
					throw SemanticVersionError.invalidNumericIdentifier(
						identifierString,
						position: identifierPosition,
						errorKind: .nonNumericCharacter
					)
				}
			}
			//	Although `Int.init<S: StringProtocol>(_:)` accepts a leading "+" in the argument, we don't need to be check for it here. "+" is the delimiter between pre-release and build metadata, and build metadata does not care for the validity of numeric identifiers.
			guard identifierString == "0" || (identifierString.first != "-" && identifierString.first != "0") else {
				throw SemanticVersionError.invalidNumericIdentifier(
					identifierString,
					position: identifierPosition,
					errorKind: .leadingZeros
				)
			}
			return numericIdentifier
		}
	}
}

//	MARK: - CustomStringComparable Conformance

extension SemanticVersion: CustomStringConvertible {
	///	A textual description of the semantic version.
	public var description: String {
		var versionString = "\(major).\(minor).\(patch)"
		if !prerelease.identifiers.isEmpty {
			versionString += "-\(prerelease)"
		}
		if !buildMetadataIdentifiers.isEmpty {
			versionString += "+" + buildMetadataIdentifiers.joined(separator: ".")
		}
		return versionString
	}
}

//	MARK: - LosslessStringConvertible Conformance

extension SemanticVersion: LosslessStringConvertible {
	///	Instantiates a semantic version from the provided version string.
	///	- Parameter versionString: A version string to instantiate a semantic version from.
	public init?(_ versionString: String) {
		try? self.init(versionString: versionString)
	}
}

//	MARK: - ExpressibleByStringInterpolation Conformance

extension SemanticVersion: ExpressibleByStringInterpolation {
	///	Instantiates a semantic version from the provided version string.
	///	- Parameter version: A version string to instantiate a semantic version from.
	public init(stringLiteral value: String) {
		try! self.init(versionString: value)
	}
}

//	MARK: - Validating Identifiers

extension Character {
	///	A Boolean value indicating whether this character is allowed in a semantic version's identifier.
	internal var isAllowedInSemanticVersionIdentifier: Bool {
		isASCII && (isLetter || isNumber || self == "-")
	}
	
	///	A Boolean value indicating whether this character is allowed in a semantic version's numeric identifier.
	internal var isAllowedInSemanticVersionNumericIdentifier: Bool {
		isASCII && isNumber
	}
}

extension StringProtocol {
	///	A Boolean value indicating whether this string value is allowed as a semantic version's numeric identifier.
	internal var isAllowedAsSemanticVersionNumericIdentifier: Bool {
		self == "0" || (first != "0" && allSatisfy(\.isAllowedInSemanticVersionNumericIdentifier) && !isEmpty)
	}
	
	///	A Boolean value indicating whether this string value is allowed as a semantic version's alphanumeric identifier.
	internal var isAllowedAsSemanticVersionAlphanumericIdentifier: Bool {
		allSatisfy(\.isAllowedInSemanticVersionIdentifier) && !allSatisfy(\.isAllowedInSemanticVersionNumericIdentifier) && !isEmpty
	}
	
	///	A Boolean value indicating whether this string value is allowed as a semantic version's build metadata identifier.
	internal var isAllowedAsSemanticVersionBuildMetadataIdentifier: Bool {
		allSatisfy(\.isAllowedInSemanticVersionIdentifier) && !isEmpty
	}
}
