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
    puts command = "scp cawel@le-tastevin.com:~/vinifera-db-backups/vinifera_production.#{Time.now.strftime("%Y.%m.%d")}.sql.gz db/dump/vinifera_production.sql.gz"
    system command
    `gunzip -f db/dump/vinifera_production.sql.gz`
  end

  desc "Load DB dump into local dev DB"
  task :load do
    puts command = "mysql -uroot -p vinifera_development < db/dump/vinifera_production.sql"
    system command
  end
end
