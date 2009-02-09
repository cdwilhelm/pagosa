require 'rake/tasklib'

# Database Fixture/seed-data population.
module Populate
  def define_tasks
    All.new
    Test.new
    FixturesFilename.new
    PeopleImages.new
    desc "Drops the database and reloads the schema sample data from scratch."
    task :repopulate => ["db:drop", "db:create", "db:migrate", "db:populate"]

    desc "Updates the database with any pending migrations and/or data to be populated. Preferred over plain db:migrate"
    task :update => ["db:migrate", "db:populate"]
  end
  module_function :define_tasks

  class Base < Rake::TaskLib
    def initialize
      define
    end
    def fixtures_dir
      File.join(RAILS_ROOT, 'db', 'fixtures')
    end
    def fixtures_filename
      File.join fixtures_dir, 'fixtures_dump.sql'
    end
  end

  class FixtureScript
    def initialize(file)
      @fixture = file
      @name = File.basename(@fixture)
      @already_run = ActiveRecord::Base.connection.select_one(
        "select script_name from populate_scripts where script_name = '#@name'")
    end

    def run
      if @already_run
        puts "Skipping #@name"
      else
        puts "Loading #@name..."
        begin
          load @fixture
          ActiveRecord::Base.connection.execute("insert into populate_scripts (script_name) values ('#@name')")
        rescue => e
          $stderr.puts e, *(e.backtrace)
          raise e
        end
      end
    end
  end

  # to start at a specific step: rake db:populate start=20
  class All < Base
    def ensure_populate_scripts_table
      unless ::ActiveRecord::Base.connection.tables.include?("populate_scripts")
        migration = Class.new(::ActiveRecord::Migration)
        def migration.up
          create_table :populate_scripts, :id => false do |t|
            t.column :script_name, :string, :null => false
          end
        end
        migration.up
      end
    end

    def find_scripts_to_run
      env = ENV['RAILS_ENV'] || RAILS_ENV
      Dir[File.join(fixtures_dir, '*.rb'), File.join(fixtures_dir, env, '*.rb')].sort_by {|f|
        File.basename(f) }
    end

    def define
      desc "Loads initial database models for the current environment."
      task :populate => :environment do
        ActiveRecord::Base.disable_observers if ActiveRecord::Base.respond_to?(:disable_observers)
        ensure_populate_scripts_table
        ActiveRecord::Base.transaction do
          find_scripts_to_run.each do |fixture|
            FixtureScript.new(fixture).run
          end
        end
        rm_f fixtures_filename
      end

      task :migrate do
        rm_f fixtures_filename
      end
    end
  end

  class Test < Base
    def define
      task :populate_test do
        if Rake::Task[fixtures_filename].needed?
          Rake::Task[fixtures_filename].invoke
        else
          env = "test"
          abcs = ActiveRecord::Base.configurations
          case abcs[env]["adapter"]
          when /mysql/
            pass = ''
            pass = "-p#{abcs[env]['password']}" unless abcs[env]['password'].nil? || abcs[env]['password'].empty?
            sh "mysql -u#{abcs[env]['username']} #{pass} -D#{abcs[env]['database']} < #{fixtures_filename}"
          when /postgres/
            sh "psql -U #{abcs[env]['username']} #{abcs[env]['database']} < #{fixtures_filename}"
          end
        end
      end

      task "test:prepare" do
        Rake::Task["db:populate_test"].invoke
      end
    end
  end

  class FixturesFilename < Base
    def define
      file fixtures_filename do |t|
        env = "test"
        ENV["RAILS_ENV"] = env
        Rake::Task["db:populate"].invoke
        abcs = ActiveRecord::Base.configurations
        case abcs[env]["adapter"]
        when /mysql/
          pass = ''
          pass = "--password=#{abcs[env]['password']}" unless abcs[env]['password'].nil? || abcs[env]['password'].empty?
          host = ''
          host = "-h#{abcs[env]['host']}" unless abcs[env]['host'].nil? || abcs[env]['host'].empty? || abcs[env]['host'] == "localhost"
          sh "mysqldump -u#{abcs[env]['username']} #{pass} #{host} --skip-triggers --compact --no-create-info #{abcs[env]['database']} | egrep -v 'populate_scripts|schema_migrations' > #{t.name}" do |ok, res|
            unless ok
              rm_f fixtures_filename
              fail "mysqldump failed. is it on your PATH?"
            end
          end
        when /postgres/
          sh "pg_dump --data-only -U #{abcs[env]['username']} #{abcs[env]['database']} | egrep -v 'populate_scripts|schema_migrations' > #{t.name}" do |ok, res|
            unless ok
              rm_f fixtures_filename
              fail "pg_dump failed. is it on your PATH?"
            end
          end
        end
      end
    end
  end

  class PeopleImages < Base
    def define
      desc "adds images for people who have images available"
      task :add_people_images => :environment do
        Person.find(:all).each do |person|
          image_path=File.join(RAILS_ROOT, %w(db fixtures development people_images), "#{person.display_name.sub(' ','')}.jpg" )
          if (File.exists?(image_path))
            data=File.open(image_path).read
            person.image=PersonImage.new(:content_type=>'image/jpeg', :filename=>"#{person.username}.jpg",:temp_data=>data, :size=>data.size)
            person.save
            puts "added image to #{person.display_name}"
          else
            puts "skipping #{person.display_name} -- no image available in #{image_path}"
          end
        end
      end
    end
  end
end
