require './helpers/colour_helpers'

class HelperWrapper; include Helpers; end

describe Helpers do
	
	let(:helper){HelperWrapper.new}

	it "should return value-provided when there is a value" do
		expect(helper.colour_class(1,2,3,4)).to eq("value-provided")
	end

	it 'should return incorrect when there is not a value' do
		expect(helper.colour_class(1, 1, '', 3)).to eq("incorrect")
	end
end
