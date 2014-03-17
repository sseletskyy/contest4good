require 'spec_helper'

describe Contest do
  before(:each) do
    Contest4good::create_roles
  end

  it 'should return correct committee_head_ids' do
    admin = fg.create(:admin)
    contest = fg.create(:contest)

    contest.committee_head_ids = []
    contest.save
    contest.committee_head_ids.should eq([])

    admin.add_role :committee_head, contest
    contest = Contest.find contest.id
    contest.committee_head_ids.should eq([admin.id])

    admin.remove_role :committee_head, contest
    contest = Contest.find contest.id
    contest.committee_head_ids.should eq([])

    contest.committee_head_ids = [admin.id]
    contest.save
    contest = Contest.find contest.id
    contest.committee_head_ids.should eq([admin.id])

  end

  it 'should return correct jury_head_ids' do
    admin = fg.create(:admin)
    contest = fg.create(:contest)

    contest.jury_head_ids = []
    contest.save
    contest.jury_head_ids.should eq([])

    admin.add_role :jury_head, contest
    contest = Contest.find contest.id
    contest.jury_head_ids.should eq([admin.id])

    admin.remove_role :jury_head, contest
    contest = Contest.find contest.id
    contest.jury_head_ids.should eq([])

    contest.jury_head_ids = [admin.id]
    contest.save
    contest = Contest.find contest.id
    contest.jury_head_ids.should eq([admin.id])
  end
end
