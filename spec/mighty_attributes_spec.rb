describe MightyAttributes do
  it "has a version number" do
    expect(MightyAttributes::VERSION).not_to be nil
  end

  context "if included into a class" do
    let(:klass) do
      Class.new do
        include MightyAttributes
      end
    end

    specify "the class should respond to :attribute" do
      expect(klass).to respond_to(:attribute)
    end

    describe ".attribute" do
      let(:attribute_name) { "some_attribute_name" }

      it "creates attribute accessors for the given name" do
        klass.attribute attribute_name, String
        some_instance = klass.new
        reader_name = attribute_name.to_sym
        writer_name = "#{attribute_name}=".to_sym
        some_value = "value"

        expect(some_instance).to respond_to(reader_name)
        expect(some_instance).to respond_to(writer_name)
        some_instance.send(writer_name, some_value)
        expect(some_instance.send(reader_name)).to eq(some_value)
      end

      context "if there exist methods with conflicting names" do
        let(:klass) do
          Class.new do
            include MightyAttributes

            def foo
            end

            def bar=(value)
            end
          end
        end

        it "raises an error" do
          expect { klass.attribute :foo, String }.to raise_error(MightyAttributes::MethodAlreadyDefinedError)
          expect { klass.attribute :bar, String }.to raise_error(MightyAttributes::MethodAlreadyDefinedError)
        end
      end
    end

    describe ".private" do
      let(:klass_without_patched_private) do
        Class.new do
          def foo; end
          def bar; end
          private [:foo, :bar]
        end
      end

      let(:klass_with_patched_private) do
        Class.new do
          include MightyAttributes

          def foo; end
          def bar; end
          def muff1; end
          def muff2; end
          def muff3; end

          private :muff1
          private :muff2, :muff3
          private [:foo, :bar]
        end
      end

      it "is patched in order to take an array of symbols (the result of .attribute)" do
        expect { klass_without_patched_private }.to raise_error(TypeError)
        expect(klass_with_patched_private.private_instance_methods).to include(:foo, :bar, :muff1, :muff2, :muff3)
      end
    end
  end
end
