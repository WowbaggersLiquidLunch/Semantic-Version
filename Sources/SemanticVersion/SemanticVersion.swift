///	A [semantic version](https://semver.org).
public struct SemanticVersion {
	///	The major version.
	public let major: UInt
	///	The minor version.
	public let minor: UInt
	///	The patch version.
	public let patch: UInt
	///	Dot-separated pre-release identifiers.
	public var prereleaseIdentifiers: [String] { prerelease.identifiers.map(\.description) }
	///	Dot-separated build metadata identifiers.
	public let buildMetadataIdentifiers: [String]
	
	///	The internal storage of pre-release identifiers.
	internal let prerelease: Prerelease
	
	///	Creates a semantic version with the provided components of a semantic version.
	///	- Parameters:
	///	  - major: The major version number.
	///	  - minor: The minor version number.
	///	  - patch: The patch version number.
	///	  - prereleaseIdentifiers: The pre-release identifiers.
	///	  - buildMetaDataIdentifiers: The build metadata identifiers.
	public init(
		_ major: UInt,
		_ minor: UInt,
		_ patch: UInt,
		prereleaseIdentifiers: [String] = [],
		buildMetadataIdentifiers: [String] = []
	) throws {
		self.major = major
		self.minor = minor
		self.patch = patch
		
		self.prerelease = try Prerelease(prereleaseIdentifiers)
		
		guard buildMetadataIdentifiers.allSatisfy( { !$0.isEmpty } ) else {
			throw SemanticVersionError.emptyIdentifier(position: .buildMetadata)
		}
		try buildMetadataIdentifiers.forEach {
			guard $0.allSatisfy( { $0.isASCII && ( $0.isLetter || $0.isNumber || $0 == "-" ) } ) else {
				throw SemanticVersionError.invalidCharacterInIdentifier($0, position: .buildMetadata)
			}
		}
		self.buildMetadataIdentifiers = buildMetadataIdentifiers
	}
}

//	MARK: - Inspecting the Semantics

extension SemanticVersion {
	///	A Boolean value indicating whether the version is for a pre-release.
	public var denotesPrerelease: Bool { !prerelease.identifiers.isEmpty }
	
	///	A Boolean value indicating whether the version is for a stable release.
	public var denotesStableRelease: Bool { major > 0 && !denotesPrerelease }
	
	///	Returns a Boolean value indicating whether a release with this version can introduce source-breaking changes from that with the given other version.
	///	- Parameter other: The older version a release with which to check if a release with the current version is allowed to source-break from.
	///	- Returns: A Boolean value indicating whether a release with this version can introduce source-breaking changes from that with `other`.
	public func denotesSourceBreakableRelease(fromThatWith other: Self) -> Bool {
		self > other && (
			self.major != other.major ||
			self.major == 0 ||	//	When self.major == 0, other.major must also == 0 here.
			(self.denotesPrerelease || other.denotesPrerelease)
		)
	}
}

//	MARK: - Creating a Version Semantically

extension SemanticVersion {
	///	The version that denotes the initial stable release.
	public static var initialStableReleaseVersion: Self {
		try! Self(1, 0, 0)
	}
	
	///	Returns the version denoting the next major release that comes after the release denoted with the given version.
	///	- Parameter version: The version after which the version that denotes the next major release may come.
	///	- Returns: The version denoting the next major release that comes after the release denoted with `version`.
	public func nextMajorReleaseVersion(from version: Self) -> Self {
		if version.denotesPrerelease && version.major > 0 && version.minor == 0 && version.patch == 0 {
			return try! Self(version.major, 0, 0)
		} else {
			return try! Self(version.major + 1, 0, 0)
		}
	}
}

//	MARK: - Comparable Conformance

extension SemanticVersion: Comparable {
	//	Although `Comparable` inherits from `Equatable`, it does not provide a new default implementation of `==`, but instead uses `Equatable`'s default synthesised implementation. The compiler-synthesised `==`` is composed of [member-wise comparisons](https://github.com/apple/swift-evolution/blob/main/proposals/0185-synthesize-equatable-hashable.md#implementation-details), which leads to a false `false` when 2 semantic versions differ by only their build metadata identifiers, contradicting SemVer 2.0.0's [comparison rules](https://semver.org/#spec-item-10).
	///	Returns a Boolean value indicating whether two semantic versions are equal.
	///	- Parameters:
	///	  - lhs: A semantic version to compare.
	///	  - rhs: Another semantic version to compare.
	///	- Returns: `true` if `lhs` and `rhs` are equal; `false` otherwise.
	@inlinable
	public static func == (lhs: Self, rhs: Self) -> Bool {
		!(lhs < rhs) && !(lhs > rhs)
	}
	
	///	Returns a Boolean value indicating whether the first semantic version precedes the second semantic version.
	///	- Parameters:
	///	  - lhs: A semantic version to compare.
	///	  - rhs: Another semantic version to compare.
	///	- Returns: `true` if `lhs` precedes `rhs`; `false` otherwise.
	public static func < (lhs: Self, rhs: Self) -> Bool {
		let lhsVersionCore = [lhs.major, lhs.minor, lhs.patch]
		let rhsVersionCore = [rhs.major, rhs.minor, rhs.patch]
		
		guard lhsVersionCore == rhsVersionCore else {
			return lhsVersionCore.lexicographicallyPrecedes(rhsVersionCore)
		}
		
		return lhs.prerelease < rhs.prerelease	//	not lexicographically compared
	}
}
