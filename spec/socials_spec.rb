require 'spec_helper'

describe PageRankr do
  describe "#socials" do
    subject{ PageRankr.social_trackers }

    it{ should include(:linked_in) }
    it{ should include(:pinterest) }
    it{ should include(:stumpled_upon) }
    it{ should include(:twitter) }
  end

  describe "#socials", :focus => true do
    describe "success" do
      subject do
        VCR.use_cassette(:success_socials, :record => :new_episodes) do
          PageRankr.socials("http://www.google.com")
        end
      end

      it{ should have_key(:linked_in) }
      it{ should have_key(:pinterest) }
      it{ should have_key(:stumpled_upon) }
      it{ should have_key(:twitter) }

      it{ subject[:linked_in].should > 500 }
      it{ subject[:pinterest].should > 70000 }
      it{ subject[:stumpled_upon].should > 20000 }
      it{ subject[:stumpled_upon].should > 100000 }
    end

    describe "failure" do
      subject do
        VCR.use_cassette(:failure_socials, :record => :new_episodes) do
          PageRankr.socials("http://please-dont-register-a-site-that-breaks-this-test.com")
        end
      end

      it{ should have_key(:linked_in) }
      it{ should have_key(:pinterest) }
      it{ should have_key(:stumpled_upon) }
      it{ should have_key(:twitter) }

      it{ subject[:linked_in].should == 0 }
      it{ subject[:pinterest].should == 0 }
      it{ subject[:stumpled_upon].should be_nil }
      it{ subject[:twitter].should == 0 }
    end
  end

end
