local vide = require(script.Parent.packages.vide)

export type SourcedAs<T> = T | vide.Source<T>
export type Components = SourcedAs<{ Instance }>
export type Component = SourcedAs<Instance>

export type TestResult = {
	type: "ok" | "fail" | "warn",
	message: string,
}

export type TestDefinition = {
	title: string,
	description: string,
	fn: (ore: BasePart) -> TestResult,
}

export type ModifierDefinition = {
	title: string,
	description: string,
	fn: (ore: BasePart) -> (),
}

return nil
