Fly Commands
- `fly machine start 48e21ddb174998`
- `fly machine stop 48e21ddb174998`
- `fly ssh console -s -C 'sqlite3 "usr/home/data/db.sqlite" "SELECT * FROM guest"' > ~/Downloads/guest_list`
- `fly ssh console -s -C 'sqlite3 "usr/home/data/db.sqlite" "SELECT email FROM guest"'`
- `fly ssh console -s`
- `fly ssh sftp put /home/touny/Downloads/db.sqlite`
