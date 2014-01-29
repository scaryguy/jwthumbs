require 'jwthumbs'
require 'spec_helper.rb'

describe "movie" do
	
	describe "Check for file_path arguement" do
		subject(:movie) { Jwthumbs::Movie.new("fixtures/iki_dakka.mp4") }
		its(:file_path) { should == "fixtures/iki_dakka.mp4"}
	end

	describe "Checks for file existance" do
		it { expect { Jwthumbs::Movie.new("fixtures/ergerge.mp4") }.to raise_error Errno::ENOENT }
	end

	describe "spritefile name" do
		subject(:movie) { Jwthumbs::Movie.new("fixtures/iki_dakka.mp4") }
		its(:spritefile) { should == "iki_dakka_sprite.jpg"}
	end 

	describe "vttfile name" do
		subject(:movie) { Jwthumbs::Movie.new("fixtures/iki_dakka.mp4") }
		its(:vttfile) { should == "iki_dakka_thumbs.vtt"}
	end 

	describe "check for outdir " do
			subject(:movie) { Jwthumbs::Movie.new("fixtures/iki_dakka.mp4", use_unique_outdir: true) }
			its(:outdir) { should == "thumbs_#{Time.now.to_i.to_s}"}
	end

end

describe "shutter" do

	describe "options" do
		
		# let!(:movie) { Jwthumbs::Movie.new("fixtures/iki_dakka.mpg", use_unique_outdir: true) }	
		# let!(:shutter) { movie.stub(:create_thumbs) }
		# subject { shutter }

		# its(:options) { should == movie.options}
	end
	
end