require 'spec_helper'

describe Cschat::MessageClassifier do
  let(:classifier) { Cschat::MessageClassifier.new data }
  let(:data) { nil }

  describe "#listener" do
    it "adds a listener for the given category" do
      classifier.listener(double, :cat1)
    end
  end

  context "with no data" do
    it "initialize" do
      expect(classifier).to_not be_nil
    end
  end

  context "with valid data" do
    let(:data) { [["cat1", "word1 word2 word3"], ["cat2", "word4 word5 word6" ]] }

    it "initialize" do
      expect(classifier).to_not be_nil
    end

    context "with category listeners" do
      let(:listener1) { double("listener1") }
      let(:listener2) { double("listener2") }
      let(:default_listener) { double("default listener") }
      let(:listeners) {[ listener1, listener2, default_listener ]}

      before(:each) do
        classifier.listener(listener1, :cat1)
        classifier.listener(listener2, :cat1)
        classifier.listener(default_listener)
      end

      describe "#classify" do
        context "for a classified text" do
          it "notifies listeners" do
            listeners.each { |l| expect(l).to receive(:process_message).with(:cat1, "word1") }
            classifier.classify("word1")
          end
        end

        context "for a unclassified text" do
          it "notifies default listeners" do
            expect(default_listener).to receive(:process_message).with(nil, "foo")
            classifier.classify("foo")
          end
        end
      end
    end

    context "with only default listeners" do
      let(:default_listener) { double("default listener") }

      it "always notifies default listener" do
        classifier.listener(default_listener)
        expect(default_listener).to receive(:process_message).with(:cat1, "word1")
        classifier.classify("word1")
      end
    end
  end
end
