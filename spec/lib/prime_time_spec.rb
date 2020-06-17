describe PrimeTime, type: :service do
  subject(:result) { PrimeTime.prime_time(current_time, schedule: schedule) }

  let(:current_time) { Time.current }
  let(:schedule) {
    [
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
      ["11:30", "21:00"],
    ]
  }

  shared_examples "a service that returns expected prime time" do
    before { travel_to travel_to_time }

    it { expect(result).to eq(expecting_time) }
  end

  context "when current time is within current prime time range" do
    let(:travel_to_time) { Time.zone.local(2020, 4, 20, 14, 0, 0) }
    let(:expecting_time) { Time.zone.local(2020, 4, 20, 14, 0, 0) }

    it_behaves_like "a service that returns expected prime time"
  end

  context "when current time in advance of current prime time range" do
    context "when now is Monday" do
      let(:travel_to_time) { Time.zone.local(2020, 4, 20, 9, 0, 0) }
      let(:expecting_time) { Time.zone.local(2020, 4, 20, 11, 30, 0) }
      it_behaves_like "a service that returns expected prime time"
    end

    context "when now is Sunday" do
      let(:travel_to_time) { Time.zone.local(2020, 4, 26, 9, 0, 0) }
      let(:expecting_time) { Time.zone.local(2020, 4, 26, 11, 30, 0) }
      it_behaves_like "a service that returns expected prime time"
    end
  end

  context "when current time later than current prime time range" do
    context "when now is Monday" do
      let(:travel_to_time) { Time.zone.local(2020, 4, 20, 23, 0, 0) }
      let(:expecting_time) { Time.zone.local(2020, 4, 21, 11, 30, 0) }
      it_behaves_like "a service that returns expected prime time"
    end

    context "when now is Sunday" do
      let(:travel_to_time) { Time.zone.local(2020, 4, 26, 23, 0, 0) }
      let(:expecting_time) { Time.zone.local(2020, 4, 27, 11, 30, 0) }
      it_behaves_like "a service that returns expected prime time"
    end
  end
end
