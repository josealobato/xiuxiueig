require 'fileutils'
require 'rake'

# Load all rake files in the project
Dir.glob('Xiuxiueig_iOS/**/*.rake').each { |r| load r }

task :default do
  puts "Run `rake -T` to learn about the available actions."
end


desc "Generate mocks. Needs `brew install sourcery`."
task :all_mocks do
  puts "Running all mocks..."
  # For every task in the rake file and the ones loaded gets the one
  # that belongs to the mocks namespace and invoke them.
  Rake::Task.tasks.each do |t|
    if t.name.start_with?('mocks:')
      Rake::Task[t.name].invoke
    end
  end
end

