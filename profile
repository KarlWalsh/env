thisFile=`readlink ~/.bash_profile`
envDir=`dirname $thisFile`

. $envDir/bash/prompt
. $envDir/gradle/aliases

. ~/projects/z/z.sh

