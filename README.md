# kvstore

kvstore is a bash solution that stores arbitrary key-value pairs for script lookup purposes.

## Why would I want to use something like this?

Well, probably you wouldn't, but your script _might_

In most cases cron jobs and scripts are more or less self-contained. Sometimes, however, it can be useful to know information from previous runs. For example when was the last time this script ran successfully?

There are of course other ways of solving this; for example by touching a file and reading the file timestamp.

This script aims to be something a bit more re-usable while also giving the user a relatively simple way to inspect stored keys and values.

Another issue that the script attempts to address is conflicts due to delayed syncs. For example let's say that you use Dropbox, SpiderOak or some other slow sync service and you have the same cron job running on two computers.

If both scripts write to the same file, then slow / delayed syncs like these means that conflicts can arise. The `kvstore` script works around this by storing data in host specific files, then allowing keys to be looked up globally (i.e. cross-host). This means that you can ask when did a cron job last run successfully on this specific host vs across all hosts.

As an example use case I have a job that I want to run once daily, but not all computers are running all the time or even every day. If two or three computers are running, then avoid running the same job more than once.

By running the job at different times on each computer combined with doing a global check for when the script last ran I can accomplish this requirement.

`kvstore` is released as-is with the anticipation that I'll get around to release other tools and scripts that depend on it. Going forward it may be that the script is renamed, evolves into something entirely different or is simply disregarded in favour of better solutions.

## Installation

Download or clone this repository and ensure that the `kvstore` file is in your PATH.

## Example usage
```
Usage: kvstore [OPTION?] [KEY?]

Stores arbitrary key-value pairs for script lookup purposes.

  -a, --add <value> <key>        adds value with the given key
  -u, --update <value> <key>     alias for the above
  -l, --list                     lists current keys and values
  -r, --remove <key>             removes a given key
      --clear                    removes all keys
  -h, --help                     display this help section
  -k, --keys                     lists current keys
  -g, --global                   apply action to all host files
  -f, --file                     specify data file to store keys in rather than
                                 using the default
      --locate                   list location of data file
      --hostname <name>          apply action to specific host file
  -q, --quiet                    avoid printing to standard out when adding and
                                 removing files (recommended for scripts)

Examples:
  kvstore -a value key           stores "value" with the key "key"
  kvstore -l                     list stored keys and values
  kvstore key                    returns the value associated with the key "key"
  kvstore -r key                 removes the stored key "key"

```

Example output:
```bash
[bash@marklet:~]
$ kvstore -a "$(date +'%F %T')" last_successful_run
2019-03-13 16:17:05 added as last_successful_run
[bash@marklet:~]
$ kvstore -l
Key                                                     Value
last_successful_run                                     2019-03-13 16:17:05
[bash@marklet:~]
```
