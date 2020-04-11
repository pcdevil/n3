.scripts."test" = "mocha 'test/setup.js' 'test/**/*.spec.js'"
| .scripts."test:watch" = "npm run test -- --watch --watch-files src,test --reporter min"
