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
			subject(:movie) { Jwthumbs::Movie.new("fixtures/iki_dakka.mp4") }
			its(:outdir) { should == "output/thumbs_#{Time.now.to_i.to_s}"}
	end

end

describe "File progresses" do

		before(:all) do
			@movie = Jwthumbs::Movie.new("fixtures/iki_dakka.mp4")	
		end

			let!(:outdir) { @movie.outdir}
			subject!(:shutter) { @movie.create_thumbs }
			

	describe "Shutter" do
		
		describe "should have same options with @movie" do
			its(:options) { should == @movie.options}
		end

		describe "should create output dir" do
			it { expect(File.directory?("output")).to eq true}
		end

		describe "should create outdir" do
			it { expect(File.directory?(outdir)).to eq true}
		end

		describe "should create thumbs" do
			it { expect(Dir[outdir].empty?).to eq false}
		end

		describe "should create sprite image" do
			it { expect(File.exists?("#{outdir}/iki_dakka_sprite.jpg")).to eq true}
		end

		describe "should have sprite" do
			its(:sprite)  {should be == "#{outdir}/iki_dakka_sprite.jpg" } 
		end
		
		
	end

	describe "VTT progresses" do
		
	end
	
end