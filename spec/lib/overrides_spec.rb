# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-conferences",
    files: {
      "/app/controllers/decidim/conferences/conferences_controller.rb" => "797899ada946b487a3c8c7312f0c14eb",
      "/app/models/decidim/conference.rb" => "8d7b097f3dc4d626b6972f380332b713"
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
    # rubocop:disable Rails/DynamicFindBy
    spec = ::Gem::Specification.find_by_name(item[:package])
    # rubocop:enable Rails/DynamicFindBy
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
