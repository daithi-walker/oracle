#!/bin/bash

# compress log files older than 30 days.
find /u03/essence/ \
	-type f \
	-mtime +30 \
	\( \( \( -path '*\/cron_logs\/*' -o -path '*\/cronlogs\/*' -o -path '*\/logs\/*' -o -path '*\/IMAP\/*' -o -path '*\/sqlldr_log\/*' \) -name '*.log' \) -o \( -path '*sqlldr_bad*' -a -name '*.bad' \) \) \
	-exec gzip -f {} \;

# remove compressed log and bad files older than a year.
find /u03/essence/ \
	-type f \
	-mtime +365  \
	\( \( \( -path '*\/cron_logs\/*' -o -path '*\/cronlogs\/*' -o -path '*\/logs\/*' -o -path '*\/IMAP\/*' -o -path '*\/sqlldr_log\/*' \) -a -name '*.log.gz' \) -o \( -path '*sqlldr_bad*' -a -name '*.bad.gz' \) \) \
	-delete

# data files
find /u03/essence/ \
	-type f \
	-mtime +30 \
	-path '*\/data\/*' \
	-path '*\/archive\/*' \
	! -path '*ds-olive-3*' \
	\( -name '*.csv' -o -name '*.CSV' -o -name '*.xls' -o -name '*.xlsx' -o -name '*.json' \) \
	-exec gzip -f {} \;

# following folder does not have archive directory in path giving it a separate find
find /u03/essence/admin/bin/pyutils/alerts/data/ \
	-type f \
	-mtime +30 \
	-name '*.csv' \
	-exec gzip -f {} \;

# had data and archive in the name but file name is wildcard. putting here to stop confusion above.
find /u03/essence/partners/google/data/pcampaignid_passback/archive/ \
	-type f \
	-mtime +30 \
	-name '*.csv-*' \
	! -name '*.gz' \
	-exec gzip -f {} \;

# various nohup files are generated on the server due to the way people run scripts...
find /u03/essence/ \
	-type f \
	-mtime +1 \
	-name 'nohup.out' \
	-delete

# List files that are greater then 31 days old that are not excluded by
# the rules below. This is to ty identify what is not being caught above
# or just stored in the repo or ignored by git or whatever, use the below
# find command. I'm sure it misses some things but better than nothing!
find /u03/essence/ \
	-type f \
	-mtime +31 \
	! -path '*\/.git\/*' \
	! -path '*\/.svn\/*' \
	! -path '*\/.ssh\/*' \
	! -path '*\/bin\/*' \
	! -path '*\/lib\/*' \
	! -path '*\/Python-2.7.6\/*' \
	! -path '*\/flagfiles\/*' \
	! -path '*\/doc-source\/*' \
	! -path '*\/docs\/*' \
	! -path '*\/IMAP\/*' \
	! -path '*\/ispy\/*' \
	! -path '*\/eharmony\/*' \
	! -path '*\/harvest\/*' \
	! -path '*\/ds-olive-3*' \
	! -name '*.gitignore' \
	! -name '*.flag' \
	! -name '*.gz' \
	! -name '*.zip' \
	! -name '*.py' \
	! -name '*.pyc' \
	! -name '*.sql' \
	! -name '*.sh' \
	! -name '*.ctl' \
	! -name '*.pls' \
	! -name '*.pkb' \
	! -name '*.pks'
