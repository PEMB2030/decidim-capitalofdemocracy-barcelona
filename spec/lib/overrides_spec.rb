# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-conferences",
    files: {
      "/app/controllers/decidim/conferences/conferences_controller.rb" => "4e1bd7427cfd12c79391b451e07a2e2a",
      "/app/models/decidim/conference.rb" => "095732cb2451adfb9db7a46078dc3a51",
      "/app/cells/decidim/conferences/content_blocks/highlighted_conferences_cell.rb" => "7f24462f802a2c277697205511103d90"
    }
  },
  {
    package: "decidim-core",
    files: {
      "/app/cells/decidim/statistic_cell.rb" => "b6f5eb0ab09653dc5633656b84fc2f7b"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])
    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
