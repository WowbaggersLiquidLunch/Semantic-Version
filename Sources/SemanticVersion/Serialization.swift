extension SemanticVersion: Codable {
	///	Creates a semantic version by decoding from the given decoder.
	///	- Parameter decoder: The decoder to read data from.
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let versionString = try container.decode(String.self)
		try self.init(versionString: versionString)
	}
	
	///	Encodes the semantic version into the given encoder.
	///	- Parameter encoder: The encoder to write data to.
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(self.description)
	}
}
