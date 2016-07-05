require "active_model"
require "mighty_attributes"

describe "Integration tests" do
  describe "complex aggregation of multiple classes" do
    it do
      class Item
        include ActiveModel::Model
        include ActiveModel::Serializers::JSON
        include MightyAttributes

        attribute :grading, Symbol
        attribute :price, Float, serialize: false
      end

      class Record
        include ActiveModel::Model
        include ActiveModel::Serializers::JSON
        include MightyAttributes

        attribute :title, String
        attribute :items, Array[Item]
      end

      record = Record.new(
        title: "Volume 1",
        items: [
          {
            grading: :good,
            price: 1.2
          },
          {
            grading: :poor,
            price: 2.4
          }
        ]
      )

      binding.pry
      record.as_json
    end
  end
end
