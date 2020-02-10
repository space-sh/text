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

TEXT_EXTRACT_VARIABLES()
{
    SPACE_SIGNATURE="text"

    local text="${1}"
    shift

    printf "%s\\n" "${text}" |
        awk ' { if (match($0,/(\${[A-Za-z_][0-9A-Za-z_]*})/,m)) print substr(m[0],3,length(m[0])-3) }' |
        sort |uniq
}

TEXT_GET_ENV()
{
    SPACE_SIGNATURE="variables"

    local variables="${1}"
    shift

    local varname=
    local value=
    for varname in ${variables}; do
        eval "value=\"\${${varname}}\""
        printf "%s=%s\\n" "${varname}" "${value}"
    done
}

TEXT_VARIABLE_SUBST()
{
    SPACE_SIGNATURE="text variables values"
    SPACE_DEP="STRING_ESCAPE"

    local text="${1}"
    shift

    local variables="${1}"
    shift

    local values="${1}"
    shift

    local value=
    local varname=
    for varname in ${variables}; do
        value="$(printf "%s\\n" "${values}" |grep -m 1 ${varname})"
        value="${value#*${varname}=}"
        varname="\${${varname}}"
        STRING_ESCAPE "varname" '/'
        STRING_ESCAPE "value" '/'
        text="$(printf "%s\\n" "${text}" |sed "s/${varname}/${value}/g")"
    done

    printf "%s\\n" "${text}"
}

TEXT_FILTER()
{
    local awkscript='
    BEGIN {
        count=0
        keep=1
    }

    {
        if (match($0,/^#endif[ ]*$/,m))
        {
            count--;
            if (count == 0)
            {
                keep=1
                next
            }
        }
    }

    {
        if (match($0,/^#if([n]?)def[ ]?([^ ]*)$/,m))
        {
            count++;
            if (count == 1)
            {
                if (length(m[2]) >0)
                {
                    keep=(m[1] == "" ? 1 : 0)
                }
                else
                {
                    keep=(m[1] == "" ? 0 : 1)
                }
                next
            }
        }
    }

    {
        if (match($0,/^#if([n]?)true[ ]?([^ ]*)$/,m))
        {
            count++;
            if (count == 1)
            {
                if (m[2] == "true")
                {
                    keep=1
                }
                else
                {
                    keep=0
                }
                keep=(m[1] == "" ? keep : !keep)
                next
            }
        }
    }

    {
        if (keep)
        {
            print
        }
    }

    END {
        if (count >0)
        {
            print "Error: Missing #endif" > "/dev/stderr"
        }
    }
'
    local text="$(cat)"
    local text2="${text}"
    while true; do
        text2="$(printf "%s\\n" "${text}" |awk "${awkscript}")"
        if [ "${text2}" = "${text}" ]; then
            break
        fi
        text="${text2}"
    done
    printf "%s\\n" "${text}"
}

# Perform a variable substitution and preprocessing using the
# env variables at hand.
TEXT_PREPROCESS()
{
    SPACE_DEP="TEXT_EXTRACT_VARIABLES TEXT_GET_ENV TEXT_VARIABLE_SUBST TEXT_FILTER"

    local text="$(cat)"
    local variables="$(TEXT_EXTRACT_VARIABLES "${text}")"
    local values="$(TEXT_GET_ENV "${variables}")"
    local text="$(TEXT_VARIABLE_SUBST "${text}" "${variables}" "${values}")"
    printf "%s\\n" "${text}" |TEXT_FILTER
}
