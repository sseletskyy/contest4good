require 'spec_helper'

describe Contest do
  before(:each) do
    Contest4good::create_roles
    @admin = fg.create(:admin)
    @contest = fg.create(:contest)
  end

  it 'should return correct committee_head_ids' do

    @contest.committee_head_ids = []
    @contest.save(validate: false)
    @contest.committee_head_ids.should eq([])

    @admin.add_role :committee_head, @contest
    @contest = Contest.find @contest.id
    @contest.committee_head_ids.should eq([@admin.id])

    @admin.remove_role :committee_head, @contest
    @contest = Contest.find @contest.id
    @contest.committee_head_ids.should eq([])

    @contest.committee_head_ids = @admin.id
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.committee_head_ids.should eq([@admin.id])

  end

  it 'test committee_head_ids_changed?' do
    original = @contest.committee_head_ids
    @contest.committee_head_ids_changed?.should be_false
    @contest.committee_head_ids = []
    @contest.committee_head_ids_changed?.should be_true
    @contest.committee_head_ids = original
    @contest.committee_head_ids_changed?.should be_false
  end

  it 'should return correct jury_head_ids' do

    @contest.jury_head_ids = []
    @contest.save(validate: false)
    @contest.jury_head_ids.should eq([])

    @admin.add_role :jury_head, @contest
    @contest = Contest.find @contest.id
    @contest.jury_head_ids.should eq([@admin.id])

    @admin.remove_role :jury_head, @contest
    @contest = Contest.find @contest.id
    @contest.jury_head_ids.should eq([])

    @contest.jury_head_ids = [@admin.id]
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.jury_head_ids.should eq([@admin.id])
  end

  it 'should return correct committee_vice_ids' do

    @contest.committee_vice_ids = []
    @contest.save(validate: false)
    @contest.committee_vice_ids.should eq([])

    @admin.add_role :committee_vice, @contest
    @contest = Contest.find @contest.id
    @contest.committee_vice_ids.should eq([@admin.id])

    @admin.remove_role :committee_vice, @contest
    @contest = Contest.find @contest.id
    @contest.committee_vice_ids.should eq([])

    @contest.committee_vice_ids = [@admin.id]
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.committee_vice_ids.should eq([@admin.id])
  end

  it 'should return correct jury_judge_ids' do

    @contest.jury_judge_ids = []
    @contest.save(validate: false)
    @contest.jury_judge_ids.should eq([])

    @admin.add_role :jury_judge, @contest
    @contest = Contest.find @contest.id
    @contest.jury_judge_ids.should eq([@admin.id])

    @admin.remove_role :jury_judge, @contest
    @contest = Contest.find @contest.id
    @contest.jury_judge_ids.should eq([])

    @contest.jury_judge_ids = [@admin.id]
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.jury_judge_ids.should eq([@admin.id])
  end
end
