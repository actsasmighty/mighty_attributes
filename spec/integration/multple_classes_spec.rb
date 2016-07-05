require "active_model"
require "mighty_attributes"

describe "Integration tests" do
  describe "complex aggregation of multiple classes" do
    it do
      class Item
        include ActiveModel::Model
        include MightyAttributes

        attribute :grading, Symbol
      end

      class Record
        include ActiveModel::Model
        include MightyAttributes

        attribute :title, String
        attribute :items, Array[Item]
      end

      class Collection
        include ActiveModel::Model
        include MightyAttributes

        attribute :name, String
        attribute :records, Array[Record]
      end

      collection = Collection.new(
        name: "Journal about something",
        records: [
          {
            title: "Volume 1",
            items: [
              {
                grading: :good
              },
              {
                grading: :poor
              }
            ]
          }
        ]
      )
    end
  end
end
