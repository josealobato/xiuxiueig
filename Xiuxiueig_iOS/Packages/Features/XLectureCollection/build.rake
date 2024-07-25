require 'rake'

namespace :mocks do

  task :gen_mocks do
    feat_name = "XLectureCollection"
    puts "\n....Generate #{feat_name} mocks #{Dir.pwd} "
    # The following two variables should be injected as parameters on the rake
    # task in the parent rake file. Under investigation
    prefix_path = "Xiuxiueig_iOS/Packages/Features/XLectureCollection"
    dependency_prefix_path = "Xiuxiueig_iOS/Packages"
    # The command to execute
    command = <<-eos
    sourcery \
      --sources ./#{prefix_path}/Sources \
      --sources ./#{dependency_prefix_path}/XCoordinator/Sources \
      --templates ./Templates/AutoMockable.stencil \
      --args testimports="@testable import #{feat_name}; import XEntities; import XCoordinator;" \
      --output ./#{prefix_path}/Tests/#{feat_name}Tests/Generated/AutoMockable.generated.swift
    eos
    # Execute 
    system(command)
  end
end
