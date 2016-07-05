require "active_model"
require "mighty_attributes"

describe "Examples" do
  describe "single user class" do
    it do
      class User
        include ActiveModel::Model
        include MightyAttributes

        attribute :name

        private attribute :role, default: :guest

        def guest?
          role == :guest
        end
      end

      user = User.new(name: "Max Mustermann")

      expect(user).to respond_to(:guest?)
      expect(user.guest?).to be(true)
    end
  end
end
