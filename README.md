# `tester`

## Development

* install dependencies

  ```sh
  git clone https://github.com/varlogerr/toolbox.sh.vendor.git ./vendor/vendor
  cd ./vendor/vendor
  git checkout <latest-tag>
  cd -
  # initialize the project
  ./vendor/vendor/bin/vendor.sh --init .
  # install dependencies. after initialization
  # there will be only vendor itself as a dependency
  ./vendor/vendor/bin/vendor.sh
  ```

## TBD

```sh
# TESTDIR defaults to "$(pwd)/tests"
export TESTSDIR=./my-tests
tester.sh run
```

`${TESTDIR}/setup.sh` file (if exists) is automatically sourced
`${TESTDIR}/setup` directory (if exists) automatically sourced all `*.sh` files
`${TESTDIR}/*/setup.sh` file is automatically sourced for the testfile in the directory

Only matches test files by pattern `*/suit.{suitname}/test.sh`
