node_modules/mocha/bin/mocha -w $(find test -name "*Spec.js") $@

# Test only one spec
# node_modules/mocha/bin/mocha -w $(find test -name "db/customerSpec.js") $@
# -R min
# -R spec