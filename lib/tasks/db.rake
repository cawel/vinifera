namespace :db do
	desc "Dump the current prod DB"
	task :dump do
    # TODO: for now I need to call my dump.sh script server-side
		# puts command = "ssh cawel@le-tastevin.com ; mysqldump -uroot -p -r vinifera_production.sql"
		puts command = "ssh cawel@le-tastevin.com"
		system command
	end

	desc "Fetch the latest lying prod DB dump"
	task :fetch => :dump do
		puts command = "scp cawel@le-tastevin.com:~/vinifera-db-backups/vinifera_production.#{Time.now.strftime("%Y.%m.%d")}.sql.gz db/dump/"
		system command
     `gunzip -f db/dump/vinifera_production.#{Time.now.strftime("%Y.%m.%d")}.sql.gz`
	end
end
