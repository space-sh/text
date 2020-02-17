#
# Copyright 2020 Blockie AB
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

_TEST_TEXT_EXTRACT_VARIABLES()
{
    SPACE_DEP="TEXT_EXTRACT_VARIABLES PRINT"

    # Read variables from reference text file
    local text="$(cat ./test/text.txt)"
    local output=
    output=$(TEXT_EXTRACT_VARIABLES "$text")

    # Load reference variables to compare against
    local reference="$(cat ./test/text_variables.txt)"

    # Compare reference variables with text output
    if [ "${reference}" != "${output}" ]; then
        PRINT "Unmatched variable extraction." "error"
        PRINT "Expected: '${reference}' got '${output}'"
        return 1
    fi
}

_TEST_TEXT_GET_ENV()
{
    SPACE_DEP="TEXT_EXTRACT_VARIABLES TEXT_GET_ENV PRINT"

    # Read variables from reference text file
    local text="$(cat ./test/text.txt)"
    local variables=
    variables=$(TEXT_EXTRACT_VARIABLES "$text")

    # Set environment variables to reference values
    export $(cat ./test/text_values.txt)

    # Read environment values from variables
    local output=
    output=$(TEXT_GET_ENV "$variables" "1")

    # Load reference environment variable settings
    local reference="$(cat ./test/text_values.txt)"

    # Compare reference values with env output
    if [ "${reference}" != "${output}" ]; then
        PRINT "Unable to read from environment variables: $variables" "error"
        PRINT "Expected: '${reference}' got '${output}'"
        return 1
    fi
}

_TEST_TEXT_VARIABLE_SUBST()
{
    SPACE_DEP="TEXT_VARIABLE_SUBST TEXT_EXTRACT_VARIABLES TEXT_GET_ENV PRINT"

    # Read variables from reference text file
    local text="$(cat ./test/text.txt)"
    local variables=
    variables=$(TEXT_EXTRACT_VARIABLES "$text")

    # Set environment variables
    export $(cat ./test/text_values.txt)

    # Retrieve values from environment variables
    local values=
    values=$(TEXT_GET_ENV "$variables" "1")

    # Substitute variables with environment variable values
    local output=
    output=$(TEXT_VARIABLE_SUBST "$text" "$variables" "$values")

    # Load reference subst text
    local reference="$(cat ./test/text_subst.txt)"

    # Compare reference values to substituted text output
    if [ "${reference}" != "${output}" ]; then
        PRINT "Failed to match subst text with reference." "error"
        PRINT "Expected: '${reference}' got '${output}'"
        return 1
    fi
}

_TEST_TEXT_FILTER()
{
    SPACE_DEP="TEXT_FILTER TEXT_VARIABLE_SUBST TEXT_EXTRACT_VARIABLES TEXT_GET_ENV PRINT"

    # Read variables from reference text file
    local text="$(cat ./test/text.txt)"
    local variables=
    variables=$(TEXT_EXTRACT_VARIABLES "$text")

    # Set environment variables
    export "$(cat ./test/text_filter_values.txt)"

    # Read environment values from variables
    local values=
    values=$(TEXT_GET_ENV "$variables" "1")

    # Substitute variables in text
    local subst=
    subst=$(TEXT_VARIABLE_SUBST "$text" "$variables" "$values")

    # Filter out ifdef and ifndefs
    local output=
    output="$(printf "%s" "${subst}" | TEXT_FILTER)"

    # Load reference subst text
    local reference="$(cat ./test/text_filter.txt)"

    # Compare filtered output with reference subst text
    if [ "${reference}" != "${output}" ]; then
        PRINT "Unmatched filtered output." "error"
        PRINT "Expected: '${reference}' got '${output}'"
        return 1
    fi
}

_TEST_TEXT_PREPROCESS()
{
    SPACE_DEP="TEXT_PREPROCESS PRINT"

    # Set environment variables
    export "$(cat ./test/text_preprocess_values.txt)"

    # Load reference variables to compare against
    local reference="$(cat ./test/text_preprocess.txt)"

    # Read reference text file
    local text="$(cat ./test/text.txt)"

    # Preprocess text
    local output=
    output=$(printf "%s" "$text" | TEXT_PREPROCESS)

    # Compare reference variables with text
    if [ "${reference}" != "${output}" ]; then
        PRINT "Unexpected preprocess output." "error"
        PRINT "Expected: '${reference}' got '${output}'"
        return 1
    fi
}
