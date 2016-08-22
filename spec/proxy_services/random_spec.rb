require 'spec_helper'

describe PageRankr::ProxyServices::Random do
  let(:proxies) do
    [
      "user:password@192.168.1.1:50501",
      "bob:smith@127.0.0.1:3000"
    ]
  end
  let(:site){PageRankr::Site("http://www.google.com")}
  let(:name){:ranks_google}
  subject{PageRankr::ProxyServices::Random.new(proxies)}

  it{should respond_to(:proxy).with(2).arguments}

  it "should return a proxy from the list of proxies" do
    10.times do
      expect(proxies).to include(subject.proxy(name, site))
    end
  end
end
