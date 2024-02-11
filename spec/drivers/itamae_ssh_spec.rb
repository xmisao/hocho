require 'spec_helper'
require 'hocho/drivers/itamae_ssh'
require 'hocho/host'

RSpec.describe Hocho::Drivers::ItamaeSsh do
  let(:driver) { described_class.new(host) }

  describe "run" do
    let(:host) { Hocho::Host.new("host" ) }

    before do
      allow(driver).to receive(:with_node_json_file).and_yield("/path/to/node-json-file")
    end

    subject { driver.run }

    it "run itamae" do
      expect(driver).to receive(:system).with(
        {},
        "itamae",
        "ssh",
        "-j",
        "/path/to/node-json-file",
        "-h",
        "host",
        "--color",
        {:chdir=>"."}
      ).once.and_return(true)

      subject
    end
  end
end
