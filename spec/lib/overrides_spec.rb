# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-conferences",
    files: {
      "/app/controllers/decidim/conferences/conferences_controller.rb" => "4c882d0666bc51a989911dd1644bc8b2",
      "/app/models/decidim/conference.rb" => "d88512adfce7c31f7dbf3d3294b3d27e",
      "/app/cells/decidim/conferences/content_blocks/highlighted_conferences_cell.rb" => "32a85da2c47404962b0758ad3e19c40c"
    }
  },
  {
    package: "decidim-core",
    files: {
      "/app/cells/decidim/statistic_cell.rb" => "0da539ceb425bd2da50e795428767dba",
      "/app/cells/decidim/content_blocks/hero/cta_button.erb" => "60210020a582198f0048d9c3890f552c",
      "/app/cells/decidim/content_blocks/sub_hero/show.erb" => "1624a0f9382010481af8c2b94bdd61fe",
      "/app/cells/decidim/content_blocks/highlighted_content_banner/show.erb" => "a632afe2eaa4b97f35ec05615c3ab085",
      "/app/cells/decidim/card_g_cell.rb" => "8fb136b5ba22dd0a34ac913479018542"
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
