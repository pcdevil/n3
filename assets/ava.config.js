const watchMode = !!process.env.WATCH_MODE;

export default {
	failFast: true,
	failWithoutAssertions: false,
	files: [
		'test/**/*.spec.js',
	],
	ignoredByWatcher: [
		'tmp/**/*',
	],
	verbose: !watchMode,
	watch: watchMode,
}
