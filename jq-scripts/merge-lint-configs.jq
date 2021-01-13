# merge_object is based on: https://stackoverflow.com/a/36218044/1423815
def merge_objects:
	reduce .[] as $item (
		{};
		. * $item
	)
;

def sort_by_keys:
	to_entries
	| sort_by(.key)
	| from_entries
;

def concatenated_path_values(paths):
	. as $inputs
	| paths
	| map(
		. as $path
		| (
			$inputs
			| map(getpath($path) | select(. != null))
			| flatten
		) as $value
		| {}
		| setpath($path; $value)
	)
;

.
+ concatenated_path_values([
	["extends"],
	["overrides"],
	["plugins"]
])
| merge_objects
| sort_by_keys
