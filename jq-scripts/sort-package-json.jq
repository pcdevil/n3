# based on: https://stackoverflow.com/a/60889827/1423815

def conditional_key_sorting:
	if . then
		.
		| to_entries
		| sort_by(.key)
		| from_entries
	else
		null
	end
;

{
	name,
	version,
	description,
	keywords,
	main,
	bin,
	exports: (.exports | conditional_key_sorting),
	scripts: (.scripts | conditional_key_sorting),
	engines,
	private,
	author,
	contributors,
	repository,
	bugs,
	homepage,
	license,
	devDependencies,
	peerDependencies,
	dependencies
}
+ (.  | del(.exports, .scripts) | conditional_key_sorting)
| with_entries(select(.value != null))
