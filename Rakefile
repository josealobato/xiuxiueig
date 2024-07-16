require 'fileutils'
require 'rake'

# Load all rake files in the project
Dir.glob('Xiuxiueig_iOS/**/*.rake').each { |r| load r }

task :default do
  puts "Run `rake -T` to learn about the available actions."
end


desc "Generate mocks. Needs `brew install sourcery`."
task :mocks do
  puts "Running all mocks..."
  # For every task in the rake file and the ones loaded gets the one
  # that belongs to the mocks namespace and invoke them.
  Rake::Task.tasks.each do |t|
    if t.name.start_with?('mocks:')
      Rake::Task[t.name].invoke
    end
  end
end

desc "Run the All Test test plan"
task :ut do
  puts "Running the All tests plan..."
  scheme = "Xiuxiueig_iOS"
  configuration = 'Debug'
  test_plan = 'Xiuxiueig_iOS_AllTests'
  destination = 'platform=iOS Simulator,name=iPhone 15,OS=17.5'

  sh "set -oe pipefail && xcodebuild -scheme #{scheme} -configuration #{configuration} -testPlan #{test_plan} -destination '#{destination}' test | xcpretty"

end

