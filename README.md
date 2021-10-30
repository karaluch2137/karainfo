USAGE:<br />
./app.sh [arguments]<br />

DESCRIPTION:<br />
script for scraping useful informations from various boards.<br />
creator: anon<br />
<br />
ARGUMENTS:<br />
--board  [str]    (specifies board from which the script will get informations)<br />
--raw    [bool]   (specifies if output will be presented in pretty or raw form)<br />
--loop   [bool]   (specifies if script will execute only once or inifnite)<br />
--delay  [int]    (time between updates if the --loop is set to "true")<br />
--write  [string] (append output to file specified in argument if --raw is set to "true")<br />
<br />
DEFAULT:<br />
--board=b<br />
--raw=false<br />
--loop=false<br />
--delay=5<br />
--write=none (will not write)<br />
<br />
RAW FORMAT:<br />
[date (y-m-d h<zero-width space>:<zero-width space>m:s)],[board],[online],[active posts],[pontyfikat]<br />




