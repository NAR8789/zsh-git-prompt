#!/bin/zsh

OVERALL_RESULT=0

for TEST_FILE in test/test_*; do
  "$TEST_FILE"
  local last_result="$?"

  if [ "$last_result" -gt "$OVERALL_RESULT" ]; then
    OVERALL_RESULT="$last_result"
  fi
done

exit $OVERALL_RESULT
