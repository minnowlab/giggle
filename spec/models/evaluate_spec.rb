require 'rails_helper'

describe Evaluate do
  it "has a valid factory" do
    expect(create(:evaluate)).to be_valid 
  end

  describe 'is invalid without a params' do
    it { expect(build(:nil_title_evaluate)).to have(1).errors_on(:title) }
    it { expect(build(:nil_details_evaluate)).to have(1).errors_on(:details) }
    it { expect(build(:nil_product_id_evaluate)).to have(1).errors_on(:product_id) }
    it { expect(build(:nil_user_id_evaluate)).to have(1).errors_on(:user_id) }
  end
end
