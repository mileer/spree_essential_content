module SpreeEssentialContent
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        append_file 'app/assets/javascripts/frontend/all.js', "//= require frontend/spree_essential_content"
        append_file 'app/assets/javascripts/backend/all.js', "//= require backend/spree_essential_content"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/frontend/all.css', " *= require frontend/spree_essential_content", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/backend/all.css', " *= require backend/spree_essential_content", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_essential_content'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
